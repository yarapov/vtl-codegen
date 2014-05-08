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

  ;; redundancy group in service actions
  scc-2-table-68
  #x02 "02h (Report Basic Redundancy Group)"
  #x00 "00h (Report Redundancy Groups)"
  #x01 "01h (Report Unassigned Redundancy Group Space)"

  ;; redundancy group out service action
  scc-2-table-82
  #x00 "00h (Control Generation Of Check Data)"
  #x07 "07h (Create/Modify Basic Redundancy Group)"
  #x01 "01h (Create/Modify Redundancy Group)"
  #x02 "02h (Delete Redundancy Group)"
  #x03 "03h (Rebuild P_EXTENT)"
  #x04 "04h (Rebuild Peripheral Device)"
  #x05 "05h (Recalculate Check Data)"
  #x06 "06h (Verify Check Data)"

  ;; redundancy group methods
  scc-2-table-71
  #x00 "00h (No redundancy)"
  #x01 "01h (Copy redundancy)"
  #x02 "02h (XOR redundancy)"
  #x03 "03h (P+Q redundancy)"
  #x04 "04h (P+S redundancy)"
  #x05 "05h (S redundancy)"

  ;; create/modify
  scc-2-table-87
  #b00 "00b"
  #b01 "01b"
  #b10 "10b"
  #b11 "11b"

  ;; granularity of units
  scc-2-table-76
  #x00 "0h (Bit)"
  #x01 "1h (Byte)"
  #x02 "2h (2-Byte word)"
  #x03 "3h (4-Byte word)"
  #x04 "4h (Logical block)"


  ;; spare in service action
  scc-2-table-150
  #x00 "00h (Report P_EXTENT Spare)"
  #x01 "01h (Report Peripheral Device/Component Device Spare)"

  ;; spare out service action
  scc-2-table-159
  #x00 "00h (Create/Modify P_EXTENT Spare)"
  #x01 "01h (Create/Modify Peripheral Device/Component Device Spare)"
  #x02 "02h (Delete Spare)"

  ;; volume set in service actions
  scc-2-table-103
  #x03 "03h (Report Basic Volume Set)"
  #x02 "02h (Report Storage Array Configuration)"
  #x01 "01h (Report Unassigned Volume Sets)"
  #x00 "00h (Report Volume Sets)"
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

  ;; volume set out service actions
  scc-2-table-120
  #x07 "07h (Assign LUN_V)"
  #x00 "00h (Control Generation Of Check Data)"
  #x01 "01h (Control Write Operations)"
  #x09 "09h (Create/Modify Basic Volume Set)"
  #x08 "08h (Create/Modify Storage Array Configuration)"
  #x02 "02h (Create/Modify Volume Set)"
  #x06 "06h (Deassign LUN_V)"
  #x03 "03h (Delete Volume Set)"
  #x04 "04h (Recalculate Volume Set Check Data)"
  #x05 "05h (Verifiy Volume Set Check Data)"
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
  cond:  "Service_Action == 0x00"
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
  cond:  "Service_Action == 0x01"
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
  cond:  "Service_Action == 0x02"
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
  cond:  "Service_Action == 0x07"
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
  cond:  "Service_Action == 0x03"
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
  cond:  "Service_Action == 0x04"
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
  cond:  "Service_Action == 0x05"
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
  cond:    "Service_Action == 0x06"
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
  cond:    "Service_Action == 0x09"
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
  cond:    "Service_Action == 0x08"
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
  cond:    "Service_Action == 0x00"
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
  cond:    "Service_Action == 0x01"
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
  cond:       "Service_Action == 0x01"
  tag:        "01LUD"
  parameters: scc-2-table-25))


(define maintenance-out-07-cdb '(
  name:    "MAINTENANCE_OUT_07_CDB"
  desc:    "Break Peripheral Device/Component Device"
  cond:    "Service_Action == 0x07"
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
  cond:    "Service_Action == 0x02"
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
  cond:       "Service_Action == 0x02"
  tag:        "02PEDOLD"
  parameters: scc-2-table-17))


