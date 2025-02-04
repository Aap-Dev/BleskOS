;BleskOS

%define OHCI_LOW_SPEED 0x00082000
%define OHCI_FULL_SPEED 0x00080000
%define OHCI_TD_ACTIVE 0xE0000000
%define OHCI_DATA_TOGGLE_0 0x02000000
%define OHCI_DATA_TOGGLE_1 0x03000000
%define OHCI_SETUP (0 << 19)
%define OHCI_OUT (1 << 19)
%define OHCI_IN (2 << 19)

%macro OHCI_CREATE_ED 3
 mov dword [MEMORY_OHCI+0x100], %1 ;attributes
 mov dword [MEMORY_OHCI+0x104], %2+(%3*0x10) ;TD tail
 mov dword [MEMORY_OHCI+0x108], %2 ;TD head
 mov dword [MEMORY_OHCI+0x10C], 0x0 ;no next ED
%endmacro

%macro OHCI_CREATE_TD 4
 %if %4==0
 mov dword [%1+4], 0
 %endif
 %if %4!=0
 mov dword [%1+4], %4
 %endif

 mov dword [%1+8], %2

 %if %4==0
 mov dword [%1+12], 0
 %endif
 %if %4!=0
 mov dword [%1+12], %4+7
 %endif
 
 mov dword [%1+0], %3
%endmacro

%macro OHCI_RUN_CONTROL_TRANSFER 0
 MMIO_OUTD ohci_base, 0x24, 0x0 ;current control ED
 MMIO_OUTD ohci_base, 0x20, MEMORY_OHCI+0x100 ;pointer to control ED
 MMIO_OUTD ohci_base, 0x04, 0x90 ;run control ED
 MMIO_OUTD ohci_base, 0x08, 0x2 ;run control ED
 mov dword [ohci_td_wait], 100
%endmacro

%macro OHCI_RUN_PERIODIC_TRANSFER 0
 MMIO_OUTD ohci_base, 0x1C, 0x0 ;current periodic ED
 MMIO_OUTD ohci_base, 0x04, 0x84 ;run periodic ED
 mov dword [ohci_td_wait], 100
%endmacro

ohci_base dd 0
ohci_port_base dd 0
ohci_device_speed dd 0
ohci_address db 0
ohci_td dd 0
ohci_td_wait dd 0

ohci_conf_number db 0
ohci_interface_number db 0
ohci_alt_interface_number db 0
ohci_endpoint dd 0
ohci_toggle dd 0

ohci_reset_every_device dd 0

init_ohci:
 ;disable legacy support
 MMIO_IND ohci_base, 0x00
 cmp eax, 0x110
 jne .if_legacy_support
  MMIO_OUTD ohci_base, 0x100, 0x0
 .if_legacy_support:

 MMIO_OUTD ohci_base, 0x08, 0x1 ;reset
 WAIT 10
 MMIO_OUTD ohci_base, 0x04, 0x0 ;global reset
 WAIT 50
 MMIO_OUTD ohci_base, 0x04, 0xC0 ;suspend

 MMIO_OUTD ohci_base, 0x14, 0x80000000 ;disable all interrupts

 MMIO_OUTD ohci_base, 0x34, 0xA7782EDF ;FM interval
 MMIO_OUTD ohci_base, 0x40, 0x2A2F ;periodic start

 MMIO_OUTD ohci_base, 0x48, 0x1200 ;power all ports
 MMIO_OUTD ohci_base, 0x4C, 0x0

 ;clear hcca
 mov edi, MEMORY_OHCI
 mov eax, 0
 mov ecx, 256
 rep stosb
 ;fill hcca
 mov edi, MEMORY_OHCI
 mov eax, MEMORY_OHCI+0x100
 mov ecx, 32
 rep stosd
 MMIO_OUTD ohci_base, 0x18, MEMORY_OHCI ;HCCA memory pointer

 MMIO_OUTD ohci_base, 0x1C, 0x0 ;current period ED
 MMIO_OUTD ohci_base, 0x24, 0x0 ;current control ED
 MMIO_OUTD ohci_base, 0x2C, 0x0 ;current bulk ED

 MMIO_OUTD ohci_base, 0x20, MEMORY_OHCI+0x100 ;pointer to control ED
 MMIO_OUTD ohci_base, 0x28, MEMORY_OHCI+0x1000 ;pointer to bulk ED

 MMIO_OUTD ohci_base, 0x04, 0x80 ;start controller
 WAIT 50

 ret

