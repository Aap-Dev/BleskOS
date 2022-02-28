;BleskOS

org 0x10000

bits 32

start:
 jmp start_bleskos

 %include "source/macros.asm"

 %include "source/drivers/graphic_vesa.asm"
 %include "source/drivers/graphic_font.asm"

 %include "source/drivers/system_pci.asm"
 %include "source/drivers/system_interrupts.asm"
 %include "source/drivers/system_wait.asm"
 %include "source/drivers/system_memory_managment.asm"
 %include "source/drivers/system_acpi.asm"
 %include "source/drivers/system_time.asm"

 %include "source/drivers/sound_ac97.asm"
 %include "source/drivers/sound_hda.asm"

 %include "source/drivers/hardware_keyboard_layouts.asm"
 %include "source/drivers/hardware_ps2_controller.asm"
 %include "source/drivers/hardware_ps2_keyboard.asm"
 %include "source/drivers/hardware_ps2_mouse.asm"

 %include "source/drivers/hardware_storage_center.asm"
 %include "source/drivers/hardware_ide.asm"
 %include "source/drivers/hardware_ahci.asm"
 %include "source/drivers/hardware_paralel_ata.asm"
 %include "source/drivers/hardware_paralel_atapi.asm"
 %include "source/drivers/hardware_serial_ata.asm"
 ;;;%include "source/drivers/hardware_serial_atapi.asm"

 %include "source/drivers/usb_center.asm"
 %include "source/drivers/usb_ohci.asm"
 %include "source/drivers/usb_uhci.asm"
 %include "source/drivers/usb_ehci.asm"
 ;;;%include "source/drivers/usb_xhci.asm"

 %include "source/drivers/usb_keyboard.asm"
 %include "source/drivers/usb_mouse.asm"
 %include "source/drivers/usb_mass_storage.asm"

 %include "source/drivers/filesystem_jus.asm"
 %include "source/drivers/filesystem_fat32.asm"
 %include "source/drivers/filesystem_iso9660.asm"

 %include "source/drivers/network_center.asm"
 ;;;%include "source/drivers/network_protocols.asm"
 ;;;%include "source/drivers/network_ethernet_nic_intel.asm"
 %include "source/drivers/network_ethernet_nic_amd.asm"

 %include "source/gui/board_main.asm"
 %include "source/gui/board_developer_zone.asm"
 %include "source/gui/board_hardware_centrum.asm"
 %include "source/gui/library_elements.asm"
 %include "source/gui/library_images.asm"
 %include "source/gui/library_programs.asm"
 %include "source/gui/library_file_dialogue.asm"
 %include "source/gui/library_encrypting.asm"
 %include "source/gui/library_convert_graphic_files.asm"

 %include "source/programs/dp_hardware_info.asm"
 %include "source/programs/dp_intel_hd_audio.asm"
 %include "source/programs/dp_ide.asm"
 %include "source/programs/dp_mouse.asm"
 %include "source/programs/dp_acpi.asm"

 %include "source/programs/text_editor/text_editor.asm"
 %include "source/programs/media_viewer/media_viewer.asm"
 %include "source/programs/internet_browser/html_drawing.asm"
 %include "source/programs/internet_browser/internet_browser.asm"
 %include "source/programs/document_editor/document_editor.asm"

start_bleskos:
 call init_graphic
 CLEAR_SCREEN 0x00C000
 call redraw_screen

 PSTR 'Reading size of RAM memory...', bootstr_ramsize
 call read_memory_size
 PSTR 'Enabling interrupts...', bootstr_interrupts
 call init_idt
 call set_pit
 PSTR 'Scanning PCI...', bootstr_pci
 call scan_pci
 call init_keyboard
 PSTR 'Reading ACPI table...', bootstr_acpi
 call read_acpi
 PSTR 'Initalizing IDE drives...', bootstr_ide
 call init_ahci
 call init_ide
 PSTR 'Initalizing sound card...', bootstr_sound_card
 call init_ac97
 call init_sound_card
 PSTR 'Initalizing PS/2 devices...', bootstr_ps2
 call init_ps2_controller
 call enable_touchpad
 PSTR 'Read JUS informations...', bootstr_jus
 call init_jus
 PSTR 'Initalizing USB ports...', bootstr_usb
 call init_usb_controllers
 PSTR 'Allocating memory for programs...', bootstr_mem_alloc
 call init_memory_of_programs

 call main_window

 HALT
