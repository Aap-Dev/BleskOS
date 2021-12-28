;BleskOS

;this is 8x8 font for unicode coding
;some chars are copied from VGA font

;font is localized for english, slovak and czech

%define FONT_NO_CHAR db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

 bleskos_font times 31 FONT_NO_CHAR
 db 0x00, 0x18, 0x3C, 0x7E, 0x7E, 0x3C, 0x18, 0x00, ;comma in middle of line
 db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, ;space
 db 0x18, 0x18, 0x18, 0x18, 0x18, 0x00, 0x18, 0x00, ; !
 db 0x24, 0x24, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, ; "
 db 0x6C, 0x6C, 0xFE, 0x6C, 0xFE, 0x6C, 0x6C, 0x00, ; # vga
 db 0x18, 0x7E, 0xC0, 0x7C, 0x06, 0xFC, 0x18, 0x00, ; $ vga
 db 0x00, 0xC6, 0xCC, 0x18, 0x30, 0x66, 0xC6, 0x00, ; % vga
 db 0x38, 0x6C, 0x38, 0x76, 0xDC, 0xCC, 0x76, 0x00, ; & vga
 db 0x10, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, ; '
 db 0x10, 0x20, 0x40, 0x40, 0x40, 0x20, 0x10, 0x00, ; (
 db 0x20, 0x10, 0x08, 0x08, 0x08, 0x10, 0x20, 0x00, ; )
 db 0x00, 0x24, 0x18, 0x7E, 0x18, 0x24, 0x00, 0x00, ; *
 db 0x00, 0x10, 0x10, 0x7C, 0x10, 0x10, 0x00, 0x00, ; +
 db 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x20, ; ,
 db 0x00, 0x00, 0x00, 0x7E, 0x00, 0x00, 0x00, 0x00, ; -
 db 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, ; .
 db 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x00, ; /
 db 0x18, 0x24, 0x42, 0x42, 0x42, 0x24, 0x18, 0x00, ; 0
 db 0x10, 0x30, 0x50, 0x10, 0x10, 0x10, 0x7C, 0x00, ; 1
 db 0x18, 0x24, 0x42, 0x04, 0x18, 0x20, 0x7E, 0x00, ; 2
 db 0x3C, 0x42, 0x02, 0x1C, 0x02, 0x42, 0x3C, 0x00, ; 3
 db 0x08, 0x10, 0x20, 0x48, 0x7E, 0x08, 0x08, 0x00, ; 4
 db 0x7E, 0x40, 0x40, 0x7C, 0x02, 0x42, 0x3C, 0x00, ; 5
 db 0x3C, 0x42, 0x40, 0x7C, 0x42, 0x42, 0x3C, 0x00, ; 6
 db 0x7E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x00, ; 7
 db 0x3C, 0x42, 0x42, 0x3C, 0x42, 0x42, 0x3C, 0x00, ; 8
 db 0x3C, 0x42, 0x42, 0x3E, 0x02, 0x42, 0x3C, 0x00, ; 9
 db 0x00, 0x10, 0x10, 0x00, 0x00, 0x10, 0x10, 0x00, ; :
 db 0x00, 0x10, 0x10, 0x00, 0x00, 0x10, 0x10, 0x20, ; ;
 db 0x10, 0x20, 0x40, 0x80, 0x40, 0x20, 0x10, 0x00, ; <
 db 0x00, 0x00, 0x7E, 0x00, 0x7E, 0x00, 0x00, 0x00, ; =
 db 0x40, 0x20, 0x10, 0x08, 0x10, 0x20, 0x40, 0x00, ; >
 db 0x38, 0x44, 0x04, 0x08, 0x10, 0x00, 0x10, 0x00, ; ?
 db 0x7C, 0xC6, 0xDE, 0xDE, 0xDC, 0xC0, 0x7C, 0x00, ; @ vga
 db 0x18, 0x24, 0x42, 0x42, 0x7E, 0x42, 0x42, 0x00, ; A
 db 0x7C, 0x42, 0x42, 0x7C, 0x42, 0x42, 0x7C, 0x00, ; B 
 db 0x1C, 0x22, 0x40, 0x40, 0x40, 0x22, 0x1C, 0x00, ; C
 db 0x78, 0x44, 0x42, 0x42, 0x42, 0x44, 0x78, 0x00, ; D
 db 0x7E, 0x40, 0x40, 0x7E, 0x40, 0x40, 0x7E, 0x00, ; E
 db 0x7E, 0x40, 0x40, 0x7E, 0x40, 0x40, 0x40, 0x00, ; F
 db 0x1C, 0x22, 0x40, 0x4E, 0x42, 0x22, 0x1C, 0x00, ; G
 db 0x42, 0x42, 0x42, 0x7E, 0x42, 0x42, 0x42, 0x00, ; H
 db 0x7C, 0x10, 0x10, 0x10, 0x10, 0x10, 0x7C, 0x00, ; I
 db 0x02, 0x02, 0x02, 0x42, 0x42, 0x42, 0x3C, 0x00, ; J
 db 0x42, 0x44, 0x48, 0x70, 0x48, 0x44, 0x42, 0x00, ; K
 db 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x7E, 0x00, ; L
 db 0x42, 0x66, 0x5A, 0x42, 0x42, 0x42, 0x42, 0x00, ; M
 db 0x42, 0x62, 0x52, 0x4A, 0x4A, 0x46, 0x42, 0x00, ; N
 db 0x3C, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, ; O
 db 0x7C, 0x42, 0x42, 0x7C, 0x40, 0x40, 0x40, 0x00, ; P
 db 0x18, 0x24, 0x42, 0x42, 0x4A, 0x24, 0x1A, 0x00, ; Q
 db 0x7C, 0x42, 0x42, 0x7C, 0x48, 0x44, 0x42, 0x00, ; R
 db 0x3C, 0x42, 0x40, 0x3C, 0x02, 0x42, 0x3C, 0x00, ; S
 db 0xFE, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x00, ; T
 db 0x42, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, ; U
 db 0x82, 0x82, 0x82, 0x82, 0x44, 0x28, 0x10, 0x00, ; V
 db 0x92, 0x92, 0x92, 0x92, 0x92, 0x54, 0x28, 0x00, ; W
 db 0x42, 0x42, 0x24, 0x18, 0x24, 0x42, 0x42, 0x00, ; X
 db 0x82, 0x82, 0x44, 0x28, 0x10, 0x10, 0x10, 0x00, ; Y
 db 0x7E, 0x02, 0x04, 0x08, 0x10, 0x20, 0x7E, 0x00, ; Z
 db 0x78, 0x40, 0x40, 0x40, 0x40, 0x40, 0x78, 0x00, ; [
 db 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x00, ; /
 db 0x78, 0x08, 0x08, 0x08, 0x08, 0x08, 0x78, 0x00, ; ]
 db 0x10, 0x38, 0x6C, 0xC6, 0x00, 0x00, 0x00, 0x00, ; arrow up vga
 db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, ; arrow left vga
 db 0x10, 0x10, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, ; '
 db 0x00, 0x00, 0x78, 0x04, 0x7C, 0x84, 0x7A, 0x00, ; a
 db 0x40, 0x40, 0x40, 0x7C, 0x42, 0x42, 0x7C, 0x00, ; b
 db 0x00, 0x00, 0x3C, 0x42, 0x40, 0x42, 0x3C, 0x00, ; c
 db 0x02, 0x02, 0x02, 0x3E, 0x42, 0x42, 0x3E, 0x00, ; d
 db 0x00, 0x00, 0x3C, 0x42, 0x7E, 0x40, 0x3E, 0x00, ; e
 db 0x1C, 0x22, 0x20, 0x78, 0x20, 0x20, 0x20, 0x00, ; f
 db 0x00, 0x00, 0x3E, 0x42, 0x42, 0x3E, 0x02, 0x7C, ; g
 db 0x40, 0x40, 0x5C, 0x62, 0x42, 0x42, 0x42, 0x00, ; h
 db 0x08, 0x00, 0x18, 0x08, 0x08, 0x08, 0x1C, 0x00, ; i
 db 0x04, 0x00, 0x0C, 0x04, 0x04, 0x44, 0x44, 0x38, ; j
 db 0x40, 0x40, 0x44, 0x48, 0x70, 0x48, 0x44, 0x00, ; k
 db 0x30, 0x10, 0x10, 0x10, 0x10, 0x10, 0x38, 0x00, ; l
 db 0x00, 0x00, 0xEC, 0x92, 0x92, 0x92, 0x92, 0x00, ; m 
 db 0x00, 0x00, 0x5C, 0x62, 0x42, 0x42, 0x42, 0x00, ; n
 db 0x00, 0x00, 0x3C, 0x42, 0x42, 0x42, 0x3C, 0x00, ; o
 db 0x00, 0x00, 0x7C, 0x42, 0x42, 0x7C, 0x40, 0x40, ; p
 db 0x00, 0x00, 0x3E, 0x42, 0x42, 0x3E, 0x02, 0x02, ; q
 db 0x00, 0x00, 0x3C, 0x42, 0x40, 0x40, 0x40, 0x00, ; r
 db 0x00, 0x00, 0x7C, 0x80, 0x78, 0x04, 0xF8, 0x00, ; s
 db 0x10, 0x10, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x00, ; t
 db 0x00, 0x00, 0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, ; u
 db 0x00, 0x00, 0x42, 0x42, 0x42, 0x24, 0x18, 0x00, ; v
 db 0x00, 0x00, 0x92, 0x92, 0x92, 0x92, 0x6C, 0x00, ; w
 db 0x00, 0x00, 0x42, 0x24, 0x18, 0x24, 0x42, 0x00, ; x
 db 0x00, 0x00, 0x42, 0x42, 0x42, 0x3E, 0x02, 0x3C, ; y
 db 0x00, 0x00, 0x7E, 0x04, 0x18, 0x20, 0x7E, 0x00, ; z
 db 0x1C, 0x20, 0x20, 0xC0, 0x20, 0x20, 0x1C, 0x00, ; {
 db 0x10, 0x10, 0x10, 0x00, 0x10, 0x10, 0x10, 0x00, ; |
 db 0xC0, 0x20, 0x20, 0x18, 0x20, 0x20, 0xC0, 0x00, ; }
 db 0x76, 0xDC, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, ; ~
 db 0x00, 0x10, 0x38, 0x6C, 0xC6, 0xC6, 0xFE, 0x00, ; delete
 times 0x20 FONT_NO_CHAR ;control
 times 0x20 FONT_NO_CHAR ;symbols
 db 0x20, 0x10, 0x18, 0x24, 0x42, 0x7E, 0x42, 0x42, ; À
 db 0x04, 0x08, 0x18, 0x24, 0x42, 0x7E, 0x42, 0x42, ; Á
 db 0x10, 0x28, 0x18, 0x24, 0x42, 0x7E, 0x42, 0x42, ; Â
 db 0x7E, 0x18, 0x24, 0x42, 0x42, 0x7E, 0x42, 0x42, ; Ã
 db 0x24, 0x18, 0x24, 0x42, 0x42, 0x7E, 0x42, 0x42, ; Ä
 db 0x18, 0x24, 0x18, 0x24, 0x42, 0x7E, 0x42, 0x42, ; Å
 times 2 FONT_NO_CHAR
 db 0x20, 0x10, 0x7E, 0x40, 0x7E, 0x40, 0x40, 0x7E, ; È
 db 0x04, 0x08, 0x7E, 0x40, 0x7E, 0x40, 0x40, 0x7E, ; É
 db 0x10, 0x28, 0x7E, 0x40, 0x7E, 0x40, 0x40, 0x7E, ; Ê
 db 0x24, 0x00, 0x7E, 0x40, 0x7E, 0x40, 0x40, 0x7E, ; Ë
 db 0x20, 0x10, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x7C, ; Ì
 db 0x04, 0x08, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x7C, ; Í
 db 0x10, 0x28, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x7C, ; Î
 db 0x44, 0x00, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x7C, ; Ï
 FONT_NO_CHAR
 db 0x3C, 0x42, 0x62, 0x52, 0x4A, 0x4A, 0x46, 0x42, ; Ñ
 db 0x20, 0x10, 0x3C, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ò
 db 0x04, 0x08, 0x3C, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ó
 db 0x10, 0x28, 0x3C, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ô
 db 0x3C, 0x00, 0x3C, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Õ
 db 0x24, 0x00, 0x3C, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ö
 db 0x00, 0x00, 0x42, 0x24, 0x18, 0x24, 0x42, 0x00, ; ×
 FONT_NO_CHAR
 db 0x20, 0x10, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ù
 db 0x08, 0x10, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ú
 db 0x10, 0x28, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Û
 db 0x24, 0x00, 0x42, 0x42, 0x42, 0x42, 0x42, 0x3C, ; Ü
 db 0x08, 0x10, 0x44, 0x44, 0x28, 0x10, 0x10, 0x10, ; Ý
 FONT_NO_CHAR
 db 0x38, 0x44, 0x44, 0x4C, 0x42, 0x42, 0x5C, 0x00, ; ß
 FONT_NO_CHAR
 db 0x08, 0x10, 0x78, 0x04, 0x7C, 0x84, 0x7A, 0x00, ; á
 times 7 FONT_NO_CHAR
 db 0x04, 0x08, 0x3C, 0x42, 0x7E, 0x40, 0x3E, 0x00, ; é
 times 3 FONT_NO_CHAR
 db 0x04, 0x08, 0x18, 0x08, 0x08, 0x08, 0x1C, 0x00, ; í
 times 5 FONT_NO_CHAR
 db 0x04, 0x08, 0x3C, 0x42, 0x42, 0x42, 0x3C, 0x00, ; ó
 times 6 FONT_NO_CHAR
 db 0x08, 0x10, 0x42, 0x42, 0x42, 0x42, 0x3C, 0x00, ; ú
 times 2 FONT_NO_CHAR
 db 0x08, 0x10, 0x42, 0x42, 0x42, 0x3E, 0x02, 0x3C, ; ý
 times 2 FONT_NO_CHAR
 times 0xD FONT_NO_CHAR
 db 0x24, 0x18, 0x3C, 0x42, 0x40, 0x42, 0x3C, 0x00, ; č
 FONT_NO_CHAR
 db 0x07, 0x03, 0x02, 0x3E, 0x42, 0x42, 0x3E, 0x00, ; ď
 times 11 FONT_NO_CHAR
 db 0x24, 0x18, 0x3C, 0x42, 0x7E, 0x40, 0x3E, 0x00, ; ě
 times 34 FONT_NO_CHAR
 db 0x34, 0x18, 0x10, 0x10, 0x10, 0x10, 0x38, 0x00, ; ľ
 times 9 FONT_NO_CHAR
 db 0x24, 0x18, 0x5C, 0x62, 0x42, 0x42, 0x42, 0x00, ; ň
 times 12 FONT_NO_CHAR
 db 0x08, 0x10, 0x3C, 0x42, 0x40, 0x40, 0x40, 0x00, ; ŕ
 times 3 FONT_NO_CHAR
 db 0x24, 0x18, 0x3C, 0x42, 0x40, 0x40, 0x40, 0x00, ; ř
 times 7 FONT_NO_CHAR
 db 0x24, 0x18, 0x7C, 0x80, 0x78, 0x04, 0xF8, 0x00, ; š
 times 3 FONT_NO_CHAR
 db 0x14, 0x18, 0x7C, 0x10, 0x10, 0x10, 0x10, 0x00, ; ť
 times 24 FONT_NO_CHAR
 db 0x24, 0x18, 0x7E, 0x04, 0x18, 0x20, 0x7E, 0x00, ; ž
