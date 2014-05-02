;; Apr. 29, 2014
;;
;; LoadDynamiX Inc.
;;
;; CDB code generator.


;; circular files references
(if (not (defined? 'all-cdbs.scm))
  (load "all-cdbs.scm"))


(define *max-values-count-to-expand* (expt 2 4))


(define (print fmt . args)
  (apply format #t fmt args))


(define (print-if x fmt)
  (if x (print fmt x)))


(define-syntax redirect-print
  (syntax-rules ()
    ((redirect-print (fname) body ...)
     (let* ((orig-print print)
            (o-port (open-output-file fname))
            (redirected-print (lambda (fmt . args)
                                (display (apply format #f fmt args) o-port))))
       (print "*** OUTPUT REDIRECTED TO '~a'~%" fname)
       (set! print redirected-print)
       (let ((res (begin body ...)))
         (set! print orig-print)
         (close-output-port o-port)
         (print "*** DONE~%" fname)
         res)))))


(define (string-or-number? x) (or (string? x) (number? x)))


;; return list so that head of this list matches given pattern
;; return #f in there's no match
;; example: 
;;   (match (list number? number?) '("hello" 3 4 "there"))
;;   -> (3 4 "there")
(define (match pattern ls)
  (define (^? ls) (and (not (null? ls)) (eq? '^ (car ls))))
  (let ((start-of-line? (^? pattern)))
    (let loop ((p (if start-of-line? (cdr pattern) pattern)) (s ls))
      (define (try-next)
        (if start-of-line? #f
          (match pattern (cdr ls))))
      (cond ((null? p) ls) ;; match found
            ((null? s) #f) ;; match not found
            ((procedure? (car p))
             (if ((car p) (car s)) 
               (loop (cdr p) (cdr s))
               (try-next)))
            ((string? (car p))
             (if (and (string? (car s)) (string=? (car p) (car s))) 
               (loop (cdr p) (cdr s))
               (try-next)))
            (else 
              (if (equal? (car p) (car s)) 
                (loop (cdr p) (cdr s))
                (try-next)))))))


(define (cdb-property cdb key what on-error)
  (let ((x (match (list key what) cdb)))
    (if x (cadr x)
      (if (not on-error) #f
        (error on-error)))))

;; CDB name, mandatory
(define (cdb-name cdb) (cdb-property cdb 'name: string? "CDB name not found"))

;; CDB description, optional
(define (cdb-description cdb) (cdb-property cdb 'desc: string? #f))

;; CDB tag, optional
(define (cdb-tag cdb) (cdb-property cdb 'tag: string? #f))

;; CDB size, optional
(define (cdb-size cdb) (cdb-property cdb 'size: number? #f))


;; CDB parameters, mandatory
(define (cdb-parameters cdb)
  (let ((x (match (list 'parameters: list?) cdb)))
    (if x (cdr x)
      (error "CDB parameters not found"))))


;; create parameter address: bytes and bits this parameter occupies
(define (make-pa byte-lo byte-hi bit-lo bit-hi)
  (list (min byte-lo byte-hi) 
        (max byte-lo byte-hi) 
        (min bit-lo bit-hi)
        (max bit-lo bit-hi)))


;; bits within single byte
(define (make-pa-bits byte bit-lo bit-hi)
  (make-pa byte byte bit-lo bit-hi))

;; single bit within single byte
(define (make-pa-bit byte bit)
  (make-pa byte byte bit bit))

;; whole byte
(define (make-pa-byte byte)
  (make-pa byte byte 0 7))

;; several bytes
(define (make-pa-bytes byte-lo byte-hi)
  (if (= byte-lo byte-hi) (make-pa-byte byte-lo)
    (make-pa byte-lo byte-hi 0 0)))

(define (pa-byte-lo pa) (car pa))
(define (pa-byte-hi pa) (cadr pa))
(define (pa-bit-lo pa)  (caddr pa))
(define (pa-bit-hi pa)  (cadddr pa))

;; return # of bits this parameter occupies
(define (pa-length pa)
  (let ((byte-lo (car pa))
        (byte-hi (cadr pa))
        (bit-lo  (caddr pa))
        (bit-hi  (cadddr pa)))
    (if (= byte-lo byte-hi) (+ 1 (- bit-hi bit-lo))
      (* 8 (+ 1 (- byte-hi byte-lo))))))


;; compute total # of possible values of the parameter
(define (pa-values-count pa)
  (expt 2 (pa-length pa)))


;; return name of the parameter (or #f in there's no name)
(define (param-name param)
  (cond ((null? param) #f)
        ((string? (car param)) (car param))
        (else (param-name (cdr param)))))

;; return value of the parameter (or #f if there's no value)
(define (param-value param)
  (cond ((null? param) #f)
        ((null? (cdr param)) #f)
        ((symbol? (car param)) #f)
        ((and (string? (car param)) (number? (cadr param))) (cadr param))
        ((and (string? (car param)) (string? (cadr param))) (cadr param))
        (else (param-value (cdr param)))))


;; retunr list of possible values of #f
(define (param-values param)
  (let ((x (match (list 'values:) param)))
    (if (not x) #f
      (let ((res (cdr x)))
        (if (null? res) #f
          (if (not (symbol? (car res))) res
            (let* ((tab-name (car res))
                   (tab      (match (list tab-name) *cdb-values-tables*)))
              (if (not tab) #f
                (if (null? (cdr tab)) #f
                  (cdr tab))))))))))


;; return first value from the list of possible values
(define (values-value x)
  (cond ((null? x) #f)
        ((symbol? (car x)) #f)
        (else (car x))))


;; return first value description from the list of possible values
(define (values-descr x)
  (cond ((null? x) (error "values-descr"))
        ((null? (cdr x)) (error "values-descr"))
        ((symbol? (cadr x)) (error "values-descr"))
        ((not (string? (cadr x))) (error "values-descr"))
        (else (cadr x))))

;; skip first value/description pair from the list of possible values
;; return #f if list ends
(define (values-next x)
  (let ((n (cddr x)))
    (if (null? n) #f
      (if (not (number? (car n))) #f
        n))))


;; return default value of the paremeter.
;; return 'y' if no default value defined.
(define (param-default param y)
  (let ((x (match (list 'default: identity) param)))
    (if x (cadr x) y)))


;; return default value of parameter if it has a list of possible values
(define (param-default-as-list param y)
  (let ((a (param-default param #f))
        (b (param-values param)))
    (cond ((and a b)
           (let ((x (match (list a) b)))
             (if x (values-descr x)
               (values-descr b))))
          (b (values-descr b))
          (a a)
          (else y))))


;; return byte where given parameter starts
(define (param-byte param)
  (car param))


;; return address of the parameter: pair of bytes and pair of bits
(define (param-addr param)
  (let ((bits  (match (list 'bits: number? number?) param))
        (bit   (match (list 'bit: number?) param))
        (bytes (match (list '^ number? number?) param))
        (byte  (match (list '^ number?) param)))
    (cond (bits  (make-pa-bits  (param-byte param) (cadr bits) (caddr bits)))
          (bit   (make-pa-bit   (param-byte param) (cadr bit)))
          (bytes (make-pa-bytes (car bytes) (cadr bytes)))
          (byte  (make-pa-byte  (car byte)))
          (else  (error "param-addr: can't find parameter address")))))


(define (bits-string len)
  (if (= 1 len)
    (format #f "1 bit")
    (format #f "~a bits" len)))


;; turn name into identifier
(define (name->ident name)
  (define (id-char? c) (string-index "abcdefghijklmnopqrstuvwxyz0123456789" (char-downcase c)))
  (if (not name) #f
    (string-map 
      (lambda (c) (if (id-char? c) c #\_))
      name)))


(define (addr-as-c-comment pa)
  (define (pad-right len s)
    (if (= len (string-length s)) s
      (pad-right len (string-append s " "))))
  (let ((byte-lo (pa-byte-lo pa))
        (byte-hi (pa-byte-hi pa)))
    (string-append
      (pad-right 8
        (if (= byte-lo byte-hi)
          (format #f "/* ~a" byte-lo)
          (format #f "/* ~a-~a" byte-lo byte-hi)))
      "*/")))


(define (param-struct-name prm cdb)
  (define (append-name name new-name)
    (if (string=? name "") new-name
      (format #f "~a_~a" name new-name)))

  (define (append-comment comment pname pval paddr)
    (let ((new-comment 
            (format #f "~a: ~a~a" pname 
                    (if (not pval) ""
                      (format #f "~a, " pval))
                    (if (= (pa-length paddr) 1)
                      (format #f "bit ~a" (pa-bit-lo paddr))
                      (format #f "bits ~a-~a" (pa-bit-lo paddr) (pa-bit-hi paddr))))))
      (if (string=? comment "") new-comment
        (format #f "~a, ~a" comment new-comment))))

  (let ((pos  (pa-byte-lo (param-addr prm)))
        (name (param-name prm)))
    (let ((same-pos-params (filter (lambda (p) (= pos (pa-byte-lo (param-addr p))))
                                   (cdb-parameters cdb))))
      (let loop ((struct-name "") (comment "") (count 0) (index 0) (s same-pos-params))
        (if (null? s) (values (name->ident struct-name) comment index)
          (let ((pname (param-name  (car s)))
                (pval  (param-value (car s)))
                (paddr (param-addr  (car s))))
            (loop (append-name struct-name pname)
                  (append-comment comment pname pval paddr)
                  (+ 1 count)
                  (if (string=? name pname) count
                    index)
                  (cdr s))))))))


(define (param-xml-name prm cdb)
  (let ((tag  (cdb-tag cdb))
        (name (param-name prm)))
    (if (not tag) name
      (format #f "~a ~a" tag name))))


(define (param-id prm cdb)
  (let* ((ident (name->ident (param-name prm)))
         (tag   (cdb-tag cdb)))
    (cond ((not ident)  #f)
          ((not tag)    (string-append "ID_" (string-upcase ident)))
          (else         (format #f "ID_~a_~a" tag (string-upcase ident))))))


;; XML presentation of CDB
(define (cdb->xml cdb)
  (print-if (cdb-description cdb) "<!-- ~a -->~%~%")
  (print "<!-- ~a -->~%" (cdb-name cdb))
  (print "~%")
  (for-each 
    (lambda (prm)
        (let* ((name  (param-name prm))
               (value (param-value prm))
               (vlist (param-values prm))
               (addr  (param-addr prm))
               (len   (pa-length addr)))
          (cond ((and name value) 
                 ;; both name and value defined: no need for user input
;;                 (print "<!-- ~a (~a), ~a long -->~%" name value (bits-string len))
;;                 (print "~%"))
                  #f)

                ((and name (not value))
                 ;; name but no value: user input needed
                 (print "<!-- ~a, ~a long -->~%" name (bits-string len))
                 (print "<parameter name=\"~a\" caption=\"~a\"" (param-xml-name prm cdb) name)
                 (cond (vlist
                        ;; user-defined list of values
                        (print " type=\"List\" default=\"~a\" >~%" (param-default-as-list prm "0"))
                        (print "  <options>~%")
                        (let loop ((vlist vlist))
                          (if vlist
                            (begin
                              (print "    <option value=\"~a\" int_value=\"~a\" />~%" 
                                      (values-descr vlist) (values-value vlist))
                              (loop (values-next vlist)))))
                        (print "  </options>~%"))

                       ((> *max-values-count-to-expand* (pa-values-count addr))
                        ;; as list of possible values
                        (print " type=\"List\" default=\"~a\" >~%" (param-default prm "0"))
                        (print "  <options>~%")
                        (for-each 
                          (lambda (v)
                            (print "    <option value=\"~a\" int_value=\"~a\" />~%" v v))
                          (iota (pa-values-count addr)))
                        (print "  </options>~%"))

                       (else
                        ;; as integer with range
                        (print " type=\"Integer\" default=\"~a\" >~%" (param-default prm "0"))
                        (print "  <conditions>~%")
                        (print "    <condition type=\"RangeCondition\" minValue=\"0\" maxValue=\"~a\" action=\"NoError\" />~%" 
                               (- (pa-values-count addr) 1))
                        (print "  </conditions>~%")))
                 (print "</parameter>~%")
                 (print "~%"))

                (else #f))))
    (cdb-parameters cdb))
  (print "~%"))


(define (xml-group g)
  (let* ((vis       (match (list 'visible: string? string-or-number?) g))
         (vis-name  (if vis (cadr vis)
                      (error "xml-group: visibility not defined")))
         (vis-value (caddr vis))
         (members   (match (list 'members:) g))
         (cdbs      (if members (cdr members)
                      (error "xml-group: members not defined")))
         (first-cdb (if (not (null? cdbs)) (car cdbs)
                      (error "xml-group: empty group")))
         (gname     (cdb-description first-cdb)))

    (if (not gname) (error "xml-group: no group descripion"))

    (print "<!-- ~a -->~%" gname)
    (print "<parameter name=\"~a\" type=\"Group\">~%" gname)
    (print "  <conditions>~%")
    (print "    <condition type=\"ValueCondition\" parameter=\"~a\" value=\"~a\" action=\"Visible\" />~%"
           vis-name vis-value)
    (print "  </conditions>~%")
    (print "  <parameters>~%")
    (for-each cdb->xml cdbs)
    (print "  </parameters>~%")
    (print "</parameter> <!-- end of ~a -->~%" gname)
    (print "~%" )))


;; list of IDs for given CDB
(define (cdb->id-list cdb)
  (print "/* ~a */~%" (cdb-name cdb))
  (print "enum~%")
  (print "{~%")
  (let loop ((p (cdb-parameters cdb)) (n 0))
    (if (null? p) #f
      (let ((name  (param-name  (car p)))
            (value (param-value (car p)))
            (id    (param-id    (car p) cdb)))
        (if (and name (not value))
          (begin
            (print "\t~a,~%" id)
            (loop (cdr p) (+ 1 n)))
          (loop (cdr p) n)))))
  (print "};~%")
  (print "~%"))


;; list of parameters for given CDB
(define (cdb->param-list cdb)
  (print "/* ~a */~%" (cdb-name cdb))
  (for-each 
    (lambda (prm)
        (let* ((name  (param-name prm))
               (value (param-value prm))
               (id    (param-id prm cdb))
               (xname (param-xml-name prm cdb)))
          (if (and name (not value))
            (print "AddDefinition( ~a, \"~a\", SWIDATA_INT, \"~a\" );~%"
                   id xname (param-default prm "0")))))
    (cdb-parameters cdb))
  (print "~%"))


;; code that gets parameters values for given CDB
(define (cdb->get-params cdb)
  (print "/* ~a */~%" (cdb-name cdb))
  (for-each
    (lambda (prm)
      (let* ((name  (param-name prm))
             (id    (param-id prm cdb))
             (value (param-value prm))
             (addr  (param-addr prm))
             (bit-lo(pa-bit-lo addr))
             (len   (pa-length addr)))
        (if (and name (not value))
          (case len
            ((64 32 16)      (print "GetCurrentValue( ~a )->GetUint~a();~%" id len))
            ((24)            (print "GetCurrentValue( ~a )->GetUint32();~%" id))
            ((8)             (print "GetCurrentValue( ~a )->GetByte();~%" id))
            ((7 6 5 4 3 2 1) (print "GetCurrentValue( ~a )->GetByte()~a;~%" id
                                    (if (zero? bit-lo) ""
                                      (format #f " << ~a" bit-lo))))
            (else 
              (error (format #f "cdb->get-params: bad parameter length: ~a" len)))))))
    (cdb-parameters cdb))
  (print "~%"))


;; code that populates parameters of given CDB
(define (cdb->cdb cdb)
  (print "/* ~a */~%" (cdb-name cdb))
  (for-each
    (lambda (prm)
      (let* ((name  (param-name prm))
             (id    (param-id prm cdb))
             (ident (name->ident name))
             (value (param-value prm))
             (addr  (param-addr prm))
             (bit-lo(pa-bit-lo addr))
             (len   (pa-length addr)))
        (if name
          (case len
            ((64 32 16) 
             (print "cdb->~a = htobe~a( ~a );~%" ident len
                     (if value value
                       (format #f "GetCurrentValue( ~a )->GetUint~a()" id len))))

            ((24) 
             (print "htobe24( cdb->~a, ~a );~%" ident
                     (if value value
                       (format #f "GetCurrentValue( ~a )->GetUint32()" id))))

            ((8) 
             (print "cdb->~a = ~a;~%" ident
                     (if value value
                       (format #f "GetCurrentValue( ~a )->GetByte()" id))))

            ((7 6 5 4 3 2 1)
             (let-values (((struct-name comment index) (param-struct-name prm cdb)))
               (print "cdb->~a ~a ~a~a;~%" struct-name
                      (if (zero? index) "="
                        "|=")
                      (if value value
                        (format #f "GetCurrentValue( ~a )->GetByte()" id))
                      (if (zero? bit-lo) ""
                        (format #f " << ~a" bit-lo)))))

            (else 
              (error (format #f "cdb->cdb: bad parameter length: ~a" len)))))))
    (cdb-parameters cdb))
  (print "~%"))


;; c-structure that represents given CDB
(define (cdb->c-struct cdb)

  (define (cdb-parameters-size cdb)
    (let loop ((s 0) (p (cdb-parameters cdb)))
      (if (null? p) (+ 1 s)
        (loop (max s (pa-byte-hi (param-addr (car p)))) (cdr p)))))

  (print-if (cdb-description cdb) "/* ~a */~%")
  (print "typedef struct _~a~%" (cdb-name cdb))
  (print "{~%")
  (for-each
    (lambda (prm)
      (let* ((name    (param-name prm))
             (ident   (name->ident name))
             (value   (param-value prm))
             (addr    (param-addr prm))
             (byte-lo (pa-byte-lo addr))
             (byte-hi (pa-byte-hi addr))
             (bit-lo  (pa-bit-lo addr))
             (bit-hi  (pa-bit-hi addr))
             (len     (pa-length addr)))
        (define (comment)
          (let ((bits-str (case len 
                            ((2 3 4 5 6 7) (format #f "bits ~a-~a" bit-lo bit-hi))
                            ((1) (format #f "bit ~a" bit-lo))
                            (else #f))))
            (cond ((and value bits-str) (format #f " /* ~a, ~a */" value bits-str))
                  (value (format #f " /* ~a */" value))
                  (bits-str (format #f " /* ~a */" bits-str))
                  (else ""))))
        (if name
          (case len
            ((8)
             (print "~a\tByte\t~a;~a~%" (addr-as-c-comment addr) ident (comment)))

            ((7 6 5 4 3 2 1)
             (let-values (((struct-name struct-comment index) (param-struct-name prm cdb)))
               (if (zero? index)
                 (print "~a\tByte\t~a; /* ~a */~%" (addr-as-c-comment addr) 
                        struct-name struct-comment))))

            ((24)
             (print "~a\tByte\t~a[3];~a~%" (addr-as-c-comment addr) ident (comment)))

            ((16 32 64)
             (print "~a\tUint~a\t~a;~a~%" (addr-as-c-comment addr) len ident (comment)))

            (else 
              (error (format #f "cdb->c-struct: bad parameter length: ~a" len))))

          (cond
            ((<= len 8)
             (print "~a\tByte\tReserved~a;~%" (addr-as-c-comment addr) byte-lo))
            (else
              (print "~a\tByte\tReserved~a_~a[~a];~%"
                      (addr-as-c-comment addr) byte-lo byte-hi (quotient len 8)))))))
    (cdb-parameters cdb))

  ;; padding
  (let ((size  (cdb-size cdb))
        (psize (cdb-parameters-size cdb)))
    (if (and size (> size psize))
      (print "~a\tByte\tPadding[~a];~%" 
             (addr-as-c-comment (make-pa-bytes psize (- size 1)))
             (- size psize))))

  (print "} ~a;~%" (cdb-name cdb))
  (print "~%"))


;; all the procedures that one can use to generate some CDB-related code
(define *all-cdb-procs* (list
  cdb->xml 
  cdb->id-list
  cdb->param-list
  cdb->get-params
  cdb->cdb
  cdb->c-struct))


(define (cdb->all . cdbs)
  (for-each 
    (lambda (proc) 
      (for-each proc cdbs)
      (print "~%"))
    (list cdb->xml cdb->c-struct cdb->id-list cdb->param-list cdb->cdb)))


;; end of file