(define maintenance-out-02-descriptor-new '(
  name:       "MAINTENANCE_OUT_02_DESCRIPTOR_NEW"
  desc:       "P_EXTENT Descriptor"
  cond:       "Service_Action == 0x02"
  tag:        "02PEDNEW"
  parameters: scc-2-table-17))


(define maintenance-out-03-cdb '(
  name:    "MAINTENANCE_OUT_03_CDB"
  desc:    "Exchange Peripheral Device/Component Device"
  cond:    "Service_Action == 0x03"
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
  cond:    "Service_Action == 0x04"
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
  cond:    "Service_Action == 0x05"
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
  cond:    "Service_Action == 0x06"
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
  cond:    "Service_Action == 0x06"
  tag:     "06DI"
  parameters:
  (0       "Identifier" default: "ID")))


(define redundancy-group-in-cdb '(
  name:    "REDUNDANCY_GROUP_IN_CDB"
  desc:    "Redundancy Group (In)"
  size:    16
  parameters:
  (0       "opcode" "0xBA")
  (1       "Service Action" bits: 4 0 values: scc-2-table-68)
  (2 10)
  (11      "Control" 0)))


(define redundancy-group-in-02-cdb '(
  name:    "REDUNDANCY_GROUP_IN_02_CDB"
  desc:    "Report Basic Redundancy Group"
  tag:     "02"
  cond:    "Service_Action == 0x02"
  size:    16
  parameters:
  (0       "opcode" "0xBA")
  (1       "Service Action" "0x02" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define redundancy-group-in-00-cdb '(
  name:    "REDUNDANCY_GROUP_IN_00_CDB"
  desc:    "Report Redundancy Groups"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size:    16
  parameters:
  (0       "opcode" "0xBA")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9     "Allocation Length" default: 256)
  (10      "RPTSEL" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-in-01-cdb '(
  name:    "REDUNDANCY_GROUP_IN_01_CDB"
  desc:    "Report Unassigned Redundancy Group Space"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size:    16
  parameters:
  (0       "opcode" "0xBA")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9     "Allocation Length" default: 256)
  (10      "RPTSEL" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_CDB"
  desc:    "Redundancy Group (Out)"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" bits: 4 0 values: scc-2-table-82)
  (2 10)
  (11      "Control" 0)))


(define redundancy-group-out-00-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_00_CDB"
  desc:    "Control Generation Of Check Data"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9)
  (10      "DISCHK" bit: 3)
  (10      "ALLRG" bit: 1)
  (11      "Control" 0)))


(define redundancy-group-out-07-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_07_CDB"
  desc:    "Create/Modify Basic Redundancy Group"
  tag:     "07"
  cond:    "Service_Action == 0x07"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x07" bits: 4 0)
  (2       "Redundancy Group Method" values: scc-2-table-71)
  (3       "BUSPROC" bit: 7)
  (3       "EQSPRD" bit: 4)
  (4 5     "LUN_R")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Create/Modify" bits: 7 6 values: scc-2-table-87)
  (10      "Configure" bits: 5 4 values: ;; scc-2-table-86
                                         #b00 "00b"
                                         #b01 "01b"
                                         #b10 "10b"
                                         #b11 "11b")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-07-plist '(
  name:    "REDUNDANCY_GROUP_OUT_07_PLIST"
  desc:    "Create/Modify Basic Redundancy Group Parameter List"
  tag:     "07PL"
  cond:    "Service_Action == 0x07"
  parameters:
  (0 3     "Capacity")
  (4 5     "Bytes Per Block")
  (6 7)))


(define redundancy-group-out-07-descriptor '(
  name:    "REDUNDANCY_GROUP_OUT_07_DESCRIPTOR"
  desc:    "Create/Modify Peripheral Device Descriptor"
  tag:     "07D"
  cond:    "Service_Action == 0x07"
  parameters:
  (0 1     "LUN_P")
  (2       "Weighting Of Protected Space + Check Data")
  (3       "Percent Of Check Data")))