ohci_detect_devices:
 MMIO_IND ohci_base, 0x48
 and eax, 0xF ;number of ports
 mov byte [ohci_address], 1

 mov ebx, dword [ohci_base]
 mov dword [ohci_port_base], ebx
 add dword [ohci_port_base], 0x54 ;first port
 mov ecx, eax
 .detect_device:
 push ecx
  mov dword [ohci_td], 0
  call ohci_detect_device
  add dword [ohci_port_base], 4
  inc byte [ohci_address]
 pop ecx
 loop .detect_device

 .done:
 ret

ohci_detect_device:
 ;is device connected?
 MMIO_IND ohci_port_base, 0
 and eax, 0x1
 cmp eax, 0x1
 jne .no_device

 cmp dword [ohci_reset_every_device], 1
 je .initalize_device

 ;is device initalized?
 MMIO_IND ohci_port_base, 0
 and eax, 0x10000
 cmp eax, 0x10000
 jne .initalized_device

 ;initalize device
 .initalize_device:
 call usb_keyboard_ohci_remove
 call usb_mouse_ohci_remove
 MMIO_OUTD ohci_port_base, 0, 0x10
 WAIT 50
 MMIO_OUTD ohci_port_base, 0, 0x2 ;stop reset, enable port
 WAIT 30
 MMIO_IND ohci_port_base, 0
 and eax, 0x200
 mov dword [ohci_device_speed], OHCI_FULL_SPEED
 IF_E eax, 0x200, if_low_speed
  mov dword [ohci_device_speed], OHCI_LOW_SPEED
 ENDIF if_low_speed
 MMIO_OUTD ohci_port_base, 0, 0x001F0002 ;clear bits

 ;initalize device
 call ohci_set_address
 call ohci_read_descriptor

 ret

 .no_device:
 call usb_keyboard_ohci_remove
 call usb_mouse_ohci_remove

 .initalized_device:
 ret
 
ohci_detect_port_change:
 MMIO_IND ohci_base, 0x48
 and eax, 0xF ;number of ports

 mov ebx, dword [ohci_base]
 mov dword [ohci_port_base], ebx
 add dword [ohci_port_base], 0x54 ;first port
 mov ecx, eax
 .detect_device:
  MMIO_IND ohci_port_base, 0
  test eax, 0x10000
  jnz .change
 loop .detect_device

 .done:
 ret
 
 .change:
 MMIO_OUTD ohci_port_base, 0, 0x10000 ;clear status change
 mov dword [usb_port_change], 1
 ret

ohci_set_address:
 mov eax, dword [ohci_device_speed]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 2
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_SETUP), MEMORY_OHCI+0x300
 OHCI_CREATE_TD MEMORY_OHCI+0x210, MEMORY_OHCI+0x220, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), 0x0
 mov dword [MEMORY_OHCI+0x300], 0x00000500
 mov dword [MEMORY_OHCI+0x304], 0x00000000
 mov al, byte [ohci_address]
 mov byte [MEMORY_OHCI+0x302], al

 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x210
 call ohci_wait_for_transfer
 
 WAIT 10

 ret

