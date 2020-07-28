*--------------------------------------------------*
*            _______      ___________              *
*           /_  __/ | /| / / ___/ __/              *
*            / /  | |/ |/ / (_ /\ \                *
*           /_/   |__/|__/\___/___/    (v1.8s)     *
*                                                  *
* TWGS32K ROM  - V1.8s Binary Parity!              *
* Source Disassembly - V0.3 Internal Release #1    *
*                                                  *
* This will assemble into an exact binary match of *
* of the TransWarp IIgs 1.8s marked ROMs.          *
* For this reason, no changes have been made to    *
* the structure of the code, including leaving in  *
* unused bytes and such for historical accuracy.   *
*                                                  *
* This commented Merlin version by Dagen Brock.    *
* Massive thanks for the major contributions from  *
* Geoff Body, Antoine Vignau, and UltimateMicro.   *
*                                                  *
* Literally entire portions of the comments are    *
* from GeoffB and not me.  I just adapted them to  *
* my disassembly and do not take credit, though I  *
* have added my own work on top of that to other   *
* portions of the code and intend to add more      *
* details as I discover them.  Just trying to      *
* give appropriate credit.                         *
*                                                  *
* This version is probably about 80% complete on   *
* labeling and about 5-10% complete on comments.   *
* Unfortunately my disassembler broke so I let     *
* sit for far too long, but it's out there now!    *
*                                                  *
* Tools used: The Flaming Bird Disassembler        *
*             Merlin 16+                           *
*             Merlin 32 (brutaldeluxe.fr)          *
*             CADIUS    (brutaldeluxe.fr)          *
*             vim,bash,PHP,git                     *
*--------------------------------------------------*

                              mx        %00
                              org       $BC8000
                              lst       off
                              use       twgs.MAC
*-----------
* @todo
NEEDS_NAME1                   =         $CB
NEEDS_NAME2                   =         $F5


*-----------
TWGS_Cache                    =         $02
TWGS_IRQ                      =         $08
TWGS_Config_Byte              =         $0E
HPOS                          =         $2C
VPOS                          =         $2E
Text_Offset                   =         $30
80_Column                     =         $32
Pascal_String_Length          =         $33
Text_Mask                     =         $35
Char_MSB_Flag                 =         $36
FPGA_Data_Ptr                 =         $38
FPGA_Bit_Offset               =         $3A
FPGA_Map_Mask_Ptr             =         $3C
FPGA_Frame_Count              =         $3E
Cache_Size                    =         $51
Cache_Max_Mask                =         $53

NVRAM_CMD_Disable_Write       =         #$80
NVRAM_CMD_Store               =         #$81
NVRAM_CMD_Write_RAM           =         #$83
NVRAM_CMD_Enable_Write        =         #$84
NVRAM_CMD_Recall              =         #$85
NVRAM_CMD_Read_RAM            =         #$86


Fake_Key_Flag                 =         $83

SrcPtr32                      =         $CF                           ; gfx unpack routine source (4Bytes $cf-$d2)
DstPtr32                      =         $D3                           ; gfx unpack routine destination (4Bytes $d3-$d6)

Image_Width                   =         $E3
Image_Height                  =         $EB
Display_Width                 =         $E5
Display_Height                =         $ED
Image_Ptr                     =         $F3


RDVBLBAR                      =         $C019
VERTCNT                       =         $C02E
HORIZCNT                      =         $C02F

SLTROMSEL                     =         $E0C02D
CYAREG                        =         $E0C036                       ; Speed Register, same as $00?
SoundCtl                      =         $E0C03C
SoundData                     =         $E0C03D
SoundAdrL                     =         $E0C03E
SoundAdrH                     =         $E0C03F
TXTPAGE1                      =         $E0C054
TXTPAGE2                      =         $E0C055
MOTOR4OFF                     =         $E0C0C8
MOTOR4ON                      =         $E0C0C9
MOTOR5OFF                     =         $E0C0D8
MOTOR5ON                      =         $E0C0D9
MOTOR7OFF                     =         $E0C0F8
MOTOR7ON                      =         $E0C0F9
RD80VID                       =         $E0C01F
INTMGRV                       =         $E10010

ptr000000                     =         $000000
TWGS_Control                  =         $BC0000
TWGS_Serial_Data              =         $BC4000
TWGS_Serial_Control           =         $BC4001



8Bits                         =         $0008
8KMask                        =         $1FFF
8KSize                        =         $2000                         ; 8192 bytes  = 8K
32KSize                       =         $8000                         ; 32768 bytes = 32K
FPGA_Max_Frames               =         #$00A0                        ; 160 frames
FPGA_Max_Frame_Bytes          =         #09
*-----------

                              MX        %00

FPGA_Config                   HEX       FF04400FFB2EBF3FFE7FFEFCBCFFB779
                              HEX       B5FAFFC7FDFDFFBFF9F5E3EECD9B8FC5
                              HEX       EF8DEFDF9DFFDFF2FB6FEFFFFDBAFFDB
                              HEX       F7F7F77FFFDBDFF7CBBFAFAFFBFB2FFF
                              HEX       FDFD66F9BBEADF7FBEEFEAFFDBD4DFF7
                              HEX       EAFFD7FFFDBFFFFF9F77F7FCE9EEEFFC
                              HEX       DFD33BBFB76F7F7FFFF6FEFEF9B57DBB
                              HEX       FFFBFFB7BEEFEEEDFADF5FBFBFF776EE
                              HEX       EFD7FAFEEFBFBDFF63B9DDFABB7777F9
                              HEX       E4DDD3B767FFDFFFEF4FEFD44DADFAF7
                              HEX       FB67737DF7AFEBF7DDFD7B3FEF3FF9FF
                              HEX       F7FFFFEDEDFFDF197BFB7E17B2ACF554
                              HEX       EFCD7FFBDBD3ABBFF77F73FBDFDFDEBC
                              HEX       F9B5EF737FFF5ECF9FFDFDDD9DFDDEB7
                              HEX       F1F6EBEA6FEE5872BBFEFCFC79393DC7
                              HEX       EFEE7DEFFFD3FFF9B9FE67C5FCF5DE8F
                              HEX       9DE5FDFD2DFFFB3BFC7DF5AF7EEF5BDF
                              HEX       DDBFFFB5777AFFDDF6EEFBF5B58FFBFF
                              HEX       BBF6FF7FFFFFBFDFDBDEFDDFBEAAFDFF
                              HEX       EF9CEF3FEEEDFEFFDD7DD7FEABB8D6DF
                              HEX       E5F3D73B767FFFFEFCFE68FFDFFDBF7B
                              HEX       7775F7AACAFEEFFFBF7DBFBEFB7FFF77
                              HEX       CE4EDEBC9975EFBBDF737B7A76FDF4B9
                              HEX       FBEFDF5EDAB57F37EEE77BFBDCFDFDBB
                              HEX       FF7FFF7F7FE7DFEEFD6D7DDBDFF9BB9E
                              HEX       9F3FA937587D73DCDDFFEF7BFFFB5CE6
                              HEX       DD8F99FE3DB3FFF3FF777A6EFFFFFEFE
                              HEX       BEFDFFBFEBFBBB777FFFEFEEFEDDDFDD
                              HEX       BBBFA7DF5F7FFDFCFEFEFDFDFFFFEF7F
                              HEX       E7D7D72F3FAF5FDBFABBFDBDFA7FE7FF
                              HEX       F7EFF7BDF5DDEF7BFBFFFFBECFF9F7CB
                              HEX       FE62DEBFF5776DFF9B7D9D7D7B3BDE73
                              HEX       F7F5EEEFDE97F7FF5DBDEAFF76F5B8FC
                              HEX       FEFFFCEFFBFBFFBFCFDF7FE7EDEDD9D9
                              HEX       CDD797F2BF3FE76F5F6BEFFFDEFAD9BD
                              HEX       5B737BBBDFF7F6CFDD7CFBBBBFFFFF77
                              HEX       75EB67FDC7DFAFE5E7B37369F583C3B3
                              HEX       77E5A7DCFDD3FEFFFBFF7F7EFF9ADF9F
                              HEX       FDFDBFF6FE3F677FFFEAFFEADDDFF3BF
                              HEX       BDBFEF7FFFBFBEFEDAEDF5EDCBFBEF57
                              HEX       F6DEEEEFFFFBFDFDFFFFF37FFEEFFDFF
                              HEX       DBAFF5A5F6A37FBE76BB73F3F2ECDCEF
                              HEX       BB8BFFEF56DF8EFFFCC5B5FBBBFAA535
                              HEX       7FF77EEF9DDDF6EBABEF3DFDFEF7FFFF
                              HEX       EFFFFFD7391B6752B2FEE57CDCEFA9EF
                              HEX       D5D7FFEF67F67F6F65DFDEFEFF9BBFFB
                              HEX       F37FFF6EEE5EFFFDBD9DFBBBF7F7BB7D
                              HEX       6E6FEB767EFAF4F47E2D6D3D67AFFF7F
                              HEX       FFEFF7F6BBBD7EAFF7FADEEADF8AEEFD
                              HEX       FDFFFB7BFAF575FDCEFEEFF7FFFFB7BF
                              HEX       BF7F7EFFFFFAFFF2E5F5FFFBFFBB7F7F
                              HEX       7E7FFDBFDFDBEFFEBD97BFFDBDEF9CEF
                              HEX       7FFCFEFFFA5AFEE766E36A4FC38DE7E7
                              HEX       3F777FAFFEEEFFF5FCDFFDBF4A55DFDD
                              HEX       BAF7FACF7F9FFFFEFFFAFBFF77CEC6BE
                              HEX       DD9F757F7BFD7B737EEED7FFFAEB7BDF
                              HEX       5F3FFDB5F3FE7FF3FFDCDFEFB3BFFBDF
                              HEX       BF7FA79FE6EFFC2DDFB9D9BB9AD3BD39
                              HEX       BE5F7972DFDD7BFFFFBFFFFFEFE78FF9
                              HEX       FFF5FFF2EBEFEF797EEFDFFFDFFEBFFD
                              HEX       BFEBBFBB77FF7FFFFEFFDCDDDBE5EFFF
                              HEX       77CF77FDFA9FBAFFCDFFDFFB7BE797F7
                              HEX       AFFDFEDEDDFFBBFBFBFE77FFFFDFFFFE
                              HEX       B9FDF4DFFFBDB7DAD7CE793BFFFFFEFF
                              HEX       EFBA7FEE9E6E357FDD3AFAFE73F7F7EF
                              HEX       EFE7DF9DFEDDBFABF7FDD7EFAEEFFDFC
                              HEX       EDDBFFFFFFF7F77FE7ECE5C9EADF73BF
                              HEX       7BBFB76F5777F7EBFEFFF6FDF97FF37B
                              HEX       EF76BEF6CFFC7E7BFF7FF777F777FA76
                              HEX       DFFFFDACFF9DBFEBE9FDD3F2BB8737E7
                              HEX       DDFF9BFEF77FFEF9FFFB889FDF6B6FBD
                              HEX       BFF29BD7F7B4EEEFFBDDD7DE3FBFFF5F
                              HEX       7F7BFDFBFEDEEDEFF5EFBFBFF7D7FFEE
                              HEX       EEFD5AFDDFFFFFFF727F27FFF74ABFAD
                              HEX       F4AFE3FDEFF1FBFFF5BBF6DDBF81EAFD
                              HEX       4ED79BFFEFEEDDFDFAFBD3FFFF7DF7E6
                              HEX       FA75FDD5BF6BE93FFDFFFFFFFFFFFFFD
                              HEX       DFBD3BE936F6DEECAF5FEFECF9B55137
                              HEX       BBEFFF7F6FFFF7DBF6BFDDFFF7D327FF
                              HEX       FFEFFFDDDFDF9D7BDBB777BFED7F7BEB
                              HEX       7C7EFFF6B4F6E9CD15B7BFAFDF7FFBFF
                              HEX       FAFFBD7C65537777E7AFFEEC7D3F9FFB
                              HEX       FB7BF7F7FCAEFFEF7FDF7EBFF9BB7F76
                              HEX       77FDFAFEFAE5B7FFF3BFFF5FD7FFBFFF
                              HEX       FCDFFF7BF7BFF7FFEDAFFF7C7F3FFD3F
                              HEX       FD797B7B57EDFDDCF7DDBDA3633D575E
                              HEX       EFFCEF7DD9DDCFBD9AFA77F7F7FAEFDB
                              HEX       CFFFFFFFFFFFFFFFFE77DFFEBE9F8DAF
                              HEX       3B3BFF7BEEB7F774F7DDECBDDFFBFDB7
                              HEX       B7BFFF6FEFFFECDDAFFFFF5FFF777FE7
                              HEX       F7F7BFFDFCDA7BDB3B5ADF2F3E2F5F7F
                              HEX       5CDF75DF79BF77EFEFDFCEEFBEA8F4FD
                              HEX       7FEDBBE77FFDFF9F8F9F3F1F7FFDB33B
                              HEX       BBF4FC74E9E9F1DFFDFDFDFBFFFBF7F7
                              HEX       FFFF

*-----------

CDA_Install_Hdr               STR       "TransWarp GS"                ; CDA
                              ADRL      CDA_Startup
                              ADRL      CDA_Shutdown

NVRAM_Disable                 PHP
                              SEP       #$20                          ; 8-bit M
                              NOP                                     ; all SEP/REP are followed by NOP for stability at
                                                                      ; higher speeds.  
                              JSR       GS_1MHZ                       ; set CPU @ 1MHz
                              PHA                                     ; store previous speed
                              LDA       #$00
                              STAL      TWGS_Serial_Control           ; turn off chip select of NVRam, bit7
                              PLA                                     ;\__ restore original speed
                              JSR       GS_Speed_Restore              ;/
                              PLP
                              RTS

                              MX        %11
NVRAM_Send_Byte               PHA                                     ; save data to be sent
                              LDA       #$80
                              STAL      TWGS_Serial_Control           ; enable chip select of NVRAM
                              PLA                                     ; retrieve data
                              PHY                                     ; save y
                              LDY       #$08                          ; # of bits to send
NVRAM_Send_Bit                STAL      TWGS_Serial_Data              ; send serial data msb *yes, bit
                              ASL                                     ; next bit
                              DEY                                     ; bits remaining--
                              BNE       NVRAM_Send_Bit                ; loop until all 8 bits sent
                              PLY                                     ; restore y
                              RTS


NVRAM_Send_Cmd_and_Read       PHA                                     ; save data to be sent
                              LDA       #$80
                              STAL      TWGS_Serial_Control           ; enable chip select of NVRAM
                              PLA                                     ; retrieve data
                              PHY                                     ; save y
                              LDY       #$07                          ; # of bits to send
:nvram_cmd_bit                STAL      TWGS_Serial_Data              ; send serial data msb
                              ASL                                     ; next bit
                              DEY                                     ; bits remaining--
                              BNE       :nvram_cmd_bit                ; loop until 7 bits sent
                              LDA       #NVRAM_CMD_Store
                              STAL      TWGS_Serial_Control           ; enable NVRAM set to read data 
                              STAL      TWGS_Serial_Data              ; send last bit of command (msb=1?) and read data
                              PLY                                     ; restore y
                              RTS


NVRAM_Send_Cmd                JSR       NVRAM_Send_Byte
                              LDA       #$00
                              STAL      TWGS_Serial_Control
                              RTS


NVRAM_Write_Word              PHA
                              TXA
                              AND       #$0F
                              ASL
                              ASL
                              ASL
                              ORA       #NVRAM_CMD_Write_RAM
                              JSR       NVRAM_Send_Byte
                              PLA
                              JSR       NVRAM_Send_Byte
                              TYA
                              JSR       NVRAM_Send_Byte
                              LDA       #$00
                              STAL      TWGS_Serial_Control
                              RTS


NVRAM_Modify_Word             PHA
                              JSR       NVRAM_Read_Word
                              PLA
                              JMP       NVRAM_Write_Word


NVRAM_Read_Byte               LDA       #$81
                              STAL      TWGS_Serial_Control
                              PHY
                              LDY       #$08
:nvram_read_bit               PHA
                              LDAL      TWGS_Serial_Data
                              ASL
                              PLA
                              ROL
                              DEY
                              BNE       :nvram_read_bit
                              PLY
                              RTS


NVRAM_Read_Word               TXA
                              AND       #$0F
                              ASL
                              ASL
                              ASL
                              ORA       #NVRAM_CMD_Read_RAM
                              JSR       NVRAM_Send_Cmd_and_Read
                              JSR       NVRAM_Read_Byte
                              PHA
                              JSR       NVRAM_Read_Byte
                              TAY
                              LDA       #$00
                              STAL      TWGS_Serial_Control
                              PLA
                              RTS


NVRAM_Active                  LDA       #NVRAM_CMD_Enable_Write
                              JSR       NVRAM_Send_Cmd
                              LDX       #$06
                              LDA       #$AE
                              JSR       NVRAM_Modify_Word
                              LDA       #NVRAM_CMD_Disable_Write
                              JSR       NVRAM_Send_Cmd
                              RTS


NVRAM_Recall                  REP       #$30
                              NOP
                              JSR       NVRAM_Read_Speed
                              PHA
                              SEP       #$30
                              NOP
                              LDA       #NVRAM_CMD_Recall
                              JSR       NVRAM_Send_Cmd
                              JSR       NVRAM_Active
                              REP       #$30
                              NOP
                              PLA
                              JSR       NVRAM_Write_Speed
                              SEP       #$30
                              NOP
                              RTS


NVRAM_CMP_2_RAM               JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              LDA       #$00
                              STAL      TWGS_Serial_Data
                              JSR       NVRAM_Recall
                              LDX       #$00


NVRAM_CMP_Read                JSR       NVRAM_Read_Word
                              CPX       #$13
                              BEQ       NVRAM_CMP_Skip
                              CPX       #$14
                              BEQ       NVRAM_CMP_Skip
                              CMP       $0C,X
                              BNE       NVRAM_CMP_Diff


NVRAM_CMP_Skip                TYA
                              CMP       $1C,X
                              BNE       NVRAM_CMP_Diff
                              INX
                              CPX       #$10
                              BCC       NVRAM_CMP_Read
                              PLA
                              JSR       GS_Speed_Restore
                              CLC
                              RTS


NVRAM_CMP_Diff                PLA
                              JSR       GS_Speed_Restore
                              SEC
                              RTS


NVRAM_Save                    REP       #$30
                              NOP
                              JSR       NVRAM_Read_Speed
                              STA       $13
                              SEP       #$30
                              NOP
                              JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              JSR       NVRAM_CMP_2_RAM
                              BCC       NVRAM_No_Save
                              LDA       #NVRAM_CMD_Enable_Write
                              JSR       NVRAM_Send_Cmd
                              LDA       #$00
                              STA       $12
                              INC       $0F
                              BNE       NVRAM_Save1
                              INC       $10
                              BNE       NVRAM_Save1
                              INC       $11
NVRAM_Save1                   LDX       #$00
:nvram_save_loop              LDA       $1C,X
                              TAY
                              LDA       $0C,X
                              JSR       NVRAM_Write_Word
                              INX
                              CPX       #$10
                              BCC       :nvram_save_loop
                              LDA       #NVRAM_CMD_Store
                              JSR       NVRAM_Send_Cmd
                              LDX       #$14
:nvram_save_delay1            LDY       #$00
:nvram_save_delay2            DEY
                              BNE       :nvram_save_delay2
                              DEX
                              BNE       :nvram_save_delay1
                              LDA       #NVRAM_CMD_Disable_Write
                              JSR       NVRAM_Send_Cmd
                              JSR       NVRAM_Recall
NVRAM_No_Save                 PLA
                              JSR       GS_Speed_Restore
                              RTS


NVRAM_Validate                JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              JSR       NVRAM_Recall
                              LDX       #$00
:nvram_validate_loop          JSR       NVRAM_Read_Word
                              STA       $0C,X
                              TYA
                              STA       $1C,X
                              INX
                              CPX       #$10
                              BCC       :nvram_validate_loop
                              LDA       $0C
                              CMP       #$AE
                              BNE       :nvram_not_valid
                              LDA       $0D
                              CMP       #$01
                              BEQ       :nvram_valid
:nvram_not_valid              LDX       #$00
                              LDA       #$00
:nvram_new_valid              STA       $0C,X
                              INX
                              CPX       #$20
                              BCC       :nvram_new_valid
                              LDA       #$AE
                              STA       $0C
                              LDA       #$01
                              STA       $0D
                              LDA       #$0D                          ; default values?
                              STA       TWGS_Config_Byte
                              JSR       NVRAM_Save
:nvram_valid                  PLA
                              JSR       GS_Speed_Restore
                              RTS

GS_1MHZ                       PHP                                     ; save processor
                              SEP       #$20                          ; 8-bit m
                              NOP                                     ; stability NOP :P
                              LDAL      CYAREG                        ; read GS speed reg
                              PHA                                     ; save it
                              AND       #$7F                          ; mask fast speed (so, slow now)
                              STAL      CYAREG                        ; set GS speed reg to 1MHz
                              PLA                                     ; get previous speed
                              PLP                                     ; restore processor state (including m/x)
                              RTS

GS_FAST                       PHP
                              SEP       #$20
                              NOP
                              LDAL      CYAREG
                              PHA
                              ORA       #$80
                              STAL      CYAREG
                              PLA
                              PLP
                              RTS

TWGS_OFF                      PHP
                              SEP       #$20
                              NOP
                              LDAL      CYAREG
                              XBA
                              AND       #$7F
                              STAL      CYAREG
                              LDAL      TWGS_Control
                              PHA
                              AND       #$FB
                              STAL      TWGS_Control
                              XBA
                              STAL      CYAREG
                              PLA
                              PLP
                              RTS

TWGS_ON                       PHP
                              SEP       #$20
                              NOP
                              LDAL      CYAREG
                              XBA
                              AND       #$7F
                              STAL      CYAREG
                              LDAL      TWGS_Control
                              PHA
                              ORA       #$04
                              STAL      TWGS_Control
                              XBA
                              STAL      CYAREG
                              PLA
                              PLP
                              RTS

GS_Speed_Restore              PHP
                              SEP       #$20
                              NOP
                              STAL      CYAREG
                              PLP
                              RTS

SET_TW_MODE                   PHP
                              SEP       #$20
                              NOP
                              PHA
                              LDAL      CYAREG
                              XBA
                              AND       #$7F
                              STAL      CYAREG
                              PLA
                              STAL      TWGS_Control
                              XBA
                              STAL      CYAREG
                              PLP
                              RTS

READ_TW_MODE                  PHP
                              SEP       #$20
                              NOP
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              XBA
                              PLA
                              JSR       GS_Speed_Restore
                              XBA
                              PLP
                              RTS

SET_TW_MODE_KEEP_CACHE        PHP
                              SEP       #$20
                              NOP
                              AND       #$FD
                              PHA
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              AND       #$02
                              ORA       $02,S
                              STAL      TWGS_Control
                              PLA
                              JSR       GS_Speed_Restore
                              PLA
                              PLP
                              RTS

CONFIG_TW_MODE_KEEP_CACHE     PHA
                              JSR       READ_TW_MODE
                              AND       #%11110011                    ; #$F3
                              PHA
                              LDA       $02,S
                              AND       #$03
                              ASL
                              ASL
                              ORA       $01,S
                              STA       $01,S
                              PLA
                              JSR       SET_TW_MODE_KEEP_CACHE
                              PLA
                              RTS

CONFIG_TW_From_NVRAM          JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              JSR       NVRAM_Recall
                              LDX       #$00
                              JSR       NVRAM_Read_Word
                              CMP       #$AE                          ; check first byte of NVRA
                              BNE       :use_defaults
                              LDX       #$01
                              JSR       NVRAM_Read_Word
                              CMP       #$01
                              BEQ       :config_tw_nvram_valid
:use_defaults                 LDA       #$0D
                              BRA       :config_tw
:config_tw_nvram_valid        LDX       #$02
                              JSR       NVRAM_Read_Word
:config_tw                    JSR       CONFIG_TW_MODE_KEEP_CACHE
                              PLA
                              JSR       GS_Speed_Restore
                              RTS

Config_to_TW_MODE             LDA       TWGS_Config_Byte
                              JSR       CONFIG_TW_MODE_KEEP_CACHE
                              RTS

NVRAM_Active_Check            JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              LDX       #$06
                              JSR       NVRAM_Read_Word
                              CMP       #$AE
                              SEC
                              BNE       :do_check
                              CLC
:do_check                     PHP
                              JSR       NVRAM_Active
                              PLP
                              PLA
                              JSR       GS_Speed_Restore
                              RTS

NVRAM_Read_Speed              PHP
                              PHA
                              SEP       #$30
                              NOP
                              JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              LDX       #$07
                              JSR       NVRAM_Read_Word
                              STA       $02,S
                              INX
                              JSR       NVRAM_Read_Word
                              STA       $03,S
                              PLA
                              JSR       GS_Speed_Restore
                              REP       #$30
                              NOP
                              PLA
                              PLP
                              RTS

NVRAM_Write_Speed             PHP
                              PHA
                              SEP       #$30
                              NOP
                              JSR       NVRAM_Disable
                              JSR       GS_1MHZ
                              PHA
                              LDA       #NVRAM_CMD_Enable_Write
                              JSR       NVRAM_Send_Cmd
                              LDX       #$07
                              LDA       $02,S
                              JSR       NVRAM_Modify_Word
                              INX
                              LDA       $03,S
                              JSR       NVRAM_Modify_Word
                              LDA       #NVRAM_CMD_Disable_Write
                              JSR       NVRAM_Send_Cmd
                              PLA
                              JSR       GS_Speed_Restore
                              REP       #$30
                              NOP
                              PLA
                              PLP
                              RTS

Check_Cache_Size              PHP
                              SEI
                              REP       #$30
                              NOP
                              PHA
                              SEP       #$20
                              NOP
                              JSR       GS_FAST
                              PHA
                              JSR       TWGS_ON
                              PHA
                              JSR       READ_TW_MODE
                              PHA
                              REP       #$20
                              NOP
                              JSR       IRQ_Logic_OFF
                              LDA       #Check_Cache_Size
                              AND       #8KMask                       ; mask 2 8k cache size 8192 bytes
                              TAX
                              LDA       #$A55A
                              STAL      $BF0000,X
                              LDA       #$5AA5
                              STAL      $BF2000,X
                              LDAL      $BF0000,X
                              CMP       #$A55A
                              BEQ       :found_32K_cache
                              LDA       #8KSize
                              BRA       :check_cache_size_found
:found_32K_cache              LDA       #32KSize
:check_cache_size_found       STA       $04,S
                              SEP       #$20
                              NOP
                              PLA
                              JSR       SET_TW_MODE_KEEP_CACHE
                              PLA
                              JSR       SET_TW_MODE
                              PLA
                              JSR       GS_Speed_Restore
                              REP       #$20
                              NOP
                              PLA
                              PLP
                              RTS

32Bit_Multiply                LDA       $00
                              STA       $04
                              LDA       $02
                              STA       $06
                              STZ       $00
                              STZ       $02
                              LDX       #$0020
:mul_loop                     ASL       $00
                              ROL       $02
                              ROL       $04
                              ROL       $06
                              BCC       :next
                              LDA       $00
                              CLC
                              ADC       $08
                              STA       $00
                              LDA       $02
                              ADC       $0A
                              STA       $02
:next                         DEX
                              BNE       :mul_loop
                              RTS

32Bit_Divide                  STZ       $04
                              STZ       $06
                              LDX       #$0020
:div_loop                     ASL       $00
                              ROL       $02
                              ROL       $04
                              ROL       $06
                              LDA       $04
                              CMP       $08
                              LDA       $06
                              SBC       $0A
                              BCC       :next
                              STA       $06
                              LDA       $04
                              SEC
                              SBC       $08
                              STA       $04
                              INC       $00
:next                         DEX
                              BNE       :div_loop
                              RTS

;
; Text routines
;

Text_Init                     JSR       Text_Normal
                              SEP       #$20
                              NOP
                              STZ       80_Column
                              LDAL      RD80VID
                              BPL       :not_80col
                              DEC       $32
:not_80col                    REP       #$20
                              NOP
                              JSR       Text_Clear_Window
                              RTS

Text_Normal                   SEP       #$20
                              NOP
                              LDA       #$FF
                              STA       Text_Mask
                              REP       #$20
                              NOP
                              RTS

Text_Inverse                  SEP       #$20
                              NOP
                              LDA       #$7F
                              STA       Text_Mask
                              REP       #$20
                              NOP
                              RTS

Text_Clear_Window             LDY       #$0000
:next_line                    LDX       #$0000
                              JSR       Text_Offset_For_X_Y
                              LDA       #$00A0                        ; " "
                              LDY       #$0028                        ; char count = #40
                              JSR       Text_Repeat_Char_Horiz
                              INC       VPOS
                              LDY       VPOS
                              CPY       #$0018                        ; bottom of screen = 24
                              BCC       :next_line
                              RTS

Text_Offset_For_X_VPOS        LDY       VPOS
                              JMP       Text_Offset_For_X_Y

                              LDX       HPOS
                              JMP       Text_Offset_For_X_Y

Text_Offset_For_X_Y           STX       HPOS
                              STY       VPOS
                              JSR       Text_Calculate_Offset
                              LDA       HPOS
                              BIT       80_Column-1                   ; check -1 to get flag in high byte of acc
                              BPL       :not_80col
                              LSR
                              CLC
                              ADC       #$000A                        ; offset by 10 to center in 40-col mode
:not_80col                    CLC
                              ADC       Text_Offset
                              STA       Text_Offset
                              RTS

Text_Calculate_Offset         TYA
                              XBA
                              LSR
                              AND       #$0380
                              STA       Text_Offset
                              TYA
                              AND       #$0018
                              PHA
                              ORA       Text_Offset
                              STA       Text_Offset
                              PLA
                              ASL
                              ASL
                              ORA       Text_Offset
                              STA       Text_Offset
                              RTS

Text_Char_to_Screen           PHA
                              SEP       #$20
                              NOP
                              CMP       #$60
                              BCS       :normal_char
                              CMP       #$40
                              BCS       :mousetext
:normal_char                  PHA
                              AND       #$80
                              STA       Char_MSB_Flag                 ; store hi-bit (normal/inverse flag)
                              PLA
                              EOR       #$60
                              SEC
                              SBC       #$20
                              AND       #$7F
                              ORA       Char_MSB_Flag
:mousetext                    PHA
                              LDA       80_Column
                              BPL       :set_main_mem
                              LDA       HPOS                          ; even/odd check for aux/main mapping
                              LSR
                              BCS       :set_main_mem
:set_aux_mem                  STAL      TXTPAGE2
                              BRA       :store_to_screen
:set_main_mem                 STAL      TXTPAGE1
:store_to_screen              PLA
                              LDX       Text_Offset
                              AND       Text_Mask
                              STAL      $E00400,X                     ; text memory
                              STAL      TXTPAGE1
                              REP       #$20
                              NOP
                              INC       HPOS
                              LDA       80_Column-1                   ; -1 offset to get flag in high byte of acc
                              BPL       :next_text_address
                              LDA       $2C
                              LSR
                              BCS       :next_text_same_offset        ; no inc needed when swapping page 1/2
:next_text_address            INC       Text_Offset
:next_text_same_offset        PLA
                              RTS

Text_Repeat_Char_Horiz        JSR       Text_Char_to_Screen
                              DEY
                              BNE       Text_Repeat_Char_Horiz
                              RTS

Text_Repeat_Char_Vertical     JSR       Text_Char_to_Screen
                              PHY
                              PHA
                              LDY       VPOS
                              LDX       HPOS
                              INY
                              DEX
                              JSR       Text_Offset_For_X_Y
                              PLA
                              PLY
                              DEY
                              BNE       Text_Repeat_Char_Vertical
                              RTS


Text_Out_Stack_Pascal_String  LDA       $01,S
                              INC
                              TAX
                              JSR       Text_Out_Pascal_String
                              TXA
                              STA       $01,S
                              RTS

Text_Out_Pascal_String        LDA       |$0000,X                      ; get string len
                              AND       #$00FF                        ; max len of 255
                              STA       Pascal_String_Length
:loop                         INX
                              LDA       |$0000,X
                              PHX
                              JSR       Text_Char_to_Screen
                              PLX
                              DEC       Pascal_String_Length
                              BNE       :loop
                              RTS

Text_Out_Word_As_Hex          XBA
                              JSR       Text_Out_Byte_As_Hex
                              XBA
Text_Out_Byte_As_Hex          PHA
                              LSR
                              LSR
                              LSR
                              LSR
                              JSR       Text_Out_Nibble_As_Hex
                              PLA
Text_Out_Nibble_As_Hex        PHA
                              AND       #$000F
                              CLC
                              ADC       #$00B0
                              CMP       #$00BA
                              BCC       Text_Out_Nibble_Num
                              ADC       #$0006
Text_Out_Nibble_Num           JSR       Text_Char_to_Screen
                              PLA
                              RTS

Text_Clear_Window_from_3      JSR       Text_Normal
                              LDY       #$0003
                              BRA       Text_Clear_Window_from_Y
Text_Clear_Window_from_5                                              ; not used?
                              JSR       Text_Normal
                              LDY       #$0005
Text_Clear_Window_from_Y      LDX       #$0001
                              JSR       Text_Offset_For_X_Y
                              LDA       #$00A0
                              LDY       #$0026
                              JSR       Text_Repeat_Char_Horiz
                              LDY       VPOS
                              INY
                              CPY       #$0017
                              BCC       Text_Clear_Window_from_Y
                              RTS

;
; FPGA routines
;
                              MX        %11
FPGA_Read_Config_Frame        LDAL      TWGS_Serial_Data
                              LDX       #$00
:read_config_byte             LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              ROR       $40
                              LDAL      TWGS_Serial_Data
                              ASL
                              LDA       $40
                              ROR
                              EOR       #$FF
                              STAL      $000100,X
                              INX
                              CPX       #FPGA_Max_Frame_Bytes         ; <-  I believe this reference is correct.. value matches.
                              BCC       :read_config_byte
                              RTS

FPGA_Init_Readback            PHB                                     ; save data bank
                              PHK                                     ; push current code bank
                              PLB                                     ; data bank is now using the bank address as the code bank
                              JSR       GS_1MHZ
                              PHA                                     ; save original speed
                              LDA       #$01                          ; config for FPGA read
                              STAL      TWGS_Serial_Control           ; It must be used as the rising edge to trigger readback "M0/RTRIG" of FPGA
                              LDAL      TWGS_Serial_Data              ; read back dummy data from FPGA
                              LDAL      TWGS_Serial_Data              ; read back dummy data from FPGA
                              LDAL      TWGS_Serial_Data              ; read back dummy data from FPGA
                              JSR       FPGA_Read_Config_Frame        ; get first frame of FPGA config
                              SEC                                     ; init readback good
                              LDAL      $000108                       ; get last byte of frame and check stop bit (bit7)
                              BMI       :exit                         ; branch if bit7 set, frame is good
                              CLC                                     ; stop bit incorrect, init readback failed
:exit                         PLA                                     ; get original speed
                              JSR       GS_Speed_Restore
                              PLB                                     ; restore data bank
                              RTS

FPGA_Check_Readback           PHB
                              PHK
                              PLB
                              JSR       GS_1MHZ
                              PHA
                              REP       #$30
                              NOP
                              JSR       FPGA_Setup_Ptrs
                              LDA       #$0029
                              JSR       FPGA_Skip_Bits
                              LDA       #FPGA_Max_Frames
                              STA       FPGA_Frame_Count
:read_next                    JSR       FPGA_Read_Data_Frame
                              SEP       #$30
                              NOP
                              LDX       #$00
:frame_byte                   TXY
                              LDAL      $000100,X
                              EORL      $000109,X
                              AND       ($3C),Y
                              BEQ       :frame_byte_ok
                              REP       #$30
                              NOP
                              LDA       #$0001
                              JMP       TWGS_Failed

                              MX        %11
:frame_byte_ok                INX
                              CPX       #FPGA_Max_Frame_Bytes
                              BCC       :frame_byte
                              JSR       FPGA_Read_Config_Frame
                              REP       #$30
                              NOP
                              LDA       $3C
                              CLC
                              ADC       #FPGA_Max_Frame_Bytes
                              STA       FPGA_Map_Mask_Ptr
                              DEC       FPGA_Frame_Count
                              BNE       :read_next
                              SEP       #$30
                              NOP
                              PLA
                              JSR       GS_Speed_Restore
                              PLB
                              RTS

                              mx        %00
FPGA_Setup_Ptrs               LDA       #FPGA_Config                  ; FPGA config data is at start of eprom
                              STA       FPGA_Data_Ptr
                              STZ       FPGA_Bit_Offset
                              LDA       #FPGA_Mask
                              STA       FPGA_Map_Mask_Ptr
                              RTS


FPGA_Read_Data_Frame          LDX       #$0000
:next                         LDA       (FPGA_Data_Ptr)
                              LDY       FPGA_Bit_Offset
                              BEQ       :done
:shift                        LSR                                     ; shift right until data byte is in LSB
                              DEY
                              BNE       :shift
:done                         INC       $38
                              STAL      $000109,X
                              INX
                              CPX       #FPGA_Max_Frame_Bytes
                              BCC       :next
                              LDA       #$0003
                              JSR       FPGA_Skip_Bits
                              RTS

FPGA_Skip_Bits                CLC
                              ADC       FPGA_Bit_Offset
                              CMP       #8Bits
                              BCC       :done
:skip_more                    INC       $38
                              SBC       #8Bits
                              CMP       #8Bits
                              BCS       :skip_more
:done                         STA       FPGA_Bit_Offset
                              RTS

Read_TWGS_Mode                PHP
                              SEP       #$20
                              NOP
                              PHA
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              STA       $02,S
                              PLA
                              JSR       GS_Speed_Restore
                              PLA
                              PLP
                              RTS

Set_TWGS_Mode_Keep_Cache      PHP
                              SEP       #$20
                              NOP
                              AND       #$FD
                              PHA
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              AND       #$02
                              ORA       $02,S
                              STAL      TWGS_Control
                              PLA
                              JSR       GS_Speed_Restore
                              PLA
                              PLP
                              RTS

IRQ_Logic_OFF                 PHP
                              SEP       #$20
                              NOP
                              JSR       Read_TWGS_Mode
                              ORA       #TWGS_IRQ
                              JSR       Set_TWGS_Mode_Keep_Cache
                              PLP
                              RTS

IRQ_Logic_ON                  PHP
                              SEP       #$20
                              NOP
                              JSR       Read_TWGS_Mode
                              AND       #$F7
                              JSR       Set_TWGS_Mode_Keep_Cache
                              PLP
                              RTS

Cache_ON                      PHP
                              SEP       #$20
                              NOP
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              ORA       #TWGS_Cache
                              STAL      TWGS_Control
                              PLA
                              JSR       GS_Speed_Restore
                              PLP
                              RTS

Cache_OFF                     PHP
                              SEP       #$20
                              NOP
                              JSR       GS_1MHZ
                              PHA
                              LDAL      TWGS_Control
                              AND       #$FD
                              STAL      TWGS_Control
                              PLA
                              JSR       GS_Speed_Restore
                              PLP
                              RTS

Time_Active_Screen            JSR       Read_TWGS_Mode
                              PHA
                              PHP
                              PHB
                              SEI
                              JSR       IRQ_Logic_OFF
                              JSR       Time_Inactive_VBL
                              PLB
                              PLP
                              PLA
                              JSR       Set_TWGS_Mode_Keep_Cache
                              RTS

Time_Inactive_VBL             SEP       #$20
                              NOP
                              LDA       #$E1
                              PHA
                              PLB
                              LDY       #$0200
:start                        LDA       RDVBLBAR
                              BPL       :start
:end                          LDA       RDVBLBAR
                              BMI       :end
                              TYX
:delay                        DEX
                              BNE       :delay
:start2                       NOP
                              INX
                              LDA       RDVBLBAR
                              BPL       :start2
                              REP       #$20
                              NOP
                              TXA
                              ASL
                              PHA
                              TYA
                              CLC
                              ADC       $01,S
                              TAY
                              PLA
                              SEP       #$20
                              NOP
                              CPX       #$0002
                              BCS       :start
                              TYX
                              RTS

;
;
; using VBL, active screen time is 192 scan lines, see IIgs technote #40
; using 61HZ screen refresh and 262.5 lines per screen refresh
; active time is 1/60 / 262.5 * 192 = ~0.01219 or ~12.19ms
; or for 50HZ and 312.5 lines ~12.29ms
;
; value in X is 5 cycle delay loop count
; $899 = 2201, so the total number of cycles delayed is 2201 * 5 = 11005
;
; frequency (Hz) is total delayed cycles / active time (seconds)
; $899 = 0.9 MHZ
; $A82 = 1.1 MHz
;


Time_Active_Screen_Slow       JSR       Time_Active_Screen
                              CPX       #$0899
                              BCC       :failed
                              CPX       #$0A82
                              BCS       :failed
                              CLC
                              RTS

:failed                       SEC
                              RTS

Time_Active_Screen_Fast       JSR       Time_Active_Screen
                              CPX       #$17E2
                              BCC       :failed
                              CPX       #$19CB
                              BCS       :failed
                              CLC
                              RTS

:failed                       SEC
                              RTS

Time_Active_Screen_TWGS       JSR       Time_Active_Screen
                              CLC
                              RTS

_DELETEME1                    SEC                                     ; NOT USED
                              RTS                                     ; NOT USED

                              MX        %00
Time_Video_Counter            PHP
                              SEI
                              LDAL      INTMGRV
                              STA       $4A
                              LDAL      INTMGRV+2
                              STA       $4C
                              LDA       Test_IRQ_Vector
                              STAL      INTMGRV
                              LDA       Test_IRQ_Vector+2
                              STAL      INTMGRV+2
                              PLP
:loop                         LDA       #$FFFF
                              STA       $48
                              SEP       #$20
                              NOP
                              PHB
                              LDA       #$E0
                              PHA
                              PLB
                              LDX       #:end-:code                   ; length of code to pre cache
:pre_cache                    LDAL      :code-1,X
                              DEX
                              BNE       :pre_cache
:code                         LDX       #$0016                        ; fixed cycle loop count = 22

                              LDA       VERTCNT
:wait                         CMP       VERTCNT
                              BEQ       :wait
                              LDA       VERTCNT
:wait2                        CMP       VERTCNT
                              BEQ       :wait2
:delay                        DEX
                              BNE       :delay
                              LDA       HORIZCNT
:end                          REP       #$20
                              NOP
                              AND       #$00FF
                              TAX
                              PLB
                              LDA       $48
                              AND       #$00FF
                              BEQ       :loop
                              PHP
                              SEI
                              LDA       $4A
                              STAL      INTMGRV
                              LDA       $4C
                              STAL      INTMGRV+2
                              PLP
                              RTS

Test_IRQ_Vector               JMPL      TEMP_INTERRUPT_MGR

TEMP_INTERRUPT_MGR            PHP
                              PHB
                              PEA       $0000
                              PLB
                              PLB
                              STZ       |$0048
                              PLB
                              PLP
                              JMPL      $00004A

Time_Video_Counter_Slow       PHX
                              JSR       Time_Video_Counter
                              CPX       #$00F0
                              BCC       :fail
                              CPX       #$00F9
                              BCS       :fail
                              PLX
                              CLC
                              RTS

:fail                         PLX
                              SEC
                              RTS

Time_Video_Counter_Fast       PHX
                              JSR       Time_Video_Counter
                              CPX       #$006D
                              BCC       :fail
                              CPX       #$0073
                              BCS       :fail
                              PLX
                              CLC
                              RTS

:fail                         PLX
                              SEC
                              RTS

Time_Video_Counter_TWGS       PHX
                              JSR       Time_Video_Counter
                              PLX
                              CLC
                              RTS

_DELETEME2                    PLX                                     ; NOT USED
                              SEC                                     ; NOT USED
                              RTS                                     ; NOT USED

Test_CPU                      JSR       GS_FAST
                              JSR       TWGS_ON
                              LDA       $4E
                              BEQ       :long_test
                              LDX       #$0001
                              BRA       :test_loop
:long_test                    LDX       #$7530
:test_loop                    PHX
                              SEC
                              SEP       #$30
                              LDY       #$00
                              CLC
                              BCS       :fail_8bit
                              CLC
                              REP       #$30
                              LDY       #$3818
                              BCS       :fail_16bit
                              CPY       #$3818
                              BNE       :fail_16bit
                              PLX
                              DEX
                              BNE       :test_loop
                              LDA       #$0002
                              LDY       #$0000
                              RTS

:fail_8bit                    REP       #$30
                              NOP
:fail_16bit                   PLX
                              LDY       #$0001
                              LDA       #$0003
                              RTS

Test_NVRAM                    JSR       GS_1MHZ
                              JSR       TWGS_OFF
                              SEP       #$30
                              NOP
                              NOP
                              LDA       #NVRAM_CMD_Enable_Write
                              JSR       NVRAM_Send_Cmd
                              REP       #$30
                              NOP
                              NOP
                              LDA       #$0000
                              JSR       Test_NVRAM_FILL_16bit
                              LDX       #$0000
                              LDA       #$FFFF
                              JSR       Test_NVRAM_Compare_Update
                              LDY       #$0001
                              BCS       :failed
                              LDX       #$FFFF
                              LDA       #$0000
                              JSR       Test_NVRAM_Compare_Update
                              LDY       #$0002
                              BCS       :failed
                              LDA       $4E
                              BNE       :ok
                              LDX       #$0000
                              LDA       #$0001
:walk_1                       JSR       Test_NVRAM_Compare_Update
                              LDY       #$0003
                              BCS       :failed
                              TAX
                              ASL
                              BCC       :walk_1
                              LDA       #$FFFE
:walk_0                       JSR       Test_NVRAM_Compare_Update
                              LDY       #$0004
                              BCS       :failed
                              TAX
                              SEC
                              ROL
                              BCS       :walk_0
                              JSR       Test_NVRAM_Compare_Update
                              LDY       #$0004
                              BCS       :failed
:ok                           LDA       #$0002
                              LDY       #$0000
                              BRA       :exit
:failed                       LDA       #$0003
:exit                         PHA
                              SEP       #$30
                              NOP
                              NOP
                              LDA       #NVRAM_CMD_Disable_Write
                              JSR       NVRAM_Send_Cmd
                              REP       #$30
                              NOP
                              NOP
                              PLA
                              RTS

Test_NVRAM_FILL_16bit         STA       $40
                              SEP       #$30
                              NOP
                              NOP
                              LDX       #$00
:loop                         LDY       $40
                              LDA       $41
                              JSR       NVRAM_Write_Word
                              INX
                              CPX       #$10
                              BCC       :loop
                              REP       #$30
                              NOP
                              LDA       $40
                              RTS

Test_NVRAM_Compare_Update     STA       $40
                              STX       $42
                              SEP       #$30
                              NOP
                              NOP
                              LDX       #$00
:loop                         JSR       NVRAM_Read_Word
                              CPY       $42
                              SEC
                              BNE       :exit
                              CMP       $43
                              SEC
                              BNE       :exit
                              LDY       $40
                              LDA       $41
                              JSR       NVRAM_Write_Word
                              INX
                              CPX       #$10
                              BCC       :loop
                              CLC
:exit                         REP       #$30
                              NOP
                              LDA       $40
                              LDX       $42
                              RTS

Test_Speed_Control            LDA       $4E
                              BNE       :quick_test
                              JSR       TWGS_OFF
                              JSR       GS_1MHZ
                              JSR       IRQ_Logic_OFF
                              JSR       Time_Active_Screen_Slow
                              LDY       #$0001
                              BCS       :failed
                              JSR       GS_FAST
                              JSR       GS_1MHZ
                              JSR       GS_FAST
                              JSR       Time_Active_Screen_Fast
                              LDY       #$0002
                              BCS       :failed
                              JSR       TWGS_ON
                              JSR       TWGS_OFF
                              JSR       TWGS_ON
                              JSR       Time_Active_Screen_TWGS
                              LDY       #$0003
                              BCS       :failed
                              JSR       GS_1MHZ
                              JSR       GS_FAST
                              JSR       GS_1MHZ
                              JSR       Time_Active_Screen_Slow
                              LDY       #$0004
                              BCC       :ok
:failed                       BRA       :failed_exit
:quick_test                   JSR       TWGS_OFF
                              JSR       GS_1MHZ
                              JSR       IRQ_Logic_OFF
                              JSR       Cache_ON
                              JSR       Time_Video_Counter_Slow
                              LDY       #$0001
                              BCS       :failed_exit
                              JSR       GS_FAST
                              JSR       GS_1MHZ
                              JSR       GS_FAST
                              JSR       Time_Video_Counter_Fast
                              LDY       #$0002
                              BCS       :failed_exit
                              JSR       TWGS_ON
                              JSR       TWGS_OFF
                              JSR       TWGS_ON
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0003
                              BCS       :failed_exit
                              JSR       GS_1MHZ
                              JSR       GS_FAST
                              JSR       GS_1MHZ
                              JSR       Time_Video_Counter_Slow
                              LDY       #$0004
                              BCS       :failed_exit
:ok                           LDA       #$0002
                              LDY       #$0000
                              RTS

:failed_exit                  LDA       #$0003
                              RTS

Test_IRQ_Logic                JSR       GS_FAST
                              JSR       TWGS_ON
                              JSR       IRQ_Logic_OFF
                              JSR       Cache_ON
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0001
                              BCS       :fail2
                              JSR       IRQ_Logic_ON
                              LDA       $4E                           ; quick test flag
                              BEQ       :long_test
                              LDX       #$0001
                              BRA       :loop
:long_test                    LDX       #$001E
:loop                         CLI
                              PHP
                              SEI
                              PHP
                              CLI
                              PLP
                              JSR       Time_Video_Counter_Fast
                              LDY       #$0002
                              BCS       :fail1
                              PLP
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0003
                              BCS       :fail2
                              SEP       #$04
                              NOP
                              JSR       Time_Video_Counter_Fast
                              LDY       #$0004
                              BCS       :fail2
                              REP       #$04
                              NOP
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0005
                              BCS       :fail2
                              SEI
                              JSR       Time_Video_Counter_Fast
                              LDY       #$0006
                              BCS       :fail2
                              CLI
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0007
                              BCS       :fail2
                              DEX
                              BNE       :loop
                              LDA       #$0002
                              LDY       #$0000
                              BRA       :exit
:fail1                        PLP
:fail2                        LDA       #$0003
:exit                         PHA
                              JSR       IRQ_Logic_OFF
                              PLA
                              RTS

Test_Slot_Slowdown            JSR       GS_FAST
                              JSR       TWGS_ON
                              JSR       IRQ_Logic_OFF
                              JSR       Cache_ON
                              SEP       #$20
                              NOP
                              LDAL      SLTROMSEL
                              PHA
                              AND       #$4F
                              STAL      SLTROMSEL
                              LDAL      CYAREG
                              PHA
                              ORA       #$0B
                              AND       #$FB
                              STAL      CYAREG
                              REP       #$20
                              NOP
                              JSR       Time_Video_Counter_Slow
                              BCS       :slowdown1
                              BRL       :skip
:slowdown1                    JSR       Time_Video_Counter_TWGS
                              LDY       #$0001
                              BCC       :continue
                              BRL       :failed
:continue                     LDA       $4E
                              BEQ       :long_test
                              LDX       #$0001
                              BRA       :loop
:long_test                    LDX       #$0064
:loop                         SEP       #$20
                              NOP
                              LDAL      MOTOR4ON
                              REP       #$20
                              NOP
                              JSR       Time_Video_Counter_Slow
                              SEP       #$20
                              NOP
                              LDAL      MOTOR4OFF
                              REP       #$20
                              NOP
                              LDY       #$0002
                              BCS       :failed
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0003
                              BCS       :failed
                              SEP       #$20
                              NOP
                              LDAL      MOTOR5ON
                              REP       #$20
                              NOP
                              JSR       Time_Video_Counter_Slow
                              SEP       #$20
                              NOP
                              LDAL      MOTOR5OFF
                              REP       #$20
                              NOP
                              LDY       #$0004
                              BCS       :failed
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0005
                              BCS       :failed
                              SEP       #$20
                              NOP
                              LDAL      MOTOR7ON
                              REP       #$20
                              NOP
                              JSR       Time_Video_Counter_Slow
                              SEP       #$20
                              NOP
                              LDAL      MOTOR7OFF
                              REP       #$20
                              NOP
                              LDY       #$0006
                              BCS       :failed
                              JSR       Time_Video_Counter_TWGS
                              LDY       #$0007
                              BCS       :failed
                              DEX
                              BNE       :loop
                              LDA       #$0002
                              LDY       #$0000
                              BRA       :exit
:skip                         LDA       #$0004
                              LDY       #$0000
                              BRA       :exit
:failed                       LDA       #$0003
:exit                         TAX
                              SEP       #$20
                              NOP
                              PLA
                              STAL      CYAREG
                              PLA
                              STAL      SLTROMSEL
                              REP       #$20
                              NOP
                              TXA
                              RTS

Test_Cache_RAM                PHP
                              SEI
                              JSR       GS_FAST
                              JSR       TWGS_ON
                              JSR       IRQ_Logic_OFF
                              JSR       Check_Cache_Size
                              STA       Cache_Size
                              DEC
                              STA       Cache_Max_Mask
                              LDA       #Test_Cache_RAM
                              AND       Cache_Max_Mask
                              STA       $40                           ; save in workspace?
                              CMP       #$0201
                              BCC       :range_error
                              LDA       #Test_Cache_Flush+1
                              AND       Cache_Max_Mask
                              STA       $42                           ; save in workspace2?
                              CMP       $40
                              BCC       :range_error
                              LDA       #$0000
                              JSR       Test_Cache_RAM_Fill
                              TAY
                              LDA       #$FFFF
                              JSR       Test_Cache_RAM_CompareUpdate
                              LDY       #$0001
                              BCS       :failed
                              TAY
                              LDA       #$0000
                              JSR       Test_Cache_RAM_CompareUpdate
                              LDY       #$0002
                              BCS       :failed
                              LDA       $4E
                              BNE       :ok
                              TAY
                              LDA       #$0001
:walk_1                       JSR       Test_Cache_RAM_CompareUpdate
                              LDY       #$0003
                              BCS       :failed
                              TAY
                              ASL
                              BCC       :walk_1
                              LDA       #$FFFE
:walk_0                       JSR       Test_Cache_RAM_CompareUpdate
                              LDY       #$0004
                              BCS       :failed
                              TAY
                              SEC
                              ROL
                              BCS       :walk_0
                              LDA       #$0000
                              JSR       Test_Cache_RAM_CompareUpdate
                              LDY       #$0004
                              BCS       :failed
:ok                           LDA       #$0002
                              LDY       #$0000
                              PLP
                              RTS

:range_error                  LDY       #$0005
:failed                       LDA       #$0003
                              PLP
                              RTS

Test_Cache_RAM_Fill           SEP       #$20
                              NOP
                              LDX       #$0200
:fill_loop                    STAL      $BF0000,X
                              INX
                              CPX       $40
                              BCC       :fill_loop
                              LDX       $42
:fill_loop2                   STAL      $BF0000,X
                              INX
                              CPX       Cache_Size
                              BCC       :fill_loop2
                              REP       #$20
                              NOP
                              RTS

Test_Cache_RAM_CompareUpdate  STA       $44
                              SEP       #$20
                              NOP
                              LDX       #$0200
:loop                         TYA
                              CMPL      $BF0000,X
                              BNE       :error
                              LDA       $44
                              STAL      $BF0000,X
                              INX
                              CPX       $40
                              BCC       :loop
                              LDX       $42
:loop2                        TYA
                              CMPL      $BF0000,X
                              BNE       :error
                              LDA       $44
                              STAL      $BF0000,X
                              INX
                              CPX       Cache_Size
                              BCC       :loop2
                              CLC
                              BRA       :exit
:error                        SEC
:exit                         REP       #$20
                              NOP
                              LDA       $44
                              RTS

Test_Cache_Flush              PHP
                              SEI
                              JSR       GS_FAST
                              JSR       TWGS_ON
                              JSR       IRQ_Logic_OFF
                              JSR       L92B8
                              LDA       #Test_Cache_Flush
                              AND       Cache_Max_Mask
                              STA       $40
                              CMP       #$0201
                              BCC       :range_error
                              LDA       #Test_Shadow_Emulation+1
                              AND       Cache_Max_Mask
                              STA       $42
                              CMP       $40
                              BCS       :begin_test
:range_error                  LDY       #$0007
                              LDA       #$0003
                              PLP
                              RTS

:begin_test                   LDA       #$AAAA
                              JSR       L923A
                              LDA       #$AAAA
                              JSR       L9258
                              LDY       #$0001
                              BCS       L91EF
                              JSR       Test_Cache_Rom
                              LDA       #$AAAA
                              JSR       L9280
                              LDY       #$0002
                              BCS       L91EF
                              LDA       #$5555
                              JSR       L923A
                              LDA       #$5555
                              JSR       L9258
                              LDY       #$0003
L91EF                         BCS       L9235
                              JSR       Test_Cache_Rom
                              LDA       #$5555
                              JSR       L9280
                              LDY       #$0004
                              BCS       L9235
                              JSR       L92D9
                              LDA       #$AAAA
                              JSR       L923A
                              JSR       L92B8
                              LDA       #$AAAA
                              JSR       L9280
                              LDY       #$0005
                              BCS       L9235
                              LDA       #$5555
                              JSR       L923A
                              JSR       L92D9
                              LDA       #$5555
                              JSR       L9280
                              JSR       L92B8
                              LDY       #$0006
                              BCS       L9235
                              LDA       #$0002
                              LDY       #$0000
                              PLP
                              RTS

L9235                         LDA       #$0003
                              PLP
                              RTS

L923A                         SEP       #$20
                              NOP
                              LDX       #$0200
:store_loop1                  STAL      $BE0000,X
                              INX
                              CPX       $40
                              BCC       :store_loop1
L9249                         LDX       $42
:store_loop2                  STAL      $BE0000,X
                              INX
                              CPX       Cache_Size
                              BCC       :store_loop2
                              REP       #$20
                              NOP
                              RTS

L9258                         SEP       #$20
                              NOP
                              LDX       #$0200
:loop                         CMPL      $BE0000,X
                              BNE       :done
                              INX
                              CPX       $40
                              BCC       :loop
                              LDX       $42
:loop2                        CMPL      $BE0000,X
                              BNE       :done
                              INX
                              CPX       Cache_Size
                              BCC       :loop2
                              REP       #$20
                              NOP
                              CLC
                              RTS

:done                         REP       #$20
                              NOP
                              SEC
                              RTS

L9280                         SEP       #$20
                              NOP
                              LDX       #$0200
L9286                         CMPL      $BE0000,X
                              BEQ       L92A3
                              INX
                              CPX       $40
                              BCC       L9286
                              LDX       $42
L9293                         CMPL      $BE0000,X
                              BEQ       L92A3
                              INX
                              CPX       Cache_Size
                              BCC       L9293
                              REP       #$20
                              NOP
                              CLC
                              RTS

L92A3                         REP       #$20
                              NOP
                              SEC
                              RTS

Test_Cache_Rom                PHB
                              LDX       Cache_Size
                              LDX       #$8000
                              LDY       #$8000
                              LDA       Cache_Max_Mask
                              MVN       TWGS_Control,TWGS_Control     ; $BC0000,$BC0000
                              PLB
                              RTS

L92B8                         SEP       #$20
                              NOP
                              LDAL      CYAREG
                              PHA
                              AND       #$7F
                              STAL      CYAREG
                              LDAL      TWGS_Control
                              ORA       #$02
                              STAL      TWGS_Control
                              PLA
                              STAL      CYAREG
                              REP       #$20
                              NOP
                              RTS

L92D9                         SEP       #$20
                              NOP
                              LDAL      CYAREG
                              PHA
                              AND       #$7F
                              STAL      CYAREG
                              LDAL      TWGS_Control
                              AND       #$FD
                              STAL      TWGS_Control
                              PLA
                              STAL      CYAREG
                              REP       #$20
                              NOP
                              RTS

Test_Shadow_Emulation         LDA       $4E
                              BEQ       L9301
                              BRL       L941B
L9301                         PEA       $0000
                              PEA       $0000
                              PEA       $0000
                              PEA       $0400
                              PEA       $5000
                              PEA       $8018
L9313                         PEA       $0000
                              PEA       $0000
                              _NewHandle
                              BCS       L934E
L9322                         PEA       $0000
L9325                         PEA       $0000
                              PEA       $0000
                              PEA       $0400
L932E                         PEA       $5000
                              PEA       $8018
                              PEA       $0000
                              PEA       $0000
                              _NewHandle
L9341                         BCC       L9357
                              PLA
                              PLA
                              _DisposeHandle
                              BRA       L9350
L934E                         PLA
                              PLA
L9350                         LDA       #$0004
                              LDY       #$0000
                              RTS

L9357                         PHP
                              SEI
                              JSR       IRQ_Logic_OFF
                              JSR       GS_FAST
                              JSR       TWGS_ON
                              SEP       #$20
                              NOP
                              LDAL      $E0C01D
                              PHA
                              LDAL      $E0C018
                              PHA
                              STAL      TXTPAGE1
                              STAL      $E0C000
                              REP       #$20
                              NOP
                              PEA       $00E0
                              PEA       $0800
                              LDA       $08,S
                              PHA
                              LDA       $08,S
                              PHA
                              PEA       $0000
                              PEA       $0400
                              _PtrToHand
                              PEA       $00E1
                              PEA       $0800
                              LDA       $04,S
                              PHA
                              LDA       $04,S
                              PHA
                              PEA       $0000
                              PEA       $0400
                              _PtrToHand
                              PHB
                              LDX       #$0400
                              LDY       #$0800
                              LDA       #$03FF
                              MVN       $E00000,$E00000
                              LDX       #$0400
                              LDY       #$0800
                              LDA       #$03FF
                              MVN       $E10000,$E10000
                              PLB
                              LDAL      $012000
                              PHA
                              LDAL      $002000
                              PHA
                              LDAL      $E12000
                              PHA
                              LDAL      $E02000
                              PHA
L93DA                         LDAL      $010478
                              PHA
                              LDAL      $000478
                              PHA
                              LDAL      $E10478
                              PHA
                              LDAL      $E00478
                              PHA
                              LDAL      $001FFE
                              PHA
                              LDAL      $004000
                              PHA
                              LDAL      $E01FFE
                              PHA
                              LDAL      $E04000
                              PHA
                              LDAL      $0003FE
                              PHA
                              LDAL      $000878
                              PHA
                              LDAL      $E003FE
                              PHA
                              LDAL      $E00878
                              PHA
                              LDX       #$012C
                              BRA       L941E
L941B                         LDX       #$0001
L941E                         PHX
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE1
                              STAL      $E0C000
L942A                         STAL      $E0C056
                              REP       #$20
                              NOP
                              JSR       L95CA
                              BCS       L949B
                              JSR       L95DF
                              BCS       L949B
                              JSR       L957C
                              BCS       L949B
                              SEP       #$20
                              NOP
                              STAL      $E0C001
                              REP       #$20
                              NOP
                              JSR       L95CA
                              BCC       L949B
                              JSR       L95DF
                              BCS       L949B
                              JSR       L957C
                              BCS       L949B
                              SEP       #$20
                              NOP
                              STAL      $E0C057
                              REP       #$20
                              NOP
                              JSR       L95CA
                              BCC       L949B
                              JSR       L95DF
                              BCC       L949B
                              JSR       L957C
                              BCS       L949B
                              SEP       #$20
                              NOP
                              STAL      $E0C000
                              STAL      $E0C056
                              REP       #$20
                              NOP
                              JSR       L95CA
                              BCS       L949B
                              JSR       L95DF
                              BCS       L949B
                              JSR       L957C
                              BCS       L949B
                              PLX
                              DEX
                              BNE       L941E
                              LDA       #$0002
                              LDY       #$0000
                              BRA       L949F
L949B                         PLX
                              LDA       #$0003
L949F                         TAX
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE1
                              STAL      $E0C000
                              REP       #$20
                              NOP
                              LDA       $4E
                              BEQ       L94B5
                              BRL       L9505
L94B5                         PLA
                              STAL      $E00878
                              PLA
                              STAL      $E003FE
                              PLA
                              STAL      $000C78
                              PLA
                              STAL      $0003FE
                              PLA
                              STAL      $E04000
                              PLA
                              STAL      $E01FFE
                              PLA
                              STAL      $004000
                              PLA
                              STAL      $001FFE
                              PLA
                              STAL      $E00478
                              PLA
                              STAL      $E10478
                              PLA
                              STAL      $000478
                              PLA
                              STAL      $010478
                              PLA
                              STAL      $E02000
                              PLA
                              STAL      $E12000
                              PLA
                              STAL      $002000
L9500                         PLA
                              STAL      $012000
L9505                         PHX
L9506                         PHY
                              LDA       $4E
                              BEQ       L950E
                              BRL       L9579
L950E                         LDA       $0A,S
                              PHA
                              LDA       $0A,S
                              PHA
                              PEA       $00E1
                              PEA       $0800
                              PEA       $0000
                              PEA       $0400
                              _HandToPtr
                              LDA       $0E,S
                              PHA
                              LDA       $0E,S
                              PHA
                              PEA       $00E0
                              PEA       $0800
                              PEA       $0000
                              PEA       $0400
                              _HandToPtr
L9540                         PLY
                              PLX
                              SEP       #$20
                              NOP
                              STAL      $E0C000
                              STAL      $E0C056
                              PLA
                              BPL       L9554
                              STAL      $E0C001
L9554                         PLA
                              BPL       L955B
                              STAL      $E0C057
L955B                         REP       #$20
                              NOP
                              PLP
                              LDA       $07,S
                              PHA
                              LDA       $07,S
                              PHA
                              TXA
                              STA       $0B,S
                              TYA
                              STA       $09,S
                              _DisposeHandle
                              _DisposeHandle
L9579                         PLY
                              PLA
                              RTS

L957C                         LDY       #$0000
L957F                         LDA       L959A,Y
                              TAX
                              LDA       L95AA,Y
                              JSR       L95F4
                              BCS       L9594
                              INY
                              INY
                              CPY       #$0010
                              BCC       L957F
                              CLC
                              RTS

L9594                         LDA       L95BA,Y
                              TAY
                              SEC
                              RTS

L959A                         DW        $02FE
                              DW        $02FE
                              DW        $0778
                              DW        $0778
                              DW        $1EFE
                              DW        $1EFE
                              DW        $3F00
                              DW        $3F00
L95AA                         DW        $0000
                              DW        $00E0
                              DW        $0000
                              DW        $00E0
                              DW        $0000
                              DW        $00E0
                              DW        $0000
                              DW        $00E0
L95BA                         DW        $0003
                              DW        $0003
                              DW        $0003
                              DW        $0003
                              DW        $0004
                              DW        $0004
                              DW        $0004
                              DW        $0004

L95CA                         LDA       #$0000
                              JSR       L95D5
                              BCC       L95DE
                              LDA       #$00E0
L95D5                         LDX       #$0378
                              JSR       L95F4
                              LDY       #$0001
L95DE                         RTS

L95DF                         LDA       #$0000
                              JSR       L95EA
                              BCC       L95F3
                              LDA       #$00E0
L95EA                         LDX       #$1F00
                              JSR       L95F4
                              LDY       #$0002
L95F3                         RTS

L95F4                         PHB
                              XBA
                              PHA
                              PLB
                              PLB
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE1
                              REP       #$20
                              NOP
                              LDA       #$AAAA
                              STA       $0100,X
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE2
                              REP       #$20
                              NOP
                              LDA       #$BBBB
                              STA       $0100,X
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE1
                              REP       #$20
                              NOP
                              LDA       #$AAAA
                              CMP       $0100,X
                              BNE       L9640
                              SEP       #$20
                              NOP
                              STAL      TXTPAGE2
                              REP       #$20
                              NOP
L9635                         LDA       #$BBBB
                              CMP       $0100,X
                              BNE       L9640
                              SEC
                              BRA       L9641
L9640                         CLC
L9641                         PLB
                              RTS

Test_Language_Card            PHP
                              SEI
                              JSR       IRQ_Logic_OFF
                              JSR       GS_FAST
                              JSR       TWGS_ON
                              SEP       #$20
                              NOP
                              LDAL      $E0C083
                              REP       #$20
                              NOP
                              LDAL      $D000
                              PHA
                              LDAL      $E000
                              PHA
                              SEP       #$20
                              NOP
                              LDAL      $E0C08B
                              REP       #$20
                              NOP
                              LDAL      $D000
                              PHA
                              LDA       $4E
                              BEQ       L967A
                              LDX       #$0001
                              BRA       L967D
L967A                         LDX       #$0BB8
L967D                         PHX
                              SEP       #$20
                              NOP
                              LDAL      $E0C083
                              LDAL      $E0C083
                              REP       #$20
                              NOP
                              LDA       #$AABB
                              STAL      $D000
                              LDA       #$CCDD
                              STAL      $E000
                              SEP       #$20
                              NOP
                              LDAL      $E0C08B
L96A1                         LDAL      $E0C08B
                              REP       #$20
                              NOP
                              LDA       #$EEFF
                              STAL      $D000
                              SEP       #$20
                              NOP
                              LDAL      $E0C083
                              REP       #$20
                              NOP
                              LDA       #$AABB
                              CMPL      $D000
                              BNE       L9717
                              LDAL      $E000
                              CMP       #$CCDD
                              BNE       L9717
                              SEP       #$20
                              NOP
                              LDAL      $E0C08B
                              REP       #$20
                              NOP
                              LDAL      $D000
                              CMP       #$EEFF
                              BNE       L9717
                              LDAL      $E000
                              CMP       #$CCDD
                              BNE       L9717
                              SEP       #$20
                              NOP
                              LDAL      $C082
                              REP       #$20
                              NOP
                              LDAL      $D000
                              CMP       #$AABB
L96F8                         BEQ       L9717
                              CMP       #$EEFF
                              BEQ       L9717
                              LDAL      $E000
                              CMP       #$CCDD
                              BEQ       L9717
                              PLX
                              DEX
                              BEQ       L970F
                              BRL       L967D
L970F                         LDA       #$0002
                              LDY       #$0000
                              BRA       L971E
L9717                         PLX
                              LDA       #$0003
                              LDY       #$0001
L971E                         TAX
                              SEP       #$20
                              NOP
                              LDAL      $E0C08B
                              LDAL      $E0C08B
                              REP       #$20
                              NOP
                              PLA
                              STAL      $D000
                              SEP       #$20
                              NOP
                              LDAL      $E0C083
                              LDAL      $E0C083
                              REP       #$20
                              NOP
                              PLA
                              STAL      $E000
                              PLA
                              STAL      $D000
L974A                         SEP       #$20
                              NOP
                              LDAL      $C082
                              REP       #$20
                              NOP
                              TXA
                              PLP
                              RTS

L9757                         REP       #$30
                              NOP
                              SEC
                              JSL       Run_Diagnostic_Tests
                              BCC       L9764
                              JMP       TWGS_Failed

L9764                         SEP       #$30
                              NOP
                              RTS

                              MX        %00
Run_Diagnostic_Tests          PHB
                              PHK
                              PLB
                              STZ       $4E
                              BCC       L9774
                              LDA       #$FFFF
                              STA       $4E
L9774                         LDX       #$0000
L9777                         PHX
                              JSR       (Test_Function_Table1,X)
                              CMP       #$0003
                              BEQ       L978B
                              PLX
                              INX
                              INX
                              CPX       #$0010
                              BCC       L9777
                              CLC
                              PLB
                              RTL

L978B                         PLA
                              LSR
                              INC
                              PHY
                              XBA
                              ORA       $01,S
                              PLY
                              SEC
                              PLB
                              RTL

Test_Function_Table1          DA        Test_CPU
                              DA        Test_NVRAM
                              DA        Test_Cache_RAM
                              DA        Test_Cache_Flush
                              DA        Test_Speed_Control
                              DA        Test_IRQ_Logic
                              DA        Test_Slot_Slowdown
                              DA        Test_Language_Card
                              DA        Test_Shadow_Emulation

TWGS_Failed                   PHP
                              PHB
                              PHK
                              PLB
                              REP       #$30
                              NOP
                              PHA
                              SEP       #$30
                              NOP
                              STAL      $E0C051
                              STAL      $E0C052
                              STAL      TXTPAGE1
                              STAL      $E0C056
                              STAL      $E0C000
                              STAL      $E0C00C
                              STAL      $E0C00F
                              LDA       #$01
                              STAL      $E0C029
                              REP       #$30
                              NOP
                              JSR       Text_Init
                              LDX       #$000A
                              LDY       #$0004
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "TransWarp GS failure"
                              LDX       #$000B
                              LDY       #$0005
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "(error code=     )"
                              LDX       #$0018
                              LDY       #$0005
                              JSR       Text_Offset_For_X_Y
                              PLA
                              JSR       Text_Out_Word_As_Hex
                              LDX       #$000A
                              LDY       #$0007
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Follow these steps:"
                              LDX       #$000C
                              LDY       #$0009
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "1) Turn off the GS"
                              LDX       #$000C
                              LDY       #$000A
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "2) Wait 20 seconds"
                              LDX       #$000C
                              LDY       #$000B
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "3) Turn on the GS"
                              LDX       #$0007
                              LDY       #$000D
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "If this screen re-appears,"
                              LDX       #$0008
                              LDY       #$000E
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "note the error code and"
                              LDX       #$0005
                              LDY       #$000F
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "contact technical support at:"
                              LDX       #$000D
                              LDY       #$0011
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "(214) 241-6069"
                              LDX       #$0002
                              LDY       #$0012
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "9am to 12:30pm & 1:35pm to 5pm (CST)"
                              LDX       #$0009
                              LDY       #$0013
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Monday Through Friday"
                              STP

*-----------
; FPGA_Mask
; Fgpa_ReadBack_MasK ($9988)
; 160 frames of 71 bits + 1 stop

FPGA_Mask
                              HEX       6C6FEF
                              HEX       5EDCDEBD3D04ECEFDF1FDCBFBF3F14EC
                              HEX       FFFF3FFDFFFF7F36FCFFEF5FFFDFFFBF
                              HEX       36ACBF6F7F7FDFFEFE16ACFFEFFFFFDF
                              HEX       FFFF17CDFFEF7FFFDFFFFF36CDFFEFFF
                              HEX       FDDFFFFF378F9F3F3F3D7F7E7E76BFBC
                              HEX       7C7979F9F2F27ABFBE6E7D7DDDFAFA7A
                              HEX       9F9E2E3D3D5D7A7A7A9F9E2E3D3D5D7A
                              HEX       7A7ADDDEAEBDBD5D7B7B5BFFFEEEFDFD
                              HEX       DDFBFB7BFFFFFFFFFFFFFFFF7BDFDFAF
                              HEX       BFBF5F7F7F7BDEDFAFBFBF5F7F7F3B0F
                              HEX       0F1F1E1E3E3C3C58BFBF6F7F7FDFFEFE
                              HEX       7ABFBF7F7F7FFFFEFE7A9D9F2F3F3F5F
                              HEX       7E7E5E9D9F2F3F3F5F7E7E5EDDDFAFBF
                              HEX       BF5F7F7F5FDFDFAFBFBF5F7F7F7FFFFF
                              HEX       EFFFFFDFFFFF7FFFFFFFFFFFFFFFFF7F
                              HEX       BFBC7C7979F9F2F27ABFBE6E7D7DDDFA
                              HEX       FA7A9F9E2E3D3D5D7A7A7A9F9E2E3D3D
                              HEX       5D7A7A7ADDDEAEBDBD5D7B7B5BFFFEEE
                              HEX       FDFDDDFBFB7BFFFFFFFFFFFFFFFF7BDF
                              HEX       DFAFBFBF5F7F7F7BDEDFAFBFBF5F7F7F
                              HEX       3B0F0F1F1E1E3E3C3C58BFBF6F7F7FDF
                              HEX       FEFE7ABFBF7F7F7FFFFEFE7A9D9F2F3F
                              HEX       3F5F7E7E5E9D9F2F3F3F5F7E7E5EDDDF
                              HEX       AFBFBF5F7F7F5FDFDFAFBFBF5F7F7F7F
                              HEX       FFFFEFFFFFDFFFFF7FFFFFFFFFFFFFFF
                              HEX       FF7F9190202121414202449388081111
                              HEX       11222260BFBC7C7979F9F2F27ABFBE6E
                              HEX       7D7DDDFAFA7A9F9E2E3D3D5D7A7A7A9F
                              HEX       9E2E3D3D5D7A7A7ADDDEAEBDBD5D7B7B
                              HEX       5BFFFEEEFDFDDDFBFB7BFFFFFFFFFFFF
                              HEX       FFFF7BDFDFAFBFBF5F7F7F7BDEDFAFBF
                              HEX       BF5F7F7F3B0F0F1F1E1E3E3C3C58BFBF
                              HEX       6F7F7FDFFEFE7ABFBF7F7F7FFFFEFE7A
                              HEX       9D9F2F3F3F5F7E7E5E9D9F2F3F3F5F7E
                              HEX       7E5EDDDFAFBFBF5F7F7F5FDFDFAFBFBF
                              HEX       5F7F7F7FFFFFEFFFFFDFFFFF7FFFFFFF
                              HEX       FFFFFFFFFF7FBFBC7C7979F9F2F27ABF
                              HEX       BE6E7D7DDDFAFA7A9F9E2E3D3D5D7A7A
                              HEX       7A9F9E2E3D3D5D7A7A7ADDDEAEBDBD5D
                              HEX       7B7B5BFFFEEEFDFDDDFBFB7BFFFFFFFF
                              HEX       FFFFFFFF7BDFDFAFBFBF5F7F7F7BDEDF
                              HEX       AFBFBF5F7F7F3B0F0F1F1E1E3E3C3C58
                              HEX       BFBF6F7F7FDFFEFE7ABFBF7F7F7FFFFE
                              HEX       FE7A9D9F2F3F3F5F7E7E5E9D9F2F3F3F
                              HEX       5F7E7E5EDDDFAFBFBF5F7F7F5FDFDFAF
                              HEX       BFBF5F7F7F7FFFFFEFFFFFDFFFFF7FFF
                              HEX       FFFFFFFFFFFFFF7FBFBC7C7979F9F2F2
                              HEX       7ABFBE6E7D7DDDFAFA7A9F9E2E3D3D5D
                              HEX       7A7A7A9F9E2E3D3D5D7A7A7ADDDEAEBD
                              HEX       BD5D7B7B5BFFFEEEFDFDDDFBFB7BFFFF
                              HEX       FFFFFFFFFFFF7BDFDFAFBFBF5F7F7F7B
                              HEX       DEDFAFBFBF5F7F7F3B0F0F1F1E1E3E3C
                              HEX       3C58BFBF6F7F7FDFFEFE7ABFBF7F7F7F
                              HEX       FFFEFE7A9D9F2F3F3F5F7E7E5E9D9F2F
                              HEX       3F3F5F7E7E5EDDDFAFBFBF5F7F7F5FDF
                              HEX       DFAFBFBF5F7F7F7FFFFFEFFFFFDFFFFF
                              HEX       7FFFFFFFFFFFFFFFFF7F919020212141
                              HEX       420244938808111111222260BFBC7C79
                              HEX       79F9F2F27ABFBE6E7D7DDDFAFA7A9F9E
                              HEX       2E3D3D5D7A7A7A9F9E2E3D3D5D7A7A7A
                              HEX       DDDEAEBDBD5D7B7B5BFFFEEEFDFDDDFB
                              HEX       FB7BFFFFFFFFFFFFFFFF7BDFDFAFBFBF
                              HEX       5F7F7F7BDEDFAFBFBF5F7F7F3B0F0F1F
                              HEX       1E1E3E3C3C58BFBF6F7F7FDFFEFE7ABF
                              HEX       BF7F7F7FFFFEFE7A9D9F2F3F3F5F7E7E
                              HEX       5E9D9F2F3F3F5F7E7E5EDDDFAFBFBF5F
                              HEX       7F7F5FDFDFAFBFBF5F7F7F7FFFFFEFFF
                              HEX       FFDFFFFF7FFFFFFFFFFFFFFFFF7FBFBC
                              HEX       7C7979F9F2F27ABFBE6E7D7DDDFAFA7A
                              HEX       9F9E2E3D3D5D7A7A7A9F9E2E3D3D5D7A
                              HEX       7A7ADDDEAEBDBD5D7B7B5BFFFEEEFDFD
                              HEX       DDFBFB7BFFFFFFFFFFFFFFFF7BDFDFAF
                              HEX       BFBF5F7F7F7BDEDFAFBFBF5F7F7F3B0F
                              HEX       0F1F1E1E3E3C3C58BFBF6F7F7FDFFEFE
                              HEX       7ABFBF7F7F7FFFFEFE7A9D9F2F3F3F5F
                              HEX       7E7E5E9D9F2F3F3F5F7E7E5EDDDFAFBF
                              HEX       BF5F7F7F5FDFDFAFBFBF5F7F7F7FFFFF
                              HEX       EFFFFFDFFFFF7FFFFFFFFFFFFFFFFF7F
                              HEX       BBBC7C7979F9F2F26ABBBE6E7D7DDDFA
                              HEX       FA6A9B9E2E3D3D5D7A7A6A9B9E2E3D3D
                              HEX       5D7A7A6AD9D2A2A5A5454B4B4BF3F2E2
                              HEX       E5E5C5CBCB6B7B73F3E6E2E6CDCD695B
                              HEX       D3A3A7A3474F4F6BDADBABB7B6576F6F
                              HEX       290B0A1B1616362C2C483BBB6B7777D7
                              HEX       EEEE68BBBB6B7777D7EEEE6A999B2B37
                              HEX       37576E6E4A999B2B3737576E6E4ED9DB
                              HEX       ABB7B7576F6F4FDBDBABB7B7576F6F6F
                              HEX       FBFBEBF7F6D7EFEF6DFBFBFBF7E2F7EF
                              HEX       EF4D8BF8E8F1E0D1E3E32B8BF8E8F1E0
                              HEX       D1E3E32388E8C8D1C091A3A303

*-----------

                              MX        %00
Check_Key                     LDA       Fake_Key_Flag
                              AND       #$00FF
                              BEQ       :no_key
                              SEP       #$20
                              NOP
                              LDAL      $E0C000
                              REP       #$20
                              NOP
                              BPL       :no_key
                              SEC
                              RTS

:no_key                       CLC
                              RTS


Set_No_Items_Selected         LDX       #$000F
                              LDA       #$FFFF
:next_item                    STA       $72,X
                              STZ       $62,X
                              DEX
                              BNE       :next_item
                              RTS


Display_Menu_Items            CLC
                              PHP
                              STX       $55
                              STX       $59
                              STY       $5B
                              STZ       $5D
                              LDA       $2C
                              STA       $5F
                              LDA       $2E
                              STA       $61
L9F5F                         LDX       $5F
                              LDY       $2E
                              INY
                              JSR       Text_Offset_For_X_Y
                              INC       $5D
                              JSR       Text_Normal
                              LDX       $5D
                              SEP       #$20
                              NOP
                              LDA       $62,X
                              CMP       $72,X
                              REP       #$20
                              NOP
                              BNE       L9F7F
                              LDA       #$0044
                              BRA       L9F82
L9F7F                         LDA       #$00A0
L9F82                         JSR       Text_Char_to_Screen
                              LDX       $2C
                              INX
                              JSR       Text_Offset_For_X_VPOS
                              LDA       $5D
                              CMP       $5B
                              BNE       L9FA9
                              JSR       Text_Inverse
                              LDX       $59
                              STX       $57
                              LDA       |$0000,X
                              AND       #$00FF
                              CMP       #$0002
                              BCS       L9FA9
                              JSR       Text_Normal
                              PLP
                              SEC
                              PHP
L9FA9                         LDX       $59
                              JSR       Text_Out_Pascal_String
                              JSR       Text_Normal
                              INX
                              JSR       L9FC1
                              STX       $59
                              LDA       |$0000,X
                              AND       #$00FF
                              BNE       L9F5F
                              PLP
                              RTS

L9FC1                         PHX
                              STX       $59
                              LDA       ($59)
                              BEQ       L9FEA
                              STA       $59
                              LDX       $5D
                              LDA       $62,X
                              AND       #$00FF
                              TAY
                              LDX       $59
                              CPY       #$0000
                              BEQ       L9FE7
L9FD9                         STX       $59
                              LDA       ($59)
L9FDD                         AND       #$00FF
                              SEC
                              ADC       $59
                              TAX
                              DEY
                              BNE       L9FD9
L9FE7                         JSR       Text_Out_Pascal_String
L9FEA                         PLX
                              INX
                              INX
                              RTS

Menu_Input_Select             SEP       #$20
                              NOP
L9FF1                         LDAL      $E0C000
                              BPL       L9FF1
L9FF7                         STAL      $E0C010
                              REP       #$20
                              NOP
L9FFE                         AND       #$00FF
LA001                         CMP       #$009B
                              BEQ       LA048
LA006                         CMP       #$008D
                              BEQ       LA04D
                              CMP       #$0088
                              BEQ       LA051
LA010                         CMP       #$0095
                              BEQ       LA058
LA015                         CMP       #$008A
                              BEQ       LA032
LA01A                         CMP       #$008B
                              BNE       L9FF1
LA01F                         LDA       $5B
                              BEQ       Menu_Input_Select
LA023                         DEC       $5B
                              BNE       LA02B
                              LDA       $5D
                              STA       $5B
LA02B                         JSR       LA05F
                              BCS       LA01F
                              BRA       Menu_Input_Select
LA032                         LDA       $5B
                              BEQ       Menu_Input_Select
                              INC       $5B
                              CMP       $5D
                              BCC       LA041
                              LDA       #$0001
                              STA       $5B
LA041                         JSR       LA05F
                              BCS       LA032
                              BRA       Menu_Input_Select
LA048                         LDY       #$0000
                              SEC
                              RTS

LA04D                         LDY       $5B
                              SEC
                              RTS

LA051                         LDA       #$FFFF
                              LDX       $5B
                              CLC
                              RTS

LA058                         LDA       #$0001
                              LDX       $5B
                              CLC
                              RTS

LA05F                         LDX       $5F
                              LDY       $61
LA063                         JSR       Text_Offset_For_X_Y
                              LDX       $55
                              LDY       $5B
                              JSR       Display_Menu_Items
                              RTS

LA06E                         PHP
                              PHX
                              JSR       Text_Normal
                              LDA       |$0000,X
                              TAY
                              LDX       #$0001
                              JSR       Text_Offset_For_X_Y
                              LDA       VPOS
                              BEQ       :row0
                              LDA       #$005C
                              BRA       :skip
:row0                         LDA       #$00DF
:skip                         LDY       #$0026
                              JSR       Text_Repeat_Char_Horiz
                              LDX       #$0002
                              LDY       VPOS
                              INY
                              JSR       Text_Offset_For_X_Y
                              PLX
                              INX
                              INX
                              JSR       Text_Out_Pascal_String
                              LDX       HPOS
                              INX
                              JSR       Text_Offset_For_X_VPOS
                              PLP
                              BCC       LA0AA
                              JSR       Text_Inverse
LA0AA                         LDA       #$0027
                              SEC
                              SBC       HPOS
                              TAY
                              LDA       #$00A0
                              JSR       Text_Repeat_Char_Horiz
                              JSR       Text_Normal
                              LDX       #$0001
                              LDY       VPOS
                              INY
                              JSR       Text_Offset_For_X_Y
                              LDA       #$004C
                              LDY       #$0026
                              JSR       Text_Repeat_Char_Horiz
                              RTS

STROUT_SelectHU               LDX       #$0002
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Select: "'H'" "'U'
                              RTS

STROUT_SelectJK               LDX       #$0002
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Select: "'J'" "'K'
                              RTS

STROUT_Open                   LDX       #$001E
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Open: "'M'
                              RTS

STROUT_Save                   LDX       #$001E
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Save: "'M'
                              RTS

STROUT_Cancel                 LDX       #$0012
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Cancel: Esc"
                              RTS

STROUT_JK                     JSR       STROUT_SelectHU
                              JSR       Text_Out_Stack_Pascal_String
                              STR       " "'J'" "'K'
                              RTS

STROUT_PressKeyToStop         LDX       #$0005
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              JSR       Text_Out_Stack_Pascal_String
                              STR       "Press any key to stop the test"
                              RTS

LA17A                         JSR       Text_Normal
                              LDX       #$0001
                              LDY       #$0016
                              JSR       Text_Offset_For_X_Y
                              LDA       #$00A0
                              LDY       #$0026
                              JSR       Text_Repeat_Char_Horiz
                              RTS

LA190                         JSR       STROUT_JK
                              JSR       STROUT_Cancel
                              JSR       STROUT_Save
                              JSR       Set_No_Items_Selected
                              SEP       #$20
                              NOP
                              LDA       #$01
                              STA       $73
                              STA       $74
                              REP       #$20
                              NOP
                              PEA       $0000
                              PEA       $0020
                              _ReadBParam
                              PLA
                              AND       #$0001
                              STA       $63
                              LDA       TWGS_Config_Byte
                              AND       #$0001                        ; get lsb
                              STA       $64
                              LDA       #$0001
                              STA       $5B
LA1C7                         SEP       #$30
                              NOP
                              LDA       TWGS_Config_Byte
                              AND       #$FE
                              ORA       $64
                              JSR       CONFIG_TW_MODE_KEEP_CACHE
                              REP       #$30
                              NOP
                              PEA       $0000
                              PEA       $0020
                              _ReadBParam
                              LDA       $01,S
                              AND       #$FFFE
                              STA       $01,S
                              LDA       $63
                              AND       #$0001
                              ORA       $01,S
                              STA       $01,S
                              PEA       $0020
LA1F6                         _WriteBParam
                              SEP       #$20
                              NOP
LA200                         LDAL      CYAREG
                              AND       #$7F
                              STAL      CYAREG
                              LDA       $63
                              AND       #$01
                              LSR
                              ROR
                              ORAL      CYAREG
                              STAL      CYAREG
                              REP       #$20
                              NOP
                              LDX       #$0005
                              LDY       #$000A
                              JSR       Text_Offset_For_X_Y
                              JSR       Check_Cache_Size
                              CMP       #$8000
                              BNE       LA231
                              LDX       #$A239
                              BRA       LA234
LA231                         LDX       #$A243
LA234                         JSR       Text_Out_Pascal_String
                              BRA       LA24C
LA239                         STR       "32K Cache"
                              STR       "8K Cache"
LA24C                         LDX       #$0002
                              LDY       #$0004
                              JSR       Text_Offset_For_X_Y
                              LDX       #$A545
LA258                         LDY       $5B
                              JSR       Display_Menu_Items
                              JSR       Menu_Input_Select
                              BCS       LA26C
                              LDA       $62,X
                              EOR       #$0001
                              STA       $62,X
                              JMP       LA1C7

LA26C                         CPY       #$0000
                              BEQ       :done
                              LDA       TWGS_Config_Byte
                              AND       #$00FE                        ; strip lsb
                              ORA       $64
                              STA       TWGS_Config_Byte
:done                         RTS

Configuration_Menu            JSR       STROUT_JK
                              JSR       STROUT_Cancel
                              JSR       STROUT_Save
                              JSR       Set_No_Items_Selected
                              SEP       #$20
                              NOP
                              LDA       #$01
                              STA       $73
                              STA       $75
                              STA       $76
                              REP       #$20
                              NOP
                              LDA       TWGS_Config_Byte
                              LSR
                              PHA
                              AND       #$0001
                              EOR       #$0001
                              STA       $63
                              PLA
                              LSR
                              PHA
                              AND       #$0001
                              STA       $65
                              PLA
                              LSR
                              PHA
                              AND       #$0001
                              STA       $66
                              PLA
                              LSR
                              AND       #$0001
                              STA       $68
                              LDA       #$0001
                              STA       $5B
LA2BD                         LDX       #$0002
LA2C0                         LDY       #$0004
                              JSR       Text_Offset_For_X_Y
                              LDX       #$A6D8
                              LDY       $5B
LA2CB                         JSR       Display_Menu_Items
                              JSR       Menu_Input_Select
LA2D1                         BCS       LA2F8
                              LDA       $62,X
                              EOR       #$0001
                              STA       $62,X
                              SEP       #$20
                              NOP
                              CPX       #$0003
                              BNE       LA2E8
                              LDA       $65
                              BNE       LA2E8
                              STA       $66
LA2E8                         CPX       #$0004
                              BNE       LA2F3
                              LDA       $66
                              BEQ       LA2F3
                              STA       $65
LA2F3                         REP       #$20
                              NOP
                              BRA       LA2BD
LA2F8                         CPY       #$0000
                              BEQ       LA317
                              LDA       TWGS_Config_Byte
                              AND       #%0000000011100001            ; #$00E1
                              STA       TWGS_Config_Byte
                              LDA       $68
                              ASL
                              ORA       $66
                              ASL
                              ORA       $65
                              ASL
                              ORA       $63
                              EOR       #$0001
                              ASL
                              ORA       TWGS_Config_Byte
                              STA       TWGS_Config_Byte
LA317                         RTS

LA318                         JSR       NVRAM_Read_Speed
                              PHA
                              SEP       #$30
                              NOP
                              JSR       TWGS_ON
                              PHA
                              JSR       GS_FAST
                              PHA
                              REP       #$30
                              NOP
                              PHP
                              LDA       #$FFFF
                              STA       Fake_Key_Flag
                              STZ       $4E
                              JSR       STROUT_PressKeyToStop
                              JSR       Set_No_Items_Selected
                              LDX       #$0001
                              LDY       #$0006
                              JSR       Text_Offset_For_X_Y
                              LDX       #Test_Strings_List
                              LDY       #$0000
                              JSR       Display_Menu_Items
                              SEP       #$30
                              NOP
                              JSR       NVRAM_Save
                              REP       #$30
                              NOP
                              JSR       IRQ_Logic_OFF
                              PLP
LA357                         PHP
                              SEI
                              LDX       #$0000
LA35C                         PHX
                              LDA       #$0001
                              JSR       LA3B1
                              BCS       LA36C
                              LDA       $01,S
                              ASL
                              TAX
                              JSR       (Test_Function_Table,X)
LA36C                         PLX
                              PHX
                              JSR       LA3B1
                              JSR       Check_Key
                              PLX
                              BCS       LA382
                              INX
                              CPX       #$0009
                              BCC       LA35C
                              PLP
                              BCS       LA357
                              BRA       LA38D
LA382                         PLP
                              SEP       #$20
                              NOP
                              STAL      $E0C010
                              REP       #$20
                              NOP
LA38D                         SEP       #$30
                              NOP
LA390                         JSR       NVRAM_Validate
                              JSR       Config_to_TW_MODE
                              PLA
                              JSR       GS_Speed_Restore
                              PLA
                              JSR       SET_TW_MODE
                              REP       #$30
                              NOP
                              PLA
                              JSR       NVRAM_Write_Speed
                              JSR       LA17A
                              JSR       STROUT_Cancel
LA3AB                         JSR       Menu_Input_Select
                              BCC       LA3AB
                              RTS

LA3B1                         SEP       #$20
                              NOP
                              XBA
                              LDA       $63,X
                              CMP       #$03
                              BEQ       LA3F3
                              LDA       #$00
LA3BD                         XBA
                              STA       $63,X
                              REP       #$20
                              NOP
                              CMP       #$0003
                              PHP
                              PHY
                              PHX
                              LDX       #$0001
                              LDY       #$0006
LA3CF                         JSR       Text_Offset_For_X_Y
                              LDX       #$A5BC
                              LDY       #$0000
                              JSR       Display_Menu_Items
LA3DB                         PLA
                              CLC
                              ADC       #$0007
                              TAY
                              LDX       #$0025
                              JSR       Text_Offset_For_X_Y
                              PLA
                              PLP
                              BNE       LA3F1
                              ORA       #$00B0
                              JSR       Text_Char_to_Screen
LA3F1                         CLC
                              RTS

LA3F3                         REP       #$20
                              NOP
                              SEC
                              RTS

Test_Function_Table           DA        Test_CPU
                              DA        Test_NVRAM
                              DA        Test_Cache_RAM
                              DA        Test_Cache_Flush
                              DA        Test_Speed_Control
                              DA        Test_IRQ_Logic
                              DA        Test_Slot_Slowdown
                              DA        Test_Language_Card
                              DA        Test_Shadow_Emulation

* ENTRY POINT: ABOUT

About_Transwarp_GS            BRA       LA42C

LA40C                         JSR       STROUT_Cancel
                              JSR       Set_No_Items_Selected
                              LDX       #$0002
                              LDY       #$0005
LA418                         JSR       Text_Offset_For_X_Y
                              LDX       #About_Screen_Strings
                              LDY       #$0000
                              JSR       Display_Menu_Items
:menu_loop                    JSR       Menu_Input_Select
                              BCC       :menu_loop
                              BRL       About_Exit

*

LA42C                         PushLong  #$00000000                    ; space for result
                              PushLong  #$00008000                    ; size in bytes of block to create
                              PEA       $5000                         ; user ID to associate with block
                              PEA       #%1000000000011000            ; attributes
                              PushLong  #$00000000                    ; pointer to where block is to begin
                              _NewHandle
                              BCC       :newhandle_ok
                              PLA                                     ; pull off empty result
                              PLA
                              BRA       LA40C
:newhandle_ok                 PushLong  #$00000000                    ; space for result
                              PushLong  #$00000200                    ; size in bytes of block to create
                              PEA       $5000                         ; user ID to associate with block
                              PEA       #%1000000000011000            ; attributes (#$8018)
                              PushLong  #$00000000                    ; pointer to where block is to begin
                              _NewHandle

                              BCC       :newhandle2_ok                ; allocation succeeded
                              PLA                                     ; otherwise pull off empty result
                              PLA
                              _DisposeHandle                          ; and dispose of the first handle
                              BRA       LA40C
:newhandle2_ok                PEA       $00E1
                              PEA       $2000
                              LDA       $0B,S
                              PHA
                              LDA       $0B,S
                              PHA
                              PEA       $0000
                              PEA       $8000
                              _PtrToHand
                              PEA       $0000
                              PEA       $0200
                              LDA       $07,S
                              PHA
                              LDA       $07,S
                              PHA
                              PEA       $0000
                              PEA       $0200
                              _PtrToHand
                              SEP       #$20
                              NOP
                              LDAL      $E0C029
                              PHA
                              REP       #$20
                              NOP
                              JSR       Read_TWGS_Mode
                              PHA
                              JSR       IRQ_Logic_OFF
                              JSR       GS_FAST
                              PHA
                              JSR       TWGS_ON
                              PHA
                              LDA       #$FFFF
                              STA       Fake_Key_Flag
                              JSR       LE5A2
                              JSR       LE62E
                              JSR       LEB6D
                              JSR       LE93F
                              PLA
                              JSR       SET_TW_MODE
                              PLA
                              JSR       GS_Speed_Restore
                              PLA
                              JSR       Set_TWGS_Mode_Keep_Cache
                              SEP       #$20
                              NOP
                              STAL      $E0C010
                              PLA
                              STAL      $E0C029
                              REP       #$20
                              NOP
                              LDA       $07,S
                              PHA
                              LDA       $07,S
                              PHA
                              PEA       $00E1
                              PEA       $2000
                              PEA       $0000
                              PEA       $8000
                              _HandToPtr
                              LDA       $03,S
                              PHA
                              LDA       $03,S
                              PHA
                              PEA       $0000
                              PEA       $0200
                              PEA       $0000
                              PEA       $0200
                              _HandToPtr
                              _DisposeHandle
                              _DisposeHandle
About_Exit                    RTS

_DELETEME3
Debug_HexWord_Out             PHA                                     ; not used?
                              LDX       #$0000
                              LDY       #$0000
                              JSR       Text_Offset_For_X_Y
                              PLA
                              JSR       Text_Out_Word_As_Hex
                              RTS

Speed_String_Table            STR       "System Speed:"
                              DA        :system_speeds
                              STR       "TransWarp Speed:"
                              DA        :twgs_speeds
                              DB        $00
:system_speeds                STR       " Normal"
                              STR       " Fast  "
                              DB        $00
:twgs_speeds                  STR       " Normal   "
                              STR       " TransWarp"
                              DB        $00
                              STR       "Quick test"
                              DW        $0000
                              STR       "Continuous test"
                              DW        $0000
                              STR       " "
                              DW        $0000
                              STR       "Quit"
                              DW        $0000
                              DB        $00
Test_Strings_List             STR       "CPU................."
                              DA        String_Space14
                              STR       "Non-Volatile RAM...."
                              DA        String_Space14
                              STR       "Cache RAM..........."
                              DA        String_Space14
                              STR       "Cache flush........."
                              DA        String_Space14
                              STR       "Speed control......."
                              DA        String_Space14
                              STR       "Interrupt logic....."
                              DA        String_Space14
                              STR       "Slot slowdown......."
                              DA        String_Space14
                              STR       "Language card......."
                              DA        String_Space14
                              STR       "Shadow emulation...."
                              DA        String_Space14
                              DB        $00
String_Space14                STR       "              "
                              STR       " -- Testing --"
                              STR       "    Passed    "
                              STR       " ** Failed ** "
                              STR       "    Skipped   "
                              DB        $00
                              STR       "AppleTalk/IRQ:"
                              DA        String_Off
                              STR       " "
                              DB        $00
                              DB        $00
                              STR       "Startup Graphics:"
                              DA        String_Off
                              STR       "Startup Sound:"
                              DA        String_Off
                              STR       " "
                              DB        $00
                              DB        $00
                              DB        $00
String_Off                    STR       " Off"
                              STR       " On "
                              DB        $00
                              STR       " No "
                              STR       " Yes"
                              DB        $00
About_Screen_Strings          STR       "         TransWarp GS"
                              DW        $0000
                              STR       "    Copyright (c)1988-1991"
                              DW        $0000
                              STR       "     Applied Engineering"
                              DW        $0000
                              STR       " "
                              DW        $0000
                              STR       "        P.O. Box 5100"
                              DW        $0000
                              STR       "   Carrollton, Texas 75011"
                              DW        $0000
                              STR       " "
                              DW        $0000
                              STR       "   Hardware: Steve Malechek"
                              DW        $0000
                              STR       " LCA design: Roger Kidson"
                              DW        $0000
                              STR       "     Layout: Harvey Wende"
                              DW        $0000
                              STR       "   Firmware: John Stephen"
                              DW        $0000
                              STR       " "
                              DW        $0000
                              STR       " "
                              DW        $0000
                              STR       "    Sales: (214) 241-6060"
                              DW        $0000
                              STR       "Tech. Support: (900) 369-2323"
                              DW        $0000
                              DB        $00

*-----------

                              MX        %01
LA871                         JSR       LA8CB
                              LDA       #$03E8
                              STA       $08
                              LDA       #$0000
                              STA       $0A
                              JSR       32Bit_Divide
LA881                         LDA       $00
                              CMP       #$000A
                              BCC       LA893
                              SBC       #$000A
                              PHA
                              LDA       #$00B1
                              JSR       Text_Char_to_Screen
                              PLA
LA893                         CLC
                              ADC       #$00B0
                              JSR       Text_Char_to_Screen
                              LDA       #$00AE
                              JSR       Text_Char_to_Screen
                              LDA       $04
                              STA       $00
                              LDA       $06
                              STA       $02
                              LDA       #$86A0
                              STA       $08
                              LDA       #$0001
                              STA       $0A
                              JSR       32Bit_Divide
                              LDA       $00
                              CLC
LA8B8                         ADC       #$00B0
                              JSR       Text_Char_to_Screen
                              LDX       #$C5
                              TAY
                              JSR       Text_Out_Pascal_String
                              RTS

String_MHz                    STR       " MHz "

LA8CB                         INX
                              STX       $00
                              STZ       $02
                              LDA       #$E209
                              STA       $08
                              LDA       #$0198
LA8D8                         STA       $0A
                              JSR       32Bit_Multiply
                              LDA       $02
                              CLC
                              ADC       #$01F4
                              STA       $00
                              LDA       $04
                              ADC       #$0000
                              STA       $02
                              LDA       #$03E8
                              STA       $08
                              STZ       $0A
                              JSR       32Bit_Divide
                              RTS

LA8F7                         LDA       TWGS_Config_Byte
                              AND       #$0008                        ; bit 4,  #%00000000 00001000
                              BEQ       :no_sound                     ; i guess
                              LDX       #$87
                              PLB
                              JSR       Build_Wavetable
                              LDA       #$001D
                              JSR       Copy_Sound_Data
:no_sound                     RTS

                              MX        %00

Copy_Sound_Data               PHP
                              SEI
                              SEP       #$20
                              NOP
                              XBA
                              LDA       #$00
                              STAL      SoundCtl                      ; DOC access, no autoinc, vol 0
                              LDA       #$E1
                              STAL      SoundAdrL
                              XBA
                              DEC
                              ASL
                              INC
                              STAL      SoundData
                              REP       #$20
                              NOP
                              LDX       #LA958
                              LDY       #$0000
                              LDA       #$0000
LA931                         JSR       Setup_DOC
                              INY
                              CPY       #$0020
                              BCC       LA931
                              SEP       #$20
                              NOP
                              LDA       #$00
                              STAL      SoundCtl                      ; DOC access, no autoinc, vol 0
                              LDA       #$E0
                              STAL      SoundAdrL
                              LDAL      SoundData
:loop                         LDAL      SoundData
                              BPL       :loop
                              REP       #$20
                              NOP
                              PLP
                              RTS

LA958                         DB        $00
                              DB        $00
                              DB        $00
                              DB        $03
                              DB        $00

LA95D                         LDA       TWGS_Config_Byte
                              AND       #%0000000000001000            ; #$0008
                              BEQ       :done
                              JSR       Time_Active_Screen
                              STX       $00
                              STZ       $02
                              LDA       #$0087
                              STA       $08
                              STZ       $0A
                              JSR       32Bit_Multiply
                              LDA       #$42E0
                              STA       $08
                              STZ       $0A
                              JSR       32Bit_Divide
                              LDX       #Sound_Cfg_Table1
                              LDY       #$0000
                              LDA       $00
                              JSR       Setup_DOC
                              LDX       #Sound_Cfg_Table2
                              LDY       #$0001
                              LDA       $00
                              JSR       Setup_DOC
:done                         RTS

Sound_Cfg_Table1              DB        $C8
                              DB        $00
                              DB        $00
                              DB        $00
                              DB        $3F
Sound_Cfg_Table2              DB        $C8
                              DB        $00
                              DB        $00
                              DB        $10
                              DB        $3F

LA9A0                         LDA       TWGS_Config_Byte
                              AND       #$0008
                              BEQ       LA9C5
                              LDA       #$0001
                              JSR       Copy_Sound_Data
                              LDX       #Sound_Config_Data
                              LDY       #$0000
                              LDA       #$0000
                              JSR       Setup_DOC
                              LDX       #Sound_Config_Data
                              LDY       #$0001
                              LDA       #$0000
                              JSR       Setup_DOC
LA9C5                         RTS

Sound_Config_Data             DB        $00                           ; i think...
                              DB        $00
                              DB        $00
                              DB        $01
                              DB        $00

Setup_DOC                     PHP
                              PHX
                              PHY
                              PHA
                              PHA
                              SEI
                              SEP       #$20
                              NOP
                              LDA       #$0F
                              STAL      SoundCtl                      ; DOC access, no autoinc, vol 15
                              PLA
                              JSR       Store_Sound_Data
                              PLA
                              JSR       Store_Sound_Data
:store_sound_loop             LDA       |$0000,X
                              JSR       Store_Sound_Data
                              INX
                              CPY       #$00E0
                              BCC       :store_sound_loop
                              REP       #$20
                              NOP
                              PLA
                              PLY
                              PLX
                              PLP
                              RTS


Store_Sound_Data              PHA
                              REP       #$20
                              NOP
                              TYA
                              STAL      SoundAdrL
LA9FF                         SEP       #$20
                              NOP
                              PLA
                              STAL      SoundData
                              REP       #$20
                              NOP
                              TYA
                              CLC
                              ADC       #$0020
                              TAY
                              SEP       #$20
                              NOP
                              RTS

Build_Wavetable               STX       $85
                              SEP       #$20
                              NOP
                              LDA       #$6F
                              STAL      SoundCtl                      ; RAM access, autoinc, vol F
                              REP       #$20
                              NOP
                              LDA       #$0000
                              STAL      SoundAdrL
                              STA       $99
                              LDA       ($85)
                              AND       #$00FF
                              STA       $87
                              LDA       #$0001
                              STA       $8F
                              LDA       #$0080
                              STA       $97
                              LDA       #$0008
                              STA       $89
                              SEP       #$10
                              NOP
LAA44                         SEP       #$20
                              NOP
                              LDA       $87
                              TAY
                              AND       #$03
                              STA       $8B
                              TYA
                              AND       #$04
                              STA       $8D
                              REP       #$20
                              NOP
                              LDA       $87
                              LSR
                              LSR
                              LSR
                              STA       $87
                              LDY       $89
                              DEY
                              DEY
                              DEY
                              STY       $89
                              CPY       #$03
                              BCS       LAA83
                              INC       $85
                              LDA       ($85)
                              AND       #$00FF
                              CPY       #$00
                              BEQ       LAA79
                              ASL
                              DEY
                              BEQ       LAA79
                              ASL
                              DEY
LAA79                         TSB       $87
                              LDA       $89
                              CLC
                              ADC       #$0008
                              STA       $89
LAA83                         LDA       $8F
                              ASL
                              TAY
                              LDA       Wavetable_Data,Y
                              STA       $91
                              LSR
                              STA       $93
                              LSR
                              STA       $95
                              LDA       $8B
                              LSR
                              BCS       LAA99
                              STZ       $93
LAA99                         LSR
                              BCS       LAA9E
                              STZ       $91
LAA9E                         LDA       $91
                              CLC
                              ADC       $93
                              STA       $91
                              LDY       $8D
                              BEQ       LAAB7
                              EOR       #$FFFF
                              INC
                              STA       $91
                              LDA       $95
                              EOR       #$FFFF
                              INC
                              STA       $95
LAAB7                         LDA       $97
                              CLC
                              ADC       $91
                              STA       $97
                              BMI       LAACC
                              BEQ       LAACC
                              CMP       #$0100
                              BCC       LAACF
                              LDA       #$00FF
                              BRA       LAACF
LAACC                         LDA       #$0001
LAACF                         PHA
                              LDA       $97
                              CLC
                              ADC       $95
                              STA       $97
                              LDA       $8B
                              ASL
                              TAY
                              LDA       Wavetable_Data2,Y
                              CLC
                              ADC       $8F
                              STA       $8F
                              TAY
                              DEY
                              BPL       LAAEE
                              LDA       #$0001
                              STA       $8F
                              BRA       LAAFA
LAAEE                         CMP       Wavetable_Data
                              BCC       LAAFA
                              BEQ       LAAFA
                              LDA       Wavetable_Data
                              STA       $8F
LAAFA                         PLA
                              SEP       #$20
                              NOP
                              STAL      SoundData
                              REP       #$20
                              NOP
                              INC       $99
                              LDA       $99
                              CMP       #$7225
                              BCS       LAB11
                              JMP       LAA44

LAB11                         SEP       #$20
                              NOP
                              REP       #$10
                              NOP
                              LDX       $99
                              LDA       #$00
:store_loop                   STAL      SoundData
                              INX
                              CPX       #$8000
                              BCC       :store_loop
                              REP       #$20
                              NOP
                              RTS

*-----------

                              PUT       TWGS.2
                              PUT       TWGS.3