(define redundancy-group-out-01-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_01_CDB"
  desc:    "Create/Modify Redundancy Group"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x01" bits: 4 0)
  (2       "Redundancy Type Method" values: scc-2-table-71)
  (3       "Granularity Of Units" bits: 3 0 values: scc-2-table-76)
  (4 5     "LUN_R")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Create/Modify" bits: 7 6 values: scc-2-table-87)
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-01-descriptor '(
  name:    "REDUNDANCY_GROUP_OUT_01_DESCRIPTOR"
  desc:    "Create/Modify P_EXTENT Descriptor"
  tag:     "01D"
  cond:    "Service_Action == 0x01"
  fixme:   "byte 20, bit 7: STRSPARE"
  parameters:
  ;; scc-2-table-17
  (0 1   "LUN_P")
  (2 5   "Start LBA_P")
  (6 9   "Number Of LBA_P")
  (10 11 "Number Of Bytes Per LBA_P")
  ;; scc-2-table-93
  (12    "SETPAT" bit: 7)
  (12    "Preserve" bit: 4)
  (12    "DEFERCAL" bit: 0)
  (13 14)
  (15    "Protected Space Pattern")
  (16 19 "Start Check Data Interleave Unit")
  (20    "STRSPARE" bit: 7)
  (20 23 "Number Of Units Of Check Data")
  (24 27 "Number Of Units Of User Data")))


(define redundancy-group-out-02-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_02_CDB"
  desc:    "Delete Redundancy Group"
  tag:     "02"
  cond:    "Service_Action == 0x02"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x02" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 10)
  (11      "Control" 0)))


(define redundancy-group-out-03-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_03_CDB"
  desc:    "Rebuild P_EXTENT"
  tag:     "03"
  cond:    "Service_Action == 0x03"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x03" bits: 4 0)
  (2 5)
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Rebuild" bits: 5 4 values: ;; scc-2-table-96
                                       #b00 "00b"
                                       #b01 "01b"
                                       #b10 "10b")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-03-plist '(
  name:    "REDUNDANCY_GROUP_OUT_03_PLIST"
  desc:    "Rebuild P_EXTENT Parameter List"
  tag:     "03D"
  cond:    "Service_Action == 0x03"
  parameters:
  ;; scc-2-table-17
  (0 1     "LUN_P")
  (2 5     "Start LBA_P")
  (6 9     "Number Of LBA_P")
  (10 11   "Number Of Bytes Per LBA_P")
  ;; scc-2-table-93
  (12 13)
  (14 15   "LUN_R")))


(define redundancy-group-out-04-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_04_CDB"
  desc:    "Rebuild Peripheral Device"
  tag:     "04"
  cond:    "Service_Action == 0x04"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x04" bits: 4 0)
  (2 5)
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Rebuild" bits: 5 4 values: ;; scc-2-table-96
                                       #b00 "00b"
                                       #b01 "01b"
                                       #b10 "10b")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-04-plist '(
  name:    "REDUNDANCY_GROUP_OUT_04_PLIST"
  desc:    "Rebuild Peripheral Device Parameter List"
  tag:     "04D"
  cond:    "Service_Action == 0x04"
  parameters:
  (0 1)
  (2 3     "LUN_P" comment: "address of the peripheral device to be rebuilt")
  (4 5)
  (6 7     "LUN_R" comment: "address of the redundancy group that shall not be used to rebuild the peripheral device.")))


