;; All CDBs
;;


(define all-cdbs.scm #t)


(define visible: 'visible:)
(define members: 'members:)


;; maintenance in


(define *cdb-values-tables* '(
  ;; maintenance in service action
  scc-2-table-13
  #x00 "00h (Report Assigned/Unassigned P_EXTENT)"
  #x01 "01h (Report Component Device)"
  #x02 "02h (Report Component Device Attachments)"
  #x07 "07h (Report Device Identification)"
  #x03 "03h (Report Peripheral Device)"
  #x04 "04h (Report Peripheral Device Associations)"
  #x05 "05h (Report Peripheral Device/Component Device Identifier)"
  #x06 "06h (Report States)"
  #x09 "09h (Report Supported Configuration Method)"
  #x08 "08h (Report Unconfigured Capacity)"

  ;; maintenance out service action
  scc-2-table-54
  #x00 "00h (Add Peripheral Device/Component Device)"
  #x01 "01h (Attach To Component Device)"
  #x07 "07h (Break Peripheral Device/Component Device)"
  #x02 "02h (Exchange P_EXTENT)"
  #x03 "03h (Exchange Peripheral Device/Component Device)"
  #x04 "04h (Instruct Component Device)"
  #x05 "05h (Remove Peripheral Device/Component Device)"
  #x06 "06h (Set Peripheral Device/Component Device Identifier)"

  ;; Peripheral device type
  spc-3-table-83
  #x00 "00h (Direct access block device)"
  #x01 "01h (Sequenta-access devices)"
  #x02 "02h (Printer device"
  #x03 "03h (Processor device)"
  #x04 "04h (Write-once device)"
  #x05 "05h (CD/DVD device)"
  #x07 "07h (Optical memory device)"
  #x08 "08h (Medium changer device)"
  #x0C "0Ch (Storage array controller device"
  #x0D "0Dh (Enclosure service device)"
  #x0E "0Eh (Simplified direct-access device)"
  #x0F "0Fh (Optical card reader/writer device)"
  #x10 "10h (Bridge Controller Commands)"
  #x11 "11h (Object-based Storage Device)"
  #x12 "12h (Automation/Drive Interface)"
  #x1E "1Eh (Well known logical unit)"
  #x1F "1Fh (Unknown or no device type)"

  scc-2-table-44
  #x00 "00h (Available)"
  #x01 "01h (Broken)"
  #x02 "02h (Not available)"
  #x03 "03h (Not supported)"
  #x04 "04h (Present)"
  #x05 "05h (Readying)"
  #x06 "06h (Rebuild)"

  scc-2-table-21
  #x00 "00h (Controller electronics that contain a SACL)"
  #x01 "01h (Non-volatile cache)"
  #x02 "02h (Power supply)"
  #x03 "03h (Uninterruptable power supply)"
  #x04 "04h (Display)"
  #x05 "05h (Key pad entry)"
  #x06 "06h (Fan)"

  scc-2-table-46
  #x00 "00h (Available)"
  #x01 "01h (Broken)"
  #x03 "03h (ITTU)"
  #x04 "04h (Not available)"
  #x05 "05h (Not supported)"
  #x06 "06h (Present)"
  #x07 "07h (Readying)"

  ;; logical unit type
  scc-2-table-26
  #x00 "0h (Physical logical unit (peripheral device))"
  #x01 "1h (Volume set)"
  #x04 "4h (Component logical unit (component device))"
  #x05 "5h (Redundancy group)"
  #x06 "6h (Spare)"
  #x07 "7h (LUN_Z)"

  ;; select report
  scc-2-table-29
  #b00 "00b (Report all devices, LUN_P ignored)"
  #b01 "01b (Report devices by LUN_P)"
  #b10 "10b (Report unavailable devices, LUN_P ignored)"

  ;; report states
  scc-2-table-38
  #b00 "00b (Report all states for all LU - LU type and LUN ignored)"
  #b01 "01b (Report all states by given LU type - LUN ignored)"
  #b01 "10b (Report all states by given LU type and LUN)"

))


(define maintenance-in-cdb '(
  name:  "MAINTENANCE_IN_CDB"
  desc:  "Maintenance In"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" bits: 4 0 values: scc-2-table-13)
  (2 10)
  (11    "Control" 0)))


;; maintenance in, service action 00h


(define maintenance-in-00-cdb '(
  name:  "MAINTENANCE_IN_00_CDB"
  desc:  "Report Assigned/Unassigned P_EXTENT"
  tag:   "00"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5   "LUN_P")
  (6 9   "Allocation Length" default: 256)
  (10    "Assign" bit: 2 default: 0)
  (10    "RPTSEL" bit: 0 default: 0)
  (11    "Control" 0)))


