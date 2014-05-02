;; All CDBs
;;


(define all-cdbs.scm #t)


(define visible: 'visible:)
(define members: 'members:)


(define *cdb-values-tables* '(
  ;; maintenance in service actions
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

  ;; maintenance out service actions
  scc-2-table-54
  #x00 "00h (Add Peripheral Device/Component Device)"
  #x01 "01h (Attach To Component Device)"
  #x07 "07h (Break Peripheral Device/Component Device)"
  #x02 "02h (Exchange P_EXTENT)"
  #x03 "03h (Exchange Peripheral Device/Component Device)"
  #x04 "04h (Instruct Component Device)"
  #x05 "05h (Remove Peripheral Device/Component Device)"
  #x06 "06h (Set Peripheral Device/Component Device Identifier)"

  ;; Peripheral device types
  spc-3-table-83
  #x00 "00h (Direct access block device)"
  #x01 "01h (Sequental-access devices)"
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

  ;; component device types
  scc-2-table-21
  #x00 "00h (Controller electronics that contain a SACL)"
  #x01 "01h (Non-volatile cache)"
  #x02 "02h (Power supply)"
  #x03 "03h (Uninterruptable power supply)"
  #x04 "04h (Display)"
  #x05 "05h (Key pad entry)"
  #x06 "06h (Fan)"

  ;; Peripheral device and p_extent states
  scc-2-table-44
  #x00 "00h (Available)"
  #x01 "01h (Broken)"
  #x02 "02h (Not available)"
  #x03 "03h (Not supported)"
  #x04 "04h (Present)"
  #x05 "05h (Readying)"
  #x06 "06h (Rebuild)"

  ;; component device states
  scc-2-table-46
  #x00 "00h (Available)"
  #x01 "01h (Broken)"
  #x03 "03h (ITTU)"
  #x04 "04h (Not available)"
  #x05 "05h (Not supported)"
  #x06 "06h (Present)"
  #x07 "07h (Readying)"

  ;; logical unit types
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
  #b10 "10b (Report all states by given LU type and LUN)"

))


(define *cdb-structurs-tables* '(
  ;; logical unit descriptor
  scc-2-table-25 (
  (0)
  (1     "Logical Unit Type" bits: 3 0 values: scc-2-table-26)
  (2 3   "LUN"))

  ;; p_extent descriptor
  scc-2-table-17 (
  (0 1   "LUN_P")
  (2 5   "Start LBA_P")
  (6 9   "Number Of LBA_P")
  (10 11 "Number Of Bytes Per LBA_P"))

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
  (2       "Device Type" default: 0  ;; spc-3-table-83 (ADDPORC is 0) or
                                     ;; scc-2-table-21 (ADDPORC is 1)
           comment: "peripheral dev.type if ADDPORC is 0, component dev.type if ADDPORC is 1")
  (3)
  (4 5     "LUN"
           comment: "should be ignored when SETLUN is 1")
  (6 9)
  (10      "SETLUN" bit: 6  values: 0 "0h (Assign provided LUN)"
                                    1 "1h (Ignore provided LUN)")
  (10      "ADDPORC" bit: 1 values: 0 "0h (Peripheral Device Type)"
                                    1 "1h (Component Device Type)")
  (11      "Control" 0)))


(define maintenance-out-01-cdb '(
  name:    "MAINTENANCE_OUT_01_CDB"
  desc:    "Attach Component Device"
  tag:     "01"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 3)
  (4 5     "LUN_C")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10)
  (11      "Control" 0)))


(define maintenance-out-01-lu-descriptor '(
  name:       "MAINTENANCE_OUT_01_LU_DESCRIPTOR"
  desc:       "Logical Unit Descriptor"
  tag:        "01LUD"
  parameters: scc-2-table-25))


(define maintenance-out-07-cdb '(
  name:    "MAINTENANCE_OUT_07_CDB"
  desc:    "Break Peripheral Device/Component Device"
  tag:     "07"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x07" bits: 4 0)
  (2       "Device Type" default: 0  ;; spc-3-table-83 (BRKPORC is 0) or
                                     ;; scc-2-table-21 (BRKPORC is 1)
           comment: "peripheral dev.type if BRKPORC is 0, component dev.type if BRKPORC is 1")
  (3)
  (4 5     "LUN")
  (6 9)
  (10      "BRKPORC" bit: 1 values: 0 "0h (Peripheral Device Type)"
                                    1 "1h (Component Device Type)")
  (11      "Control" 0)))


(define maintenance-out-02-cdb '(
  fixme:   "XML: put old/new descriptors into groups"
  name:    "MAINTENANCE_OUT_02_CDB"
  desc:    "Exchange P_EXTENT"
  tag:     "02"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x02" bits: 4 0)
  (2 5)
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define maintenance-out-02-descriptor-old '(
  name:       "MAINTENANCE_OUT_02_DESCRIPTOR_OLD"
  desc:       "P_EXTENT Descriptor"
  tag:        "02PEDOLD"
  parameters: scc-2-table-17))