ohci_read_descriptor:
 mov eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 9
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_SETUP), MEMORY_OHCI+0x300
 OHCI_CREATE_TD MEMORY_OHCI+0x210, MEMORY_OHCI+0x220, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), MEMORY_OHCI+0x400
 OHCI_CREATE_TD MEMORY_OHCI+0x220, MEMORY_OHCI+0x230, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_IN), MEMORY_OHCI+0x400+8
 OHCI_CREATE_TD MEMORY_OHCI+0x230, MEMORY_OHCI+0x240, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), MEMORY_OHCI+0x400+16
 OHCI_CREATE_TD MEMORY_OHCI+0x240, MEMORY_OHCI+0x250, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_IN), MEMORY_OHCI+0x400+24
 OHCI_CREATE_TD MEMORY_OHCI+0x250, MEMORY_OHCI+0x260, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), MEMORY_OHCI+0x400+32
 OHCI_CREATE_TD MEMORY_OHCI+0x260, MEMORY_OHCI+0x270, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_IN), MEMORY_OHCI+0x400+40
 OHCI_CREATE_TD MEMORY_OHCI+0x270, MEMORY_OHCI+0x280, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), MEMORY_OHCI+0x400+48
 OHCI_CREATE_TD MEMORY_OHCI+0x280, MEMORY_OHCI+0x290, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_IN), MEMORY_OHCI+0x400+56
 mov dword [MEMORY_OHCI+0x300], 0x02000680
 mov dword [MEMORY_OHCI+0x304], 0x00400000
 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x280
 call ohci_wait_for_transfer
 
 WAIT 10

 mov eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 1
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_OUT), 0x0
 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x200
 call ohci_wait_for_transfer ;send STATUS stage of setup transfer
 
 WAIT 10
 
 mov eax, dword [MEMORY_OHCI+0x200]
 PHEX eax

 ;PARSE RECEIVED DATA
 mov esi, MEMORY_OHCI+0x400
 call parse_usb_descriptor

 mov al, byte [usb_descriptor+20]
 mov byte [ohci_conf_number], al
 mov al, byte [usb_descriptor+21]
 mov byte [ohci_interface_number], al
 mov al, byte [usb_descriptor+22]
 mov byte [ohci_alt_interface_number], al
 cmp dword [usb_descriptor+23], 0x00020103
 je .usb_mouse_2

 mov al, byte [usb_descriptor+10]
 mov byte [ohci_conf_number], al
 mov al, byte [usb_descriptor+11]
 mov byte [ohci_interface_number], al
 mov al, byte [usb_descriptor+12]
 mov byte [ohci_alt_interface_number], al
 cmp dword [usb_descriptor+13], 0x00010103
 je .usb_keyboard
 cmp dword [usb_descriptor+13], 0x00020103
 je .usb_mouse

 ret

 .usb_keyboard:
 call ohci_set_configuration
 call ohci_set_interface
 call ohci_set_idle

 ;save keyboard
 mov dword [usb_keyboard_controller], OHCI
 mov ax, word [ohci_base]
 mov word [usb_keyboard_base], ax
 mov eax, dword [ohci_device_speed]
 mov dword [usb_keyboard_speed], eax
 mov eax, 0
 mov al, byte [usb_descriptor+19]
 mov dword [usb_keyboard_endpoint], eax
 mov al, byte [ohci_address]
 mov byte [usb_keyboard_address], al
 mov dword [usb_keyboard_toggle], 0

 ret

 .usb_mouse:
 call ohci_set_configuration
 call ohci_set_interface
 call ohci_set_idle

 ;save mouse
 mov dword [usb_mouse_controller], OHCI
 mov eax, dword [ohci_base]
 mov dword [usb_mouse_base], eax
 mov eax, dword [ohci_device_speed]
 mov dword [usb_mouse_speed], eax
 mov eax, 0
 mov al, byte [usb_descriptor+19]
 mov dword [usb_mouse_endpoint], eax
 mov al, byte [ohci_address]
 mov byte [usb_mouse_address], al
 mov dword [usb_mouse_toggle], 0

 .done:
 ret

 .usb_mouse_2:
 call .usb_mouse

 mov eax, 0
 mov al, byte [usb_descriptor+29]
 mov dword [usb_mouse_endpoint], eax

 ret

ohci_set_configuration:
 mov dword [MEMORY_OHCI+0x300], 0x00000900
 mov dword [MEMORY_OHCI+0x304], 0x00000000
 mov al, byte [ohci_conf_number]
 mov byte [MEMORY_OHCI+0x302], al ;configuration number

 mov eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 2
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_SETUP), MEMORY_OHCI+0x300
 OHCI_CREATE_TD MEMORY_OHCI+0x210, MEMORY_OHCI+0x220, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), 0x0
 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x210
 call ohci_wait_for_transfer

 ret

