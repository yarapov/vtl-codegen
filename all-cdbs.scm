;; All CDBs
;;


(define all-cdbs.scm #t)


(define visible: 'visible:)
(define members: 'members:)


;; maintenance in


(define *cdb-values-tables* '(
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

  scc-2-table-26
  #x00 "0h (Physical logical unit (peripheral device))"
  #x01 "1h (Volume set)"
  #x04 "4h (Component logical unit (component device))"
  #x05 "5h (Redundancy group)"
  #x06 "6h (Spare)"
  #x07 "7h (LUN_Z)"

  scc-2-table-29
  #x00 "00b (Report all devices, LUN_P ignored)"
  #x01 "01b (Report devices by LUN_P)"
  #x02 "10b (Report unavailable devices, LUN_P ignored)"

))


(define maintenance-in-common '(
  name:  "MAINTENANCE_IN_CDB"
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


(define maintenance-in-00-plist '(
  name:  "MAINTENANCE_IN_00_PLIST"
  parameters:
  (0 3   "Assigned/Unassigned P_EXTENTS List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-00-plist-descriptor '(
  name:  "MAINTENANCE_IN_00_PLIST_DESCRIPTOR"
  tag:   "00PLD"
  parameters:
  (0 1   "LUN_P")
  (2 5   "Start LBA_P")
  (6 9   "Number Of LBA_P")
  (10 11 "Number Of Bytes Per LBA_P")
  (12 13)
  (14    "Peripheral Device Type" values: spc-3-table-83)
  (15    "P_EXTENT State" bits: 6 0 values: scc-2-table-44)))


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


(define maintenance-in-01-plist '(
  name:  "MAINTENANCE_IN_01_PLIST"
  parameters:
  (0 3   "Component Device List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-01-plist-descriptor '(
  name:  "MAINTENANCE_IN_01_PLIST_DESCRIPTOR"
  tag:   "01PLD"
  parameters:
  (0     "Component Device Type" values: scc-2-table-21)
  (1     "Replace" bit: 7 default: 0)
  (1     "Component Device State" bits: 6 0 values: scc-2-table-46)
  (2 3   "LUN_C")))



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


(define maintenance-in-02-plist '(
  name:  "MAINTENANCE_IN_02_PLIST"
  parameters:
  (0 3   "Component Device Attachements List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-02-plist-descriptor '(
  name:  "MAINTENANCE_IN_02_PLIST_DESCRIPTOR"
  tag:   "02PLD"
  parameters:
  (0 1   "LUN_C")
  (2 3   "Logical Unit List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-02-lu-descriptor '(
  name:  "MAINTENANCE_IN_02_LU_DESCRIPTOR"
  tag:   "02LUD"
  parameters:
  (0)
  (1     "Logical Unit Type" bits: 3 0 values: scc-2-table-26)
  (2 3   "LUN")))


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


(define maintenance-in-03-plist '(
  name:  "MAINTENANCE_IN_03_PLIST"
  tag:   "03PL"
  parameters:
  (0 3   "Peripheral Device List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-03-plist-descriptor '(
  name:  "MAINTENANCE_IN_03_PLIST_DESCRIPTOR"
  tag:   "03PLD"
  parameters:
  (0     "Peripheral Device Type" values: spc-3-table-83)
  (1     "Replace" bit: 7 default: 0)
  (1     "Peripheral Device State" bits: 6 0 values: scc-2-table-44)
  (2 3   "LUN_P")))


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


(define maintenance-in-04-plist '(
  name:  "MAINTENANCE_IN_04_PLIST"
  tag:   "04PL"
  parameters:
  (0 3   "Peripheral Device Associations List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-04-plist-descriptor '(
  name:  "MAINTENANCE_IN_04_PLIST_DESCRIPTOR"
  tag:   "04PLD"
  parameters:
  (0 2   "LUN_P")
  (3 4   "Logical Unit List Length" "COMPUTED_AT_RUNTIME")))


(define maintenance-in-04-lu-descriptor '(
  name:  "MAINTENANCE_IN_04_LU_DESCRIPTOR"
  tag:   "04LUD"
  parameters:
  (0)
  (1     "Logical Unit Type" bits: 3 0 values: scc-2-table-26)
  (2 3   "LUN")))


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


(define maintenance-in-06-cdb (list
  name:    "MAINTENANCE_IN_06_CDB"
  desc:    "Report States"
  tag:     "06"
  size:    16
  parameters:
  (0       "opcode" "0xA3")
  (1       "Service Action" "0x06")
  ))

(define maintenance-in-00-xml-group (list
  visible: "Service Action" "0"
  members: maintenance-in-00-cdb
           maintenance-in-00-plist
           maintenance-in-00-plist-descriptor))

(define maintenance-in-01-xml-group (list
  visible: "Service Action" "1"
  members: maintenance-in-01-cdb
           maintenance-in-01-plist
           maintenance-in-01-plist-descriptor))

(define maintenance-in-02-xml-group (list
  visible: "Service Action" "2"
  members: maintenance-in-02-cdb
           maintenance-in-02-plist
           maintenance-in-02-plist-descriptor
           maintenance-in-02-lu-descriptor))

(define maintenance-in-07-xml-group (list
  visible: "Service Action" "7"
  members: maintenance-in-07-cdb))

(define maintenance-in-03-xml-group (list
  visible: "Service Action" "3"
  members: maintenance-in-03-cdb
           maintenance-in-03-plist
           maintenance-in-03-plist-descriptor))


(define maintenance-in-04-xml-group (list
  visible: "Service Action" "4"
  members: maintenance-in-04-cdb
           maintenance-in-04-plist
           maintenance-in-04-plist-descriptor
           maintenance-in-04-lu-descriptor))

(define maintenance-in-05-xml-group (list
  visible: "Service Action" "5"
  members: maintenance-in-05-cdb
))


(define *maintenance-in-all* (list
  maintenance-in-common
  maintenance-in-00-cdb
  maintenance-in-00-plist
  maintenance-in-00-plist-descriptor
  maintenance-in-01-cdb
  maintenance-in-01-plist
  maintenance-in-01-plist-descriptor
  maintenance-in-02-cdb
  maintenance-in-02-plist
  maintenance-in-02-plist-descriptor
  maintenance-in-02-lu-descriptor
  maintenance-in-07-cdb
  maintenance-in-03-cdb
  maintenance-in-03-plist
  maintenance-in-03-plist-descriptor
  maintenance-in-04-cdb
  maintenance-in-04-plist
  maintenance-in-04-plist-descriptor
  maintenance-in-04-lu-descriptor
  maintenance-in-05-cdb
))


(define *maintenance-in-all-xml-groups* (list
  maintenance-in-00-xml-group
  maintenance-in-01-xml-group
  maintenance-in-02-xml-group
  maintenance-in-07-xml-group
  maintenance-in-03-xml-group
  maintenance-in-04-xml-group
  maintenance-in-05-xml-group
))


(define *all-cdbs* (append *maintenance-in-all*))


;; circular files references
(if (not (defined? 'cdb-procs.scm))
  (load "cdb-procs.scm"))


;; end of file