(define maintenance-out-02-descriptor-new '(
  name:       "MAINTENANCE_OUT_02_DESCRIPTOR_NEW"
  desc:       "P_EXTENT Descriptor"
  tag:        "02PEDNEW"
  parameters: scc-2-table-17))


(define maintenance-out-03-cdb '(
  name:    "MAINTENANCE_OUT_03_CDB"
  desc:    "Exchange Peripheral Device/Component Device"
  tag:     "03"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x03" bits: 4 0)
  (2 3)
  (4 5     "Old LUN")
  (6 7)
  (8 9     "New LUN")
  (10      "EXPORC" bit: 1 values: 0 "0 (Old/New LUNs shall contain addresses of peripheral devices"
                                   1 "1 (Old/New LUNs shall contain addresses of component devices")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define maintenance-out-04-cdb '(
  fixme:   "vendor specific instructions not supported"
  name:    "MAINTENANCE_OUT_04_CDB"
  desc:    "Instruct Component Device"
  tag:     "04"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x04" bits: 4 0)
  (2       "Component Device Instruction" values: 0 "00h (Turn selected component device off)"
                                                  1 "01h (Turn selected component device on)")
  (4 5     "LUN_C")
  (6 9     "List Length" 0)
  (10)
  (11      "Control" 0)))


(define maintenance-out-05-cdb '(
  name:    "MAINTENANCE_OUT_05_CDB"
  desc:    "Remove Peripheral Device/Component Device"
  tag:     "05"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x05" bits: 4 0)
  (2 3)
  (4 5     "LUN")
  (6 9)
  (10      "REMPORC" bit: 1 values: 0 "0 (LUN shall contain address of peripheral devices"
                                    1 "1 (LUN shall contain address of component devices")
  (11      "Control" 0)))


(define maintenance-out-06-cdb '(
  fixme:   "is it ok to have fixed-length identifier?"
  name:    "MAINTENANCE_OUT_06_CDB"
  desc:    "Set Peripheral Device/Component Device Identifier"
  tag:     "06"
  size:    16
  parameters:
  (0       "opcode" "0xA4")
  (1       "Service Action" "0x06" bits: 4 0)
  (2 3)
  (4 5     "LUN")
  (6 9     "List Length" default: 64)
  (10      "IDPORC" bit: 1 values: 0 "0 (LUN shall contain address of peripheral devices"
                                   1 "1 (LUN shall contain address of component devices")
  (11      "Control" 0)))


(define maintenance-out-06-identifier '(
  fixme:   "make it fixed-size array instead of Byte"
  name:    "MAINTENANCE_OUT_06_IDENTIFIER"
  desc:    "Device Identifier"
  tag:     "06DI"
  parameters:
  (0       "Identifier" default: "ID")))



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


(define *maintenance-in-all-cdbs* (list
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


(define maintenance-out-00-xml-group (list
  visible: "Service Action" "0"
  members: maintenance-out-00-cdb))

(define maintenance-out-01-xml-group (list
  visible: "Service Action" "1"
  members: maintenance-out-01-cdb
           maintenance-out-01-lu-descriptor))

(define maintenance-out-07-xml-group (list
  visible: "Service Action" "7"
  members: maintenance-out-07-cdb))

(define maintenance-out-02-xml-group (list
  visible: "Service Action" "2"
  members: maintenance-out-02-cdb
           maintenance-out-02-descriptor-old
           maintenance-out-02-descriptor-new))

(define maintenance-out-03-xml-group (list
  visible: "Service Action" "3"
  members: maintenance-out-03-cdb))

(define maintenance-out-04-xml-group (list
  visible: "Service Action" "4"
  members: maintenance-out-04-cdb))

(define maintenance-out-05-xml-group (list
  visible: "Service Action" "5"
  members: maintenance-out-05-cdb))

(define maintenance-out-06-xml-group (list
  visible: "Service Action" "6"
  members: maintenance-out-06-cdb
           maintenance-out-06-identifier))


(define *maintenance-out-all-cdbs* (list
  maintenance-out-cdb
  maintenance-out-00-cdb
  maintenance-out-01-cdb
  maintenance-out-01-lu-descriptor
  maintenance-out-07-cdb
  maintenance-out-02-cdb
  maintenance-out-02-descriptor-old
  maintenance-out-02-descriptor-new
  maintenance-out-03-cdb
  maintenance-out-04-cdb
  maintenance-out-05-cdb
  maintenance-out-06-cdb
  maintenance-out-06-identifier
))

(define *maintenance-out-all-xml-groups* (list
  maintenance-out-00-xml-group
  maintenance-out-01-xml-group
  maintenance-out-07-xml-group
  maintenance-out-02-xml-group
  maintenance-out-03-xml-group
  maintenance-out-04-xml-group
  maintenance-out-05-xml-group
  maintenance-out-06-xml-group
))


(define *all-cdbs* (append 
  *maintenance-in-all-cdbs* 
  *maintenance-out-all-cdbs*
))


(define *all-xml-groups* (append
  *maintenance-in-all-xml-groups*
  *maintenance-out-all-xml-groups*
))



;; circular files references
(if (not (defined? 'cdb-procs.scm))
  (load "cdb-procs.scm"))


;; end of file