ohci_set_interface:
 mov dword [MEMORY_OHCI+0x300], 0x00000B01
 mov dword [MEMORY_OHCI+0x304], 0x00000000
 mov al, byte [ohci_alt_interface_number]
 mov byte [MEMORY_OHCI+0x302], al ;alternate interface number
 mov al, byte [ohci_interface_number]
 mov byte [MEMORY_OHCI+0x304], al ;interface number

 mov eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 2
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_SETUP), MEMORY_OHCI+0x300
 OHCI_CREATE_TD MEMORY_OHCI+0x210, MEMORY_OHCI+0x220, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), 0x0
 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x210
 call ohci_wait_for_transfer

 ret

ohci_set_idle:
 mov dword [MEMORY_OHCI+0x300], 0x00000A21
 mov dword [MEMORY_OHCI+0x304], 0x00000000
 mov al, byte [ohci_interface_number]
 mov byte [MEMORY_OHCI+0x304], al ;interface number

 mov eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 2
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_SETUP), MEMORY_OHCI+0x300
 OHCI_CREATE_TD MEMORY_OHCI+0x210, MEMORY_OHCI+0x220, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_1 | OHCI_IN), 0x0
 OHCI_RUN_CONTROL_TRANSFER
 mov dword [ohci_td], MEMORY_OHCI+0x210
 call ohci_wait_for_transfer

 ret

ohci_read_hid:
 ;stop transfer
 mov dword [MEMORY_OHCI+0x200], 0x0
 
 mov dword [MEMORY_OHCI+0x300], 0
 mov dword [MEMORY_OHCI+0x304], 0
 
 mov eax, 0
 mov al, byte [ohci_endpoint]
 shl eax, 7
 or eax, dword [ohci_device_speed]
 or al, byte [ohci_address]
 OHCI_CREATE_ED eax, MEMORY_OHCI+0x200, 1
 
 mov eax, dword [ohci_toggle]
 shl eax, 24
 or eax, (OHCI_TD_ACTIVE | OHCI_DATA_TOGGLE_0 | OHCI_IN)
 OHCI_CREATE_TD MEMORY_OHCI+0x200, MEMORY_OHCI+0x210, eax, MEMORY_OHCI+0x300
 
 OHCI_RUN_PERIODIC_TRANSFER
 
 mov dword [ohci_td], MEMORY_OHCI+0x200
 mov dword [ohci_td_wait], 2
 call ohci_wait_for_transfer
 
 mov eax, 0
 mov ebx, dword [MEMORY_OHCI+0x200]
 and ebx, 0xE0000000
 cmp ebx, 0xE0000000
 je .done
 
 mov eax, 3
 cmp byte [MEMORY_OHCI+300+3], 0
 je .done
 mov eax, 4
 cmp byte [MEMORY_OHCI+300+4], 0
 je .done
 mov eax, 7
 
 .done:
 ret
 
ohci_check_hid:
 mov al, 0
 
 mov eax, dword [MEMORY_OHCI+0x200]
 and eax, 0xE0000000
 cmp eax, 0xE0000000
 je .done
 cmp eax, 0x00000000
 je .transfer
 cmp eax, 0x90000000
 je .transfer
 PHEX eax
 ;jmp .done ;some error

 .transfer:
 MMIO_OUTD ohci_base, 0x04, 0x80 ;stop transfer
 mov eax, dword [MEMORY_OHCI+0x200+8]
 sub eax, MEMORY_OHCI+0x300 ;length of transferred data
 
 MMIO_OUTD ohci_base, 0x04, 0x80 ;stop transfer
 MMIO_OUTD ohci_base, 0x08, 0x0 ;stop transfer

 .done:
 ret

ohci_wait_for_transfer:
 mov eax, dword [ohci_td]
 mov ebx, dword [ohci_td_wait]
 mov dword [ticks], 0
 .wait:
  mov ecx, dword [eax]
  and ecx, 0xE0000000
  cmp ecx, 0xE0000000
  jne .done
 cmp dword [ticks], ebx
 jl .wait

 .done:
 MMIO_OUTD ohci_base, 0x04, 0x80 ;stop transfer
 MMIO_OUTD ohci_base, 0x08, 0x0 ;stop transfer
 
 ret