(define redundancy-group-out-05-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_05_CDB"
  desc:    "Recalculate Check Data"
  tag:     "05"
  cond:    "Service_Action == 0x05"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x05" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9)
  (10      "ALLRG" bit: 1)
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define redundancy-group-out-06-cdb '(
  name:    "REDUNDANCY_GROUP_OUT_06_CDB"
  desc:    "Verify Check Data"
  tag:     "06"
  cond:    "Service_Action == 0x06"
  size:    16
  parameters:
  (0       "opcode" "0xBB")
  (1       "Service Action" "0x06" bits: 4 0)
  (2 3)
  (4 5     "LUN_R")
  (6 9)
  (10      "CONTVER" bit: 3)
  (10      "ALLRG" bit: 1)
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define spare-in-cdb '(
  name:    "SPARE_IN_CDB"
  desc:    "Spare In"
  size:    16
  parameters:
  (0       "opcode" "0xBC")
  (1       "Service Action" bits: 4 0 values: scc-2-table-150)
  (2 10)
  (11      "Control" 0)))


(define spare-in-00-cdb '(
  name:    "SPARE_IN_00_CDB"
  desc:    "Report P_EXTENT Spare"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size:    16
  parameters:
  (0       "opcode" "0xBC")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_S")
  (6 9     "Allocation Length" default: 256)
  (10      "RPTSEL" bit: 0)
  (11      "Control" 0)))


(define spare-in-01-cdb '(
  name:    "SPARE_IN_01_CDB"
  desc:    "Report Peripheral Device/Component Device Spare"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size:    16
  parameters:
  (0       "opcode" "0xBC")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 3)
  (4 5     "LUN_S")
  (6 9     "Allocation Length" default: 256)
  (10      "PORCSEL" bit: 1)
  (10      "RPTSEL" bit: 0)
  (11      "Control" 0)))


(define spare-out-cdb '(
  name:    "SPARE_OUT_CDB"
  desc:    "Spare Out"
  size: 16
  parameters:
  (0       "opcode" "0xBD")
  (1       "Service Action" bits: 4 0 values: scc-2-table-159)
  (2 10)
  (11      "Control" 0)))


(define spare-out-00-cdb '(
  name:    "SPARE_OUT_00_CDB"
  desc:    "Create/Modify P_EXTENT Spare"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size: 16
  parameters:
  (0       "opcode" "0xBD")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_S")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Create/Modify" bits: 7 6 values: #b00 "00b"
                                             #b01 "01b"
                                             #b10 "10b")
  (10      "Cover" bits: 5 4 values: #b00 "00b"
                                     #b01 "01b"
                                     #b10 "10b"
                                     #b11 "11b")
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define spare-out-00-plist '(
  fixme:   "single covered LUN_R, single covered P_EXTENT"
  name:    "SPARE_OUT_00_PLIST"
  desc:    "Create/Modify P_EXTENT Spare Parameter List"
  tag:     "00PL"
  cond:    "Service_Action == 0x00"
  parameters:
  ;; scc-2-table-17
  (0 1     "LUN_P")
  (2 5     "Start LBA_P")
  (6 9     "Number Of LBA_P")
  (10 11   "Number Of Bytes Per LBA_P")
  ;; scc-2-table-163
  (12 13   "Covered List Length" "n-13")
  (14 15   "Covered LUN_R List Length" "m-15")))


(define spare-out-00-covered-lun-r '(
  fixme:   "xml: make it group"
  name:    "SPARE_OUT_00_COVERED_LUN_R"
  desc:    "Covered LUN_R"
  tag:     "00CLR"
  cond:    "Service_Action == 0x00"
  parameters:
  (0 1)
  (2 3     "Covered LUN_R")))


(define spare-out-00-covered-p-extent-descriptor '(
  fixme:   "xml: make it group"
  name:    "SPARE_OUT_00_COVERED_DESCRIPTOR"
  desc:    "Covered P_EXTENT Descriptor"
  tag:     "00D"
  cond:    "Service_Action == 0x00"
  parameters:
  ;; scc-2-table-17
  (0 1     "LUN_P")
  (2 5     "Start LBA_P")
  (6 9     "Number Of LBA_P")
  (10 11   "Number Of Bytes Per LBA_P")))