;; maintenance in, service action 01h


(define maintenance-in-01-cdb '(
  name:  "MAINTENANCE_IN_01_CDB"
  desc:  "Report Component Device"
  tag:   "01"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x01" bits: 4 0)
  (2 3)
  (4 5   "LUN_C")
  (6 9   "Allocation Length" default: 256)
  (10    "RPTSEL" bit: 0 default: 0)
  (11    "Control" 0)))



;; maintenance in, service action 02h


(define maintenance-in-02-cdb '(
  name:  "MAINTENANCE_IN_02_CDB"
  desc:  "Report Component Device Attachements"
  tag:   "02"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x02" bits: 4 0)
  (2 3)
  (4 5   "LUN_C")
  (6 9   "Allocation Length" default: 256)
  (10    "RPTSEL" bit: 0 default: 0)
  (11    "Control" 0)))



;; maintenance in, service action 07h


(define maintenance-in-07-cdb '(
  name:  "MAINTENANCE_IN_07_CDB"
  desc:  "Report Device Identification"
  tag:   "07"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x07" bits: 4 0)
  (2)
  (3     "Logical Unit Type" bits: 3 0 values: scc-2-table-26)
  (4 5   "LUN")
  (6 9   "Allocation Length" default: 256)
  (10)
  (11    "Control" 0)))


;; maintenance in, service action 03h


(define maintenance-in-03-cdb '(
  name:  "MAINTENANCE_IN_03_CDB"
  desc:  "Report Peripheral Device"
  tag:   "03"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x03" bits: 4 0)
  (2 3)
  (4 5   "LUN_P")
  (6 9   "Allocation Length" default: 256)
  (10    "RPTMBUS" bit: 3)
  (10    "Select Report" bits: 1 0 values: scc-2-table-29)
  (11    "Control" 0)))



;; mainenance in, service action 04h


(define maintenance-in-04-cdb '(
  name:  "MAINTENANCE_IN_04_CDB"
  desc:  "Report Peripheral Device Associations"
  tag:   "04"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x04")
  (2 3)
  (4 5   "LUN_P")
  (6 9   "Allocation Length" default: 256)
  (10    "RPTMBUS" bit: 3)
  (10    "RPTSEL" bit: 0)
  (11    "Control" 0)))



;; maintenance in, service action 05h


(define maintenance-in-05-cdb '(
  name:  "MAINTENANCE_IN_05_CDB"
  desc:  "Report Peripheral Device/Component Device Identifier"
  tag:   "05"
  size:  16
  parameters:
  (0     "opcode" "0xA3")
  (1     "Service Action" "0x05")
  (2 3)
  (4 5   "LUN")
  (6 9   "Allocation Length" default: 256)
  (10    "PORCLU" bit: 1)
  (11    "Control" 0)))


;; maintenance in, service action 06h


(define maintenance-in-06-cdb '(
  name:    "MAINTENANCE_IN_06_CDB"
  desc:    "Report States"
  tag:     "06"
  size:    16
  parameters:
  (0       "opcode" "0xA3")
  (1       "Service Action" "0x06")
  (2)
  (3       "Logical Unit Type" bits: 3 0 values: scc-2-table-26)
  (4 5     "LUN")
  (6 9     "Allocation Length" default: 256)
  (10      "Report States" bits: 5 4 values: scc-2-table-38)
  (11      "Control" 0)))


;; maintenance in, service action 09h