(define spare-out-01-cdb '(
  name:    "SPARE_OUT_01_CDB"
  desc:    "Create/Modify Peripheral Device/Component Device Spare"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size: 16
  parameters:
  (0       "opcode" "0xBD")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 3     "LUN_P/LUN_C")
  (4 5     "LUN_S")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Create/Modify" bits: 7 6 values: #b00 "00b" ;; scc-2-table-166
                                             #b01 "01b"
                                             #b10 "10b")
  (10      "Cover" bits: 5 4 values: #b00 "00b" ;; scc-2-table-165
                                     #b01 "01b"
                                     #b10 "10b"
                                     #b11 "11b")
  (10      "PORCSEL" bit: 1)
  (10      "IMMED" bit: 0)
  (11      "Control" 0)))


(define spare-out-01-descriptor '(
  name:    "SPARE_OUT_01_DESCRIPTOR"
  desc:    "Covered Logical Unit Descriptor"
  tag:     "01D"
  cond:    "Service_Action == 0x01"
  parameters:
  ;; scc-2-table-157
  (0)
  (1       "Logical Unit Type" bits: 3 0 
           values: ;; scc-2-table-158
           #x0 "0h (Physical logical unit (peripheral device))"
           #x4 "4h (Component logical unit (component device))"
           #x5 "5h (Redundancy Group)")
  (2 3     "LUN")))


(define spare-out-02-cdb '(
  name:    "SPARE_OUT_02_CDB"
  desc:    "Delete Spare"
  cond:    "Service_Action == 0x02"
  tag:     "02"
  size:    16
  parameters:
  (0       "opcode" "0xBD")
  (1       "Service Action" "0x02" bits: 4 0)
  (2 3)
  (4 5     "LUN_S")
  (6 10)
  (11      "Control" 0)))


(define volume-set-in-cdb '(
  name:    "VOLUME_SET_IN_CDB"
  desc:    "Volume Set In"
  size:    16
  parameters:
  (0       "opcode" "0xBE")
  (1       "Service Action" bits: 4 0 values: scc-2-table-103)
  (2 10)
  (11      "Control" 0)))


(define volume-set-in-03-cdb '(
  name:    "VOLUME_SET_IN_03_CDB"
  desc:    "Report Basic Volume Set"
  tag:     "03"
  cond:    "Service_Action == 0x03"
  size:    16
  parameters:
  (0       "opcode" "0xBE")
  (1       "Service Action" "0x03" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define volume-set-in-02-cdb '(
  fixme:   "exactly the same as VOLUME_SET_IN_03_CDB"
  name:    "VOLUME_SET_IN_02_CDB"
  desc:    "Report Storage Array Configuration"
  tag:     "02"
  cond:    "Service_Action == 0x02"
  size:    16
  parameters:
  (0       "opcode" "0xBE")
  (1       "Service Action" "0x02" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define volume-set-in-01-cdb '(
  name:    "VOLUME_SET_IN_01_CDB"
  desc:    "Report Unassigned Volume Sets"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size:    16
  parameters:
  (0       "opcode" "0xBE")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 5)
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define volume-set-in-00-cdb '(
  fixme:   "exactly the same as VOLUME_SET_IN_03_CDB"
  name:    "VOLUME_SET_IN_00_CDB"
  desc:    "Report Volume Sets"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size:    16
  parameters:
  (0       "opcode" "0xBE")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9     "Allocation Length" default: 256)
  (10)
  (11      "Control" 0)))


(define volume-set-out-cdb '(
  name:    "VOLUME_SET_OUT_CDB"
  desc:    "Volume Set Out"
  size:    16
  parameters:
  (0       "opcode" "0xBF")
  (1       "Service Action" bits: 4 0 values: scc-2-table-120)
  (2 10)
  (11      "Control" 0)))


(define volume-set-out-07-cdb '(
  name:    "VOLUME_SET_OUT_07_CDB"
  desc:    "Allign LUN_V"
  cond:    "Service_Action == 0x07"
  tag:     "07"
  size:    16
  parameters:
  (0       "opcode" "0xBF")
  (1       "Service Action" "0x07" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9     "List Length" "COMPUTED_AT_RUNTIME")
  (10      "Enable Range" bits: 2 1 values: ;; scc-2-table-122
                                            #b00 "00b"
                                            #b01 "01b"
                                            #b10 "10b")
  (11      "Control" 0)))