(define maintenance-in-09-cdb '(
  name:    "MAINTENANCE_IN_09_CDB"
  desc:    "Report Supported Configuration Method"
  tag:     "09"
  size:    16
  parameters:
  (0       "opcode" "0xA3")
  (1       "Service Action" "0x09" bits: 4 0)
  (2 5)
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


;; maintenance in, service action 08h


(define maintenance-in-08-cdb '(
  name:    "MAINTENANCE_IN_08_CDB"
  desc:    "Report Unconfigured Capacity"
  tag:     "08"
  size:    16
  parameters:
  (0       "opcode" "0xA3")
  (1       "Service Action" "0x08" bits: 4 0)
  (2 5)
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define maintenance-out-cdb '(
  name:    "MAINTENANCE_OUT_CDB"
  desc:    "Maintenance Out"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" bits: 4 0 values: scc-2-table-54)
  (2 10)
  (11      "Control" 0)))


(define maintenance-out-00-cdb '(
  name:    "MAINTENANCE_OUT_00_CDB"
  desc:    "Add Peripheral Device/Component Device"
  tag:     "00"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x00" bits: 4 0)
  (2       "Device Type" values: spc-3-table-83)
  (3)
  (4 5     "LUN")
  (6 9)
  (10      "SETLUN" bit: 6)
  (10      "ADDPORC" bit: 1)
  (11      "Control" 0)))


(define maintenance-in-00-xml-group (list
  visible: "Service Action" "0"
  members: maintenance-in-00-cdb))

(define maintenance-in-01-xml-group (list
  visible: "Service Action" "1"
  members: maintenance-in-01-cdb))

(define maintenance-in-02-xml-group (list
  visible: "Service Action" "2"
  members: maintenance-in-02-cdb))

(define maintenance-in-07-xml-group (list
  visible: "Service Action" "7"
  members: maintenance-in-07-cdb))

(define maintenance-in-03-xml-group (list
  visible: "Service Action" "3"
  members: maintenance-in-03-cdb))

(define maintenance-in-04-xml-group (list
  visible: "Service Action" "4"
  members: maintenance-in-04-cdb))

(define maintenance-in-05-xml-group (list
  visible: "Service Action" "5"
  members: maintenance-in-05-cdb))

(define maintenance-in-06-xml-group (list
  visible: "Service Action" "6"
  members: maintenance-in-06-cdb))

(define maintenance-in-09-xml-group (list
  visible: "Service Action" "9"
  members: maintenance-in-09-cdb))

(define maintenance-in-08-xml-group (list
  visible: "Service Action" "8"
  members: maintenance-in-08-cdb))

(define maintenance-out-00-xml-group (list
  visible: "Service Action" "0"
  members: maintenance-out-00-cdb))


(define *maintenance-in-all* (list
  maintenance-in-cdb
  maintenance-in-00-cdb
  maintenance-in-01-cdb
  maintenance-in-02-cdb
  maintenance-in-07-cdb
  maintenance-in-03-cdb
  maintenance-in-04-cdb
  maintenance-in-05-cdb
  maintenance-in-06-cdb
  maintenance-in-09-cdb
  maintenance-in-09-cdb
))


(define *maintenance-in-all-xml-groups* (list
  maintenance-in-00-xml-group
  maintenance-in-01-xml-group
  maintenance-in-02-xml-group
  maintenance-in-07-xml-group
  maintenance-in-03-xml-group
  maintenance-in-04-xml-group
  maintenance-in-05-xml-group
  maintenance-in-06-xml-group
  maintenance-in-09-xml-group
  maintenance-in-08-xml-group
))


(define *maintenance-in-all-xml-groups* (list
  maintenance-in-00-xml-group
))

(define *maintenance-out-all* (list
  maintenance-out-cdb
  maintenance-out-00-cdb
))


(define *all-cdbs* (append 
  *maintenance-in-all* 
  *maintenance-out-all*
))


;; circular files references
(if (not (defined? 'cdb-procs.scm))
  (load "cdb-procs.scm"))


;; end of file