(define volume-set-out-07-plist '(
  fixme:   "IDENTIFIER is used when 'Enable Range'==01b"
  name:    "VOLUME_SET_OUT_07_PLIST"
  desc:    "Identifier Parameter List"
  cond:    "Service_Action == 0x07"
  tag:     "07PL"
  parameters:
  (0 3     "Identifier List Length" "n-3")))


(define volume-set-out-00-cdb '(
  name:    "VOLUME_SET_OUT_00_CDB"
  desc:    "Control Generation Of Check Data"
  tag:     "00"
  cond:    "Service_Action == 0x00"
  size:    16
  parameters:
  (0       "opcode" "0xBF")
  (1       "Service Action" "0x00" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9)
  (10      "DISCHK" bit: 3)
  (10      "ALLVLU" bit: 1)
  (11      "Control" 0)))


(define volume-set-out-01-cdb '(
  name:    "VOLUME_SET_OUT_01_CDB"
  desc:    "Control Write Operations"
  tag:     "01"
  cond:    "Service_Action == 0x01"
  size:    16
  parameters:
  (0       "opcode" "0xBF")
  (1       "Service Action" "0x01" bits: 4 0)
  (2 3)
  (4 5     "LUN_V")
  (6 9)
  (10      "DISWR" bit: 3)
  (10      "ALLVLU" bit: 1)
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
  maintenance-in-08-cdb
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


(define redundancy-group-in-02-xml-group (list
  visible: "Service Action" "2"
  members: redundancy-group-in-02-cdb))

(define redundancy-group-in-00-xml-group (list
  visible: "Service Action" "0"
  members: redundancy-group-in-00-cdb))

(define redundancy-group-in-01-xml-group (list
  visible: "Service Action" "1"
  members: redundancy-group-in-01-cdb))


(define *redundancy-group-in-all-cdbs* (list
  redundancy-group-in-cdb
  redundancy-group-in-02-cdb
  redundancy-group-in-00-cdb
  redundancy-group-in-01-cdb
))


(define *redundancy-group-in-all-xml-groups* (list
  redundancy-group-in-02-xml-group
  redundancy-group-in-00-xml-group
  redundancy-group-in-01-xml-group
))


(define redundancy-group-out-00-xml-group (list
  visible: "Service Action" 0
  members: redundancy-group-out-00-cdb))

(define redundancy-group-out-07-xml-group (list
  visible: "Service Action" 7
  members: redundancy-group-out-07-cdb
           redundancy-group-out-07-plist
           redundancy-group-out-07-descriptor))

(define redundancy-group-out-01-xml-group (list
  visible: "Service Action" 1
  members: redundancy-group-out-01-cdb
           redundancy-group-out-01-descriptor))

(define redundancy-group-out-02-xml-group (list
  visible: "Service Action" 2
  members: redundancy-group-out-02-cdb))


(define redundancy-group-out-03-xml-group (list
  visible: "Service Action" 3
  members: redundancy-group-out-03-cdb
           redundancy-group-out-03-plist))

(define redundancy-group-out-04-xml-group (list
  visible: "Service Action" 4
  members: redundancy-group-out-04-cdb
           redundancy-group-out-04-plist))

(define redundancy-group-out-05-xml-group (list
  visible: "Service Action" 5
  members: redundancy-group-out-05-cdb))

(define redundancy-group-out-06-xml-group (list
  visible: "Service Action" 6
  members: redundancy-group-out-06-cdb))


(define *redundancy-group-out-all-cdbs* (list
  redundancy-group-out-cdb
  redundancy-group-out-00-cdb
  redundancy-group-out-07-cdb
  redundancy-group-out-07-plist
  redundancy-group-out-07-descriptor
  redundancy-group-out-01-cdb
  redundancy-group-out-01-descriptor
  redundancy-group-out-02-cdb
  redundancy-group-out-03-cdb
  redundancy-group-out-03-plist
  redundancy-group-out-04-cdb
  redundancy-group-out-04-plist
  redundancy-group-out-05-cdb
  redundancy-group-out-06-cdb
))


(define *redundancy-group-out-all-xml-groups* (list
  redundancy-group-out-00-xml-group
  redundancy-group-out-07-xml-group
  redundancy-group-out-01-xml-group
  redundancy-group-out-02-xml-group
  redundancy-group-out-03-xml-group
  redundancy-group-out-04-xml-group
  redundancy-group-out-05-xml-group
  redundancy-group-out-06-xml-group
))


(define spare-in-00-xml-group (list
  visible: "Service Action" 0
  members: spare-in-00-cdb))

(define spare-in-01-xml-group (list
  visible: "Service Action" 1
  members: spare-in-01-cdb))


(define *spare-in-all-cdbs* (list
  spare-in-cdb
  spare-in-00-cdb
  spare-in-01-cdb
))


(define *spare-in-all-xml-groups* (list
  spare-in-00-xml-group
  spare-in-01-xml-group
))


(define spare-out-00-xml-group (list
  visible: "Service Action" 0
  members: spare-out-00-cdb
           spare-out-00-plist
           spare-out-00-covered-lun-r
           spare-out-00-covered-p-extent-descriptor))

(define spare-out-01-xml-group (list
  visible: "Service Action" 1
  members: spare-out-01-cdb
           spare-out-01-descriptor))

(define spare-out-02-xml-group (list
  visible: "Service Action" 2
  members: spare-out-02-cdb))


(define *spare-out-all-cdbs* (list
  spare-out-cdb
  spare-out-00-cdb
  spare-out-00-plist
  spare-out-00-covered-lun-r
  spare-out-00-covered-p-extent-descriptor
  spare-out-01-cdb
  spare-out-01-descriptor
  spare-out-02-cdb))


(define *spare-out-all-xml-groups* (list
  spare-out-00-xml-group
  spare-out-01-xml-group
  spare-out-02-xml-group))


(define volume-set-in-03-xml-group (list
  visible: "Service Action" 3
  members: volume-set-in-03-cdb))

(define volume-set-in-02-xml-group (list
  visible: "Service Action" 2
  members: volume-set-in-02-cdb))

(define volume-set-in-01-xml-group (list
  visible: "Service Action" 1
  members: volume-set-in-01-cdb))

(define volume-set-in-00-xml-group (list
  visible: "Service Action" 0
  members: volume-set-in-00-cdb))


(define *volume-set-in-all-cdbs* (list
  volume-set-in-cdb
  volume-set-in-03-cdb
  volume-set-in-02-cdb
  volume-set-in-01-cdb
  volume-set-in-00-cdb))


(define *volume-set-in-all-xml-groups* (list
  volume-set-in-03-xml-group
  volume-set-in-02-xml-group
  volume-set-in-01-xml-group
  volume-set-in-00-xml-group))


(define *all-cdbs* (append 
  *maintenance-in-all-cdbs* 
  *maintenance-out-all-cdbs*
  *redundancy-group-in-all-cdbs*
  *redundancy-group-out-all-cdbs*
  *spare-in-all-cdbs*
  *spare-out-all-cdbs*
  *volume-set-in-all-cdbs*
))


(define *all-xml-groups* (append
  *maintenance-in-all-xml-groups*
  *maintenance-out-all-xml-groups*
  *redundancy-group-in-all-xml-groups*
  *redundancy-group-out-all-xml-groups*
  *spare-in-all-xml-groups*
  *spare-out-all-xml-groups*
  *volume-set-in-all-xml-groups*
))



;; circular files references
(if (not (defined? 'cdb-procs.scm))
  (load "cdb-procs.scm"))


;; end of file
