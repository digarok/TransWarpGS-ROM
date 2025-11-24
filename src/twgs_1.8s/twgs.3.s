*

Init_Intro_Graphics     SEP #$20
                        NOP
                        LDA #$41
                        STAL $E0C029
                        REP #$20
                        NOP
                        LDX #$8000
                        LDA #$0000
:loop                   STAL $E11FFE,X
                        DEX
                        DEX
                        BNE :loop
                        SEP #$20
                        NOP
                        LDA #$C1
                        STAL $E0C029
                        REP #$20
                        NOP
                        LDA #$000F
                        LDX #$0000
                        LDY #$003C
                        JSR Set_SCBs_to_Pal
                        PHB
                        LDX #LE417
                        LDY #$0200
                        LDA #$00B5
; MVN TWGS_Config,ptr000000 , $BC0000,$000000
                        MVN $BC0000,$000000
                        PLB
                        RTS

Copy_SCB_Tail           SEP #$30
                        NOP
                        STY $CB
                        LDY #$00
:scb_loop               LDA SCB_Tail_Data,Y
                        STAL $E19D00,X
                        INY
                        INX
                        CPX $CB
                        BCC :scb_loop
                        REP #$30
                        NOP
                        RTS

SCB_Tail_Data           HEX 000000010101            ; probably one of the "TransWarp GS" tails
                        HEX 020304050606
                        HEX 0708090A0B0B

Set_SCBs_to_Pal         INY
                        STY $CB
                        SEP #$20
                        NOP
:loop                   STAL $E19D00,X
                        INX
                        CPX $CB
                        BCC :loop
                        REP #$20
                        NOP
                        RTS

Get_Byte_from_SourcePtr LDA [SrcPtr32]
                        INC SrcPtr32                ; inc low word of pointer
                        AND #$00FF                  ; strip high byte
                        RTS

Put_Byte_to_DestPtr     SEP #$20
                        NOP
                        STA [DstPtr32]
                        REP #$20
                        NOP
                        INC DstPtr32                ; inc low word of pointer
                        RTS

Unpack_Data             LDX #$0001
                        JSR Get_Byte_from_SourcePtr
                        CMP #$0080
                        BCC :literal_data           ; ?
                        AND #$0077
                        PHA
                        JSR Get_Byte_from_SourcePtr
                        TAX
                        BEQ :done
                        PLA
:literal_data           CLC
                        ADC $E1
:repeat_loop            JSR Put_Byte_to_DestPtr
                        DEX
                        BNE :repeat_loop
                        BRA Unpack_Data
:done                   PLA
                        RTS

LE227                   JSR Get_Byte_from_SourcePtr
                        JSR Put_Byte_to_DestPtr
                        DEX
                        BNE LE227
                        RTS

Unpack_to_Screen        STZ $E1
                        LDA #^Image_Data_Packed     ; #$00BC
                        STA SrcPtr32+2
                        LDA #$00E1
                        STA DstPtr32+2
                        LDA #$2000
LE240                   STA DstPtr32
                        LDA #Image_Data_Packed
                        STA SrcPtr32
                        JSR Unpack_Data
                        LDA #Image_Data2_Packed
                        STA SrcPtr32
                        JSR Unpack_Data
                        RTS

Load_Palettes           LDX #$0000
                        LDY #$0000
:copy_rgb_word          LDA Master_Palette_Data,Y
                        STAL $E19E00,X
                        INY
                        INY
                        TYA
                        AND #$001F                  ; keeps resetting source index after each palette written
                        TAY
                        INX
                        INX
                        CPX #$01E0                  ; palettes 0 - 14 now the same?
                        BCC :copy_rgb_word
                        LDY #$0000
:gen_fade_col_loop      LDA Color_Fade_Lookup_Values,Y
                        AND #$00FF
                        ASL
                        TAX
                        LDA Color_Fade_RGB_Table,X
                        PHA
                        TYA
                        ASL                         ; *2
                        ASL                         ; *4
                        ASL                         ; *8
                        ASL                         ; *16
                        ASL                         ; *32 = same color in the next palette
                        TAX                         ; as our index
                        PLA
                        STAL $E19E0E,X              ; store next fade color
                        INY
                        CPY #$000C                  ; not all palettes... up to pal 12
                        BCC :gen_fade_col_loop
                        LDX #$0000
:next_pal               PHX
                        LDA Pattern_Table,X
                        AND #$00FF
                        ASL
                        ASL
                        TAY
                        TXA
                        XBA
                        LSR
                        LSR
                        LSR
                        TAX
                        CLC
                        ADC #$0010
                        STA $CB
                        LDA Pattern_RGB_Table,Y
:create_rgb             STAL $E19E10,X
                        CLC
                        ADC Pattern_RGB_Table+2,Y
                        INX
                        INX
                        CPX $CB
                        BCC :create_rgb
                        PLX
                        INX
                        CPX #$000C
                        BCC :next_pal
                        RTS

Master_Palette_Data     HEX 00000600270149047B07AD0AFF0FDF08
                        HEX 00002202440466068808AA0ACC0CFF0F

Color_Fade_Lookup_Values HEX 000000010304030403020100
Color_Fade_RGB_Table    DW  $08DF
                        DW  $09DF
                        DW  $0BEF
                        DW  $0CEF
                        DW  $0EFF

Pattern_Table           HEX 000102020203030404040505
Pattern_RGB_Table       HEX 100020001001200210011002
                        HEX 000100020101020201000200


Setup_Palette_12        LDX #$001F
:copy_loop              LDA Palette_12_Data,X
                        STAL $E19F80,X
                        DEX
                        BPL :copy_loop
                        RTS

Palette_12_Data         HEX 000000040007000B000F700FF00FF007
                        HEX F000F700FF007F000F000B0007000400


* @todo: Investigate. Possibly the animation vectors.
Generate_Cached_Lookup_Table LDA #$2000
                        LDX #$0000
                        LDY #$0012
:loop                   STA Buffer_36,X
                        CLC
                        ADC #$008C                  ; 140
                        INX
                        INX
                        DEY
                        BNE :loop
                        LDA #$29D8
                        LDX #$0000
                        LDY #$0012
:loop2                  STA Buffer2_36,X
                        CLC
                        ADC #$001F                  ; 31
                        INX
                        INX
                        DEY
                        BNE :loop2
                        RTS


SHGR_Offset_for_X_Y     TYA
                        XBA
                        LSR
                        STA DstPtr32
                        LSR
                        LSR
                        ADC DstPtr32
                        STA DstPtr32
                        TXA
                        ADC DstPtr32
                        ADC #$2000
                        TAY
                        RTS


Fill_Bank_E1_with_Byte  PHA
                        TXA
                        TYX
                        TAY
                        PLA
                        SEP #$20
                        NOP
:fill_loop              STAL $E10000,X
                        INX
                        DEY
                        BNE :fill_loop
                        REP #$20
                        NOP
                        RTS


Generate_Grayscale_Color_15 LDA #$0000
                        LDX #$0000
:write_color_15_loop    STAL $E19E1E,X
                        PHA
                        TXA
                        CLC
                        ADC #$0020
                        TAX
                        PLA
                        ADC #$0111
                        CPX #$0200
                        BCC :write_color_15_loop
                        RTS

LE3B6                   PHB
                        PEA $E1E1                   ;
                        PLB                         ; set bank to E1
                        PLB                         ;
                        STA $CB
                        TXA
                        EOR #$FFFF
                        SEC
                        ADC #$00A0
                        STA $F5
:loop                   PHX
                        SEP #$20
                        NOP
                        LDA #$00
:zero                   STA |$0000,Y
                        INY
                        DEX
                        BNE :zero
                        REP #$20
                        NOP
                        TYA
                        CLC
                        ADC $F5
                        TAY
                        PLX
                        DEC $CB
                        BNE :loop
                        PLB
                        RTS

LE3E4                   PHB
                        PEA $E1E1
                        PLB
                        PLB
                        STX $FF
                        SEP #$20
                        NOP
                        LDA #$01
                        STA $E1
                        XBA
                        LDA #$00
LE3F6                   CLC
LE3F7                   ADC #$0F
LE3F9                   CMP $FF
                        BCC LE403
                        SBC $FF
                        INC $E1
                        BRA LE3F9
LE403                   XBA
                        ASL
                        ASL
                        ASL
                        ASL
                        ORA $E1
                        STA |$0000,Y
                        XBA
                        INY
                        DEX
                        BNE LE3F6
                        REP #$20
                        NOP
                        PLB
                        RTS

*-----------

LE417                   =   *

                        HEX 4C77028BA9E1E148ABABA90000E220EA
                        HEX A5E3C5E5B00285E5A5E3E5E5EB1AEBC5
                        HEX E5B0F78F920200EB8F9C0200A5E58FA0
                        HEX 02008F9402008F980200C220EAA9A000
                        HEX 38E5E585F564EFA5ED85F1A6F3207702
                        HEX A5EF1865EB85EF38E5ED901085EFA5F3
                        HEX 1865E385F3A5EF38E5EDB0F0981865F5
                        HEX A8C6F1D0D6AB6B8A8F8B0200988F8E02
                        HEX 00E230EAA900AAA8EB18BD0000990000
                        HEX EB6900C9009002E900EB8A6900AAC8C0
                        HEX 0090E7C230EA8A186F8B0200AA98186F
                        HEX 8E0200A860

*--- $0200 code for reference


* JMP L0277
*
*L0203 PHB
* LDA #$E1E1
* PHA
* PLB
* PLB
* LDA #$0000
* SEP #$20
* NOP
* LDA $E3
* CMP $E5
* BCS L0218
* STA $E5
*L0218 LDA $E3
*L021A SBC $E5
* XBA
* INC
* XBA
* CMP $E5
* BCS L021A
* STAL L0291+1
* XBA
* STAL L029B+1
* LDA $E5
* STAL L029F+1
* STAL L0293+1
* STAL L0297+1
* REP #$20
* NOP
* LDA #$00A0
* SEC
* SBC $E5
* STA $F5
* STZ $EF
* LDA $ED
* STA $F1
*L024B LDX $F3
* JSR L0277
* LDA $EF
* CLC
* ADC $EB
* STA $EF
* SEC
* SBC $ED
* BCC L026C
*L025C STA $EF
* LDA $F3
* CLC
* ADC $E3
* STA $F3
* LDA $EF
* SEC
* SBC $ED
* BCS L025C
*L026C TYA
* CLC
* ADC $F5
* TAY
* DEC $F1
* BNE L024B
* PLB
* RTL
*
*L0277 TXA
* STAL L028A+1
* TYA
* STAL L028D+1
* SEP #$30
* NOP
* LDA #$00
* TAX
* TAY
* XBA
* CLC
*L028A LDA |$0000,X
*L028D STA |$0000,Y
* XBA
*L0291 ADC #$00
*L0293 CMP #$00
* BCC L0299
*L0297 SBC #$00
*L0299 XBA
* TXA
*L029B ADC #$00
* TAX
* INY
*L029F CPY #$00
* BCC L028A
* REP #$30
* NOP
* TXA
* CLC
* ADCL L028A+1
* TAX
* TYA
* CLC
* ADCL L028D+1
* TAY
* RTS

*----------- END OF $200 CODE

LE4CC                   STZ $D7
                        STZ $D9
                        STZ $DB
                        RTS

LE4D3                   LDA $D9
                        BNE LE4ED
                        JSR Get_Byte_from_SourcePtr
                        PHA
                        AND #$007F
                        STA $D9
                        PLA
                        AND #$0080
                        STA $D7
                        BEQ LE4ED
                        JSR Get_Byte_from_SourcePtr
                        STA $DB
LE4ED                   LDA $D7
                        BEQ LE4F5
                        LDA $DB
                        BRA LE4F8
LE4F5                   JSR Get_Byte_from_SourcePtr
LE4F8                   DEC $D9
                        RTS

LE4FB                   STZ $DD
                        STZ $DF
                        RTS

LE500                   LDA $DD
                        BNE LE50F
                        JSR LE4D3
                        XBA
                        STA $DF
                        LDA #$0004
                        STA $DD
LE50F                   LDA #$0000
                        ASL $DF
                        BCC LE519
                        LDA #$00F0
LE519                   ASL $DF
                        BCC LE520
                        ORA #$000F
LE520                   DEC $DD
                        RTS

LE523                   STA $E1
                        STX SrcPtr32
                        LDA #^TWGS_Config           ; $00BC
                        STA SrcPtr32+2
                        LDX #$0000
                        JSR SHGR_Offset_for_X_Y
                        STY $D3
                        LDA #$00E1
                        STA $D5
                        JSR Get_Byte_from_SourcePtr
                        INC
                        STA $FF
                        LDA #$00A0
                        SEC
                        SBC $FF
                        LSR
                        CLC
                        ADC $D3
                        STA $D3
                        JSR Get_Byte_from_SourcePtr
                        INC
                        STA $CD
                        RTS

LE552                   JSR LE523
                        JSR LE4CC
                        JSR LE4FB
LE55B                   LDA $FF
                        STA $CB
LE55F                   JSR LE500
                        AND $E1
                        EOR [$D3]
                        STA [$D3]
                        INC $D3
                        DEC $CB
                        BNE LE55F
                        LDA $D3
                        SEC
                        SBC $FF
                        ADC #$009F
                        STA $D3
                        DEC $CD
                        BNE LE55B
                        RTS

LE57D                   JSR LE523
                        JSR LE4CC
LE583                   LDA $FF
                        STA $CB
LE587                   JSR LE4D3
                        EOR [$D3]
                        JSR Put_Byte_to_DestPtr
                        DEC $CB
                        BNE LE587
                        LDA $D3
                        SEC
                        SBC $FF
                        ADC #$009F
                        STA $D3
                        DEC $CD
                        BNE LE583
                        RTS

Prepare_Intro_Graphics  JSR Init_Intro_Graphics
                        JSR Unpack_to_Screen
                        JSR Load_Palettes
                        JSR Generate_Cached_Lookup_Table
                        RTS

Play_Startup_Intro      PHP
                        REP #$30
                        NOP
                        LDA TWGS_Config_Byte
                        AND #$0004
                        BEQ LE60C
                        SEP #$20
                        NOP
                        LDAL $E0C029                ; store gfx mode
                        PHA
                        REP #$20
                        NOP
                        PHB
                        PHD
                        PHK
                        PLB
                        PEA $0000
                        PLD
                        JSR Read_TWGS_Mode
                        PHA
                        JSR DISABLE_IRQ_LOGIC
                        JSR GS_FAST
                        PHA
                        JSR TWGS_ON
LE5DB                   PHA
                        STZ Fake_Key_Flag
                        JSR Prepare_Intro_Graphics
                        JSR Prepare_Intro_Audio
                        JSR Prepare_Intro_DOC_Regs
                        JSR LE62E
                        JSR Do_Intro_Anim
                        JSR LA9A0
                        PLA
                        JSR SET_TW_CONFIG
                        PLA
                        JSR GS_Speed_Restore
                        PLA
                        JSR Set_TWGS_Mode_Keep_Cache
                        PLD
                        PLB
                        SEP #$20
                        NOP
                        JSR Clear_Text_Pages_E0_E1
                        PLA
                        STAL $E0C029
                        REP #$20
                        NOP
LE60C                   PLP
                        RTS

                        MX  %10

Clear_Text_Pages_E0_E1  LDX #$0000
                        LDA #$A0
LE613                   STAL $E00400,X
                        STAL $E10400,X
                        INX
                        CPX #$0400
                        BCC LE613
                        STAL TXTSET                 ; $E0C051
                        STAL MIXCLR                 ; $E0C052
                        STAL TXTPAGE1               ; $E0C054
                        RTS

                        MX  %00

LE62E                   STZ $BD
                        STZ $B9
                        STZ $BB
LE634                   JSR LE649
                        JSR LE7E6
                        JSR Check_Key
                        BCS LE648
                        INC $BD
                        LDA $BD
                        CMP #$5DD4
                        BCC LE634
LE648                   RTS

LE649                   LDA $B9
                        BNE LE672
                        LDA $BD
                        CMP #$0014
                        BCC LE66B
                        JSR Generate_Grayscale_Color_15
                        LDA #LDE07
                        STA $9F
                        STA $A5
                        STA $A7
                        STZ $AF
                        STZ $B1
                        STZ $B3
                        STZ $B5
                        INC $B9
LE66A                   RTS

LE66B                   LDY #$2710
LE66E                   DEY
                        BNE LE66E
                        RTS

LE672                   CMP #$0001
                        BNE LE66A
                        LDA ($9F)
                        AND #$00FF
                        LSR
                        STA $C1
                        LDA #$00A0
                        SEC
                        SBC $C1
                        SBC $C1
                        STA $F7
                        LDY #$0002
                        LDA ($9F),Y
LE68E                   AND #$00FF
                        STA $F9
                        DEY
                        LDA ($9F),Y
                        AND #$00FF
                        STA $A1
                        CLC
                        ADC $F9
                        STA $A3
                        LDX $A1
                        LDY $A3
                        JSR Copy_SCB_Tail
                        LDX $C1
                        LDY $A1
                        JSR SHGR_Offset_for_X_Y
                        JSR LEB2D
                        LDA $9F
                        SEC
                        SBC #$0080
                        CMP #LDE07
                        BCS LE6BF
                        LDA #LDE07
LE6BF                   STA $A9
                        JSR LE74A
                        LDA $B1
                        CLC
                        ADC #$0005
                        STA $B1
LE6CC                   SEC
                        SBC #$001E
                        BCC LE6E0
                        STA $B1
                        LDA $B5
                        CLC
                        ADC #$0005
                        STA $B5
                        LDA $B1
                        BRA LE6CC
LE6E0                   LDA $B5
                        CLC
                        ADC $AF
                        PHA
                        AND #$00FF
                        STA $AF
                        PLA
                        XBA
                        AND #$00FF
                        ASL
                        ASL
                        CLC
                        ADC $9F
                        STA $9F
                        CMP #Init_Intro_Graphics
                        BCC LE705
                        LDA $9F
                        STA $A9
                        JSR LE74A
                        INC $B9
LE705                   RTS

LE706                   LDA ($AB)
                        AND #$00FF
                        LSR
                        STA $9B
                        LDY #$0005
                        LDA ($AB),Y
                        AND #$00FF
                        STA $9D
                        LDY #$0001
                        LDA ($AB),Y
                        AND #$00FF
                        CMP $9D
                        BCC LE72D
                        BEQ LE748
                        INY
                        CLC
                        ADC ($AB),Y
                        AND #$00FF
LE72D                   CMP $A3
                        BCS LE735
                        CMP $A1
                        BCS LE748
LE735                   PHA
                        TAY
                        LDX $9B
                        JSR SHGR_Offset_for_X_Y
                        LDA #$00A0
LE73F                   SEC
                        SBC $9B
                        SBC $9B
                        TAX
                        PLA
                        CLC
                        RTS

LE748                   SEC
                        RTS

LE74A                   LDA $A5
LE74C                   STA $AB
                        CMP $A9
                        BCS LE773
                        JSR LE706
                        BCS LE76B
                        PHA
                        LDA #$0000
                        JSR Fill_Bank_E1_with_Byte
                        PLX
                        SEP #$20
                        NOP
                        LDA #$00
                        STAL $E19D00,X
                        REP #$20
                        NOP
LE76B                   LDA $AB
                        CLC
                        ADC #$0004
                        BRA LE74C
LE773                   STA $A5
                        STZ $AD
LE777                   STA $AB
                        CMP $A7
                        BCS LE79C
                        JSR LE706
                        BCS LE792
                        TAX
                        LDY $AD
                        SEP #$20
                        NOP
                        LDA LE7C6,Y
                        STAL $E19D00,X
                        REP #$20
                        NOP
LE792                   INC $AD
                        LDA $AB
                        CLC
                        ADC #$0004
                        BRA LE777
LE79C                   STA $AB
                        CMP $9F
                        BCS LE7C3
                        JSR LE706
                        BCS LE7BB
                        PHA
                        LDA #$00FF
                        JSR Fill_Bank_E1_with_Byte
                        PLX
                        SEP #$20
                        NOP
                        LDA #$0F
                        STAL $E19D00,X
                        REP #$20
                        NOP
LE7BB                   LDA $AB
                        CLC
LE7BE                   ADC #$0004
                        BRA LE79C
LE7C3                   STA $A7
                        RTS

LE7C6                   HEX 01010101010202020203030304040405
                        HEX 050506060607070808090A0B0C0D0E0F

LE7E6                   LDA $BB
                        BNE LE819
                        LDA $BD
                        CMP #$1F54
                        BCC LE818
                        JSR Load_Palettes
                        LDX #$005C
                        LDY #$006E
                        JSR Copy_SCB_Tail
                        LDA #$FFFF
                        STA $A9
                        LDA #$0012
                        STA $9F
                        LDA #$0001
                        STA $BF
                        LDA #$0001
                        STA $AD
                        LDA #$0002
                        STA $C9
                        INC $BB
LE818                   RTS

LE819                   CMP #$0001
                        BNE LE832
                        JSR LE88D
                        BCC LE825
                        INC $BF
LE825                   JSR LE881
                        LDA $BF
                        CMP #$002E
                        BCC LE831
                        INC $BB
LE831                   RTS

LE832                   CMP #$0002
                        BNE LE84F
                        JSR LE88D
                        BCC LE840
                        DEC $9F
                        INC $BF
LE840                   JSR LE881
                        LDA $9F
                        CMP #$FFEE
                        BNE LE84E
                        INC $BB
                        STZ $A9
LE84E                   RTS

LE84F                   CMP #$0003
                        BNE LE86C
                        JSR LE88D
                        BCC LE85D
                        INC $9F
                        DEC $BF
LE85D                   JSR LE881
                        LDA $9F
                        BNE LE86B
                        INC $BB
                        LDA #$005A
                        STA $AB
LE86B                   RTS

LE86C                   CMP #$0004
                        BNE LE880
                        JSR LE881
                        JSR LE88D
                        BCC LE87F
                        DEC $AB
                        BNE LE87F
                        INC $BB
LE87F                   RTS
LE880                   RTS

LE881                   LDX $BF
                        LDY #$005C
                        JSR SHGR_Offset_for_X_Y
                        JSR LE89A
                        RTS

LE88D                   DEC $C9
                        BNE LE898
                        LDA #$0002
                        STA $C9
                        SEC
                        RTS

LE898                   CLC
                        RTS

LE89A                   PHB
                        LDY #$005C
                        LDX #$0000
                        JSR SHGR_Offset_for_X_Y
                        LDA #$E1E1
                        PHA
                        PLB
                        PLB
                        LDA $9F
                        BPL LE8B2
                        EOR #$FFFF
                        INC
LE8B2                   STA $A3
                        LDA $BF
                        STA $A5
                        STZ $A1
                        LDA #$0081
                        SEC
                        SBC $BF
                        STA $A7
                        LDX #$29D8
LE8C5                   JSR LE911
                        LDA $A9
                        BEQ LE8D1
                        DEY
                        STA |$0000,Y
                        INY
LE8D1                   LDA #$001E
                        MVN $E10000,$E10000
                        LDA #$0000
                        STA |$0000,Y
                        TYA
                        CLC
                        ADC $A7
                        TAY
                        LDA $A1
                        CLC
                        ADC $A3
                        CMP #$0012
                        BCC LE8EF
                        SBC #$0012
LE8EF                   STA $A1
                        BCC LE901
                        LDA $9F
                        BPL LE8FD
                        DEC $A5
                        INC $A7
                        BRA LE901
LE8FD                   INC $A5
                        DEC $A7
LE901                   CPX #$2C06
                        BCC LE8C5
                        PLB
                        DEC $AD
                        BPL LE910
                        LDA #$000C
                        STA $AD
LE910                   RTS

LE911                   LDA $AD
                        BNE LE939
                        TYA
                        CLC
                        ADC $A5
                        STA $9B
                        SEP #$20
                        NOP
LE91E                   LDA |$0000,Y
                        CMP #$88
                        BCC LE930
                        BNE LE92B
                        LDA #$00
                        BRA LE92D
LE92B                   SBC #$11
LE92D                   STA |$0000,Y
LE930                   INY
                        CPY $9B
                        BCC LE91E
                        REP #$20
                        NOP
                        RTS

LE939                   TYA
                        CLC
LE93B                   ADC $A5
                        TAY
                        RTS

Do_Intro_Anim           JSR Check_Key
                        BCC :do_anim
                        RTS

:do_anim                JSR Setup_Palette_12
                        LDA #$00FF
                        STA $9F
                        TAY
                        JSR LEA9F
                        BRA LE989
LE953                   LDY $9F
                        JSR LEA9F
                        JSR LEA35
                        SEP #$20
                        NOP
                        LDX $B5
                        LDA #$0C
                        STAL $E19D00,X
                        REP #$20
                        NOP
                        LDY $C1
                        LDX $F7
                        JSR LE3E4
                        LDA $B7
                        CLC
                        ADC $FD
                        TAX
                        SEP #$20
                        NOP
                        LDA #$0C
                        STAL $E19D00,X
                        REP #$20
                        NOP
                        LDY $C3
                        LDX $FB
                        JSR LE3E4
LE989                   LDA $AD
                        STA $F7
                        LDA $AF
                        STA $F9
                        LDX $A9
                        STX $B1
                        LDY $AB
                        STY $B5
                        JSR SHGR_Offset_for_X_Y
                        STY $C1
                        JSR LEB2D
                        LDA $A5
                        STA $FB
                        LDA $A7
                        STA $FD
                        LDX $A1
                        STX $B3
                        LDY $A3
                        STY $B7
                        JSR SHGR_Offset_for_X_Y
                        STY $BF
                        JSR LEB4D
                        STY $C3
                        JSR Check_Key
                        BCS :done
                        LDA $9F
                        SEC
                        SBC #$000C
                        STA $9F
                        BCS LE953
                        JSR LE9DE
                        JSR LE9D1
:done                   RTS

LE9D1                   LDY #$0514
LE9D4                   LDX #$0320
LE9D7                   DEX
                        BNE LE9D7
                        DEY
                        BNE LE9D4
                        RTS

LE9DE                   LDA #$0045
                        PHA
                        LDA #$005C
                        CLC
                        ADC #$0012
                        PHA
LE9EA                   LDA $03,S
                        TAY
                        LDX #$0000
                        JSR SHGR_Offset_for_X_Y
                        LDX #$00A0
                        LDA #$0000
                        JSR Fill_Bank_E1_with_Byte
                        LDA $01,S
                        TAY
                        LDX #$0000
                        JSR SHGR_Offset_for_X_Y
                        LDX #$00A0
                        LDA #$0000
                        JSR Fill_Bank_E1_with_Byte
                        JSR Delay_YYY
                        JSR Check_Key
                        BCS LEA25
                        LDA $03,S
                        INC
                        STA $03,S
                        LDA $01,S
                        DEC
                        STA $01,S
                        CMP #$0059
                        BCS LE9EA
LEA25                   PLA
                        PLA
                        RTS

Delay_YYY               LDY #$0032
:outer                  LDX #$00C8
:inner                  DEX
                        BNE :inner
                        DEY
                        BNE :outer
                        RTS

LEA35                   LDY $C1
                        LDA $A9
                        SEC
                        SBC $B1
                        BCC LEA48
                        BEQ LEA48
                        TAX
                        LDA $F9
                        BEQ LEA48
                        JSR LE3B6
LEA48                   LDA $F7
                        SEC
                        SBC $AD
                        BCC LEA6A
                        SBC $A9
                        CLC
                        ADC $B1
                        BEQ LEA6A
                        BMI LEA6A
                        PHA
                        LDA $C1
                        CLC
                        ADC $F7
                        SEC
                        SBC $01,S
                        TAY
                        PLX
                        LDA $F9
                        BEQ LEA6A
                        JSR LE3B6
LEA6A                   LDY $BF
                        LDA $A1
                        SEC
                        SBC $B3
                        BCC LEA7D
                        BEQ LEA7D
                        TAX
                        LDA $FD
                        BEQ LEA7D
                        JSR LE3B6
LEA7D                   LDA $FB
                        SEC
                        SBC $A5
                        BCC LEA9E
                        SBC $A1
                        ADC $B3
                        BEQ LEA9E
                        BMI LEA9E
                        PHA
                        LDA $BF
                        CLC
LEA90                   ADC $FB
                        SEC
                        SBC $01,S
                        TAY
                        PLX
                        LDA $FD
                        BEQ LEA9E
                        JSR LE3B6
LEA9E                   RTS

LEA9F                   LDA #$008C
                        JSR LEB12
                        STA $AD
                        LDA #$0002
                        JSR LEB12
                        EOR #$FFFF
                        SEC
                        ADC #$0059
                        STA $AF
                        LDA #$0014
                        JSR LEB12
                        EOR #$FFFF
                        SEC
                        ADC #$0059
                        STA $AB
                        LDA $AF
                        SEC
                        SBC $AB
                        STA $AF
                        LDA #$0046
                        JSR LEB12
                        EOR #$FFFF
                        SEC
                        ADC #$0050
                        STA $A9
                        LDA #$001F
                        JSR LEB12
                        STA $A5
                        LDA #$0015
                        JSR LEB12
                        CLC
                        ADC #$0059
                        STA $A7
                        LDA #$0003
                        JSR LEB12
                        CLC
                        ADC #$0059
                        STA $A3
                        LDA $A7
                        SEC
                        SBC $A3
                        STA $A7
                        LDA #$0010
                        JSR LEB12
                        EOR #$FFFF
                        SEC
LEB0C                   ADC #$0050
                        STA $A1
                        RTS

LEB12                   SEP #$30
                        NOP
                        STY $C5
                        STA $C7
                        LDX #$08
                        TYA
LEB1C                   LSR $C7
                        BCC LEB22
                        ADC $C5
LEB22                   ROR
                        DEX
                        BNE LEB1C
                        REP #$30
                        NOP
                        AND #$00FF
                        RTS

LEB2D                   LDA $F7
                        STA Display_Width
                        BEQ :done
                        LDA $F9
                        STA Display_Height
                        BEQ :done
                        LDA #$008C
                        STA Image_Width
                        LDA #$0012
                        STA Image_Height
                        LDA #$2000
                        STA Image_Ptr
                        JSL $000203
:done                   RTS

LEB4D                   LDA $FB
                        STA Display_Width
                        BEQ LEB6C
                        LDA $FD
                        STA Display_Height
                        BEQ LEB6C
                        LDA #$001F
                        STA Image_Width
                        LDA #$0012
                        STA Image_Height
                        LDA #$29D8
                        STA Image_Ptr
                        JSL $000203
LEB6C                   RTS

LEB6D                   JSR Check_Key
                        BCS LEBB1
                        JSR Clear_Palette_12
                        LDX #$0082
                        LDY #$00C7
                        LDA #$000C
                        JSR Set_SCBs_to_Pal
                        JSR LED00
                        LDX #About_Hardware
                        LDY #$0082
                        LDA #$0011
                        JSR LE552
                        JSR LEC58
                        JSR Delay_Check_Key
                        BCS LEBB1
                        LDY #About_Hardware
                        LDX #$EEB7
                        JSR LEC06
                        BCS LEBB1
                        LDX #About_Layout
                        JSR LEBE9
                        BCS LEBB1
                        LDX #About_Firmware
                        JSR LEC06
LEBB1                   BCS LEBE5
                        LDX #About_Firmware
                        LDY #$0082
                        LDA #$0022
                        JSR LE552
LEBBF                   LDX #About_AE
                        LDY #$00A5
                        JSR LE57D
                        JSR LECA8
                        JSR Delay_Check_Key
                        BCS LEBE5
                        LDX #About_AE
                        LDY #$00A5
                        JSR LE57D
                        LDX #$0082
                        LDY #$00C7
                        LDA #$0000
                        JSR Set_SCBs_to_Pal
LEBE5                   JSR Clear_Palette_12
                        RTS

LEBE9                   PHX
                        PHY
                        LDY #$0082
                        LDA #$0011
                        JSR LE552
                        JSR LEC58
                        PLX
                        LDY #$0082
                        LDA #$0022
                        JSR LE552
                        JSR Delay_Check_Key
                        PLY
                        RTS

LEC06                   PHX
                        PHY
                        LDY #$0082
                        LDA #$0022
                        JSR LE552
                        JSR LEC80
                        PLX
                        LDY #$0082
                        LDA #$0011
                        JSR LE552
                        JSR Delay_Check_Key
                        PLY
                        RTS

Clear_Palette_12        LDX #16*2*12                ; #$0180 = palette 12
                        LDA #$0000
:clear_loop             STAL $E19E00,X
                        INX
                        INX
                        CPX #16*2*13                ; #$01A0 = palette 13
                        BCC :clear_loop
                        RTS

Delay_Check_Key         JSR Check_Key
                        BCS :done
                        LDA #$001E
:loop                   JSR Delay_XXX
                        PHA
                        JSR Check_Key
                        PLA
                        BCS :done
                        DEC
                        BNE :loop
:done                   RTS

* ~1sec delay @ 7MHz
Delay_XXX               LDX #$00FA                  ; 250
:outer                  LDY #$00C8                  ; 200
:inner                  DEY
                        BNE :inner
                        DEX
                        BNE :outer
                        RTS

LEC58                   LDA #$0FFF
                        STA $9B
                        LDA #$0000
                        STA $9D
:loop                   JSR Delay_XXX
                        LDA $9D
                        STAL $E19F82
                        CLC
                        ADC #$0111
                        STA $9D
                        LDA $9B
                        STAL $E19F84
                        SEC
                        SBC #$0111
                        STA $9B
                        BCS :loop
                        RTS

LEC80                   LDA #$0FFF
                        STA $9B
                        LDA #$0000
                        STA $9D
LEC8A                   JSR Delay_XXX
                        LDA $9D
                        STAL $E19F84
                        CLC
                        ADC #$0111
                        STA $9D
                        LDA $9B
                        STAL $E19F82
                        SEC
                        SBC #$0111
                        STA $9B
                        BCS LEC8A
                        RTS

LECA8                   LDA #$0000
                        STA $9B
                        LDA #$0000
                        STA $9D
LECB2                   JSR Delay_XXX
                        LDA $9D
                        LSR
                        STAL $E19F88
                        LDA $9D
                        CLC
                        ADC #$0001
                        STA $9D
                        LDA $9B
                        STAL $E19F8E
                        CLC
                        ADC #$0111
                        STA $9B
                        CMP #$1000
                        BCC LECB2
                        RTS

LECD6                   LDA #$000F
                        STA $9D
                        LDA #$0FFF
                        STA $9B
LECE0                   JSR Delay_XXX
                        LDA $9D
                        LSR
                        STAL $E19F88
                        LDA $9D
                        SEC
                        SBC #$0001
                        STA $9D
                        LDA $9B
                        STAL $E19F8E
                        SBC #$0111
                        STA $9B
                        BCS LECE0
                        RTS

LED00                   LDA #$0FFF
                        STAL $E19F86
                        RTS

LED08                   LDA #$0000
                        STAL $E19F86
                        RTS

*-----------

About_Hardware          HEX 6319020FC0890005040020001F840001
                        HEX E08200040E003FF0890005060060001F
                        HEX 840001E08200020E0082780138880005
                        HEX 0700E00007840001E08200030E007082
                        HEX 388800050781E00007840001E0820037
                        HEX 0E007001FF81F8700E0FC1DF0007C3E0
                        HEX FF8701F807E0EF807E0E0F7C01FF87FE
                        HEX 700E3FF1FFC007E7E3FF8707FE1FF8FF
                        HEX E1FF8E1E3FC038820F0B381C7879E1E0
                        HEX 07FFE78387820F823C38F0F3C3CE3C0F
                        HEX F0380E07381C7039C0E0077EE703870E
                        HEX 07381CE07381CE7800F8380FFF1C387F
                        HEX F9C0E0073CE703870FFF3800E073FFCF
                        HEX F0008238170FFF1C387FF9C0E00718E7
                        HEX 03870FFF3800E073FFCFF0708238030E
                        HEX 000E82701001C0E00700E703870E0038
                        HEX 1CE073800E83780C3C0F0706607839C0
                        HEX E00700E78287020F07823C31E073C1CE
                        HEX 3C3FF01F87FE07E03FF1C0E00700E3FF
                        HEX 9FC7FE1FF8E071FF8E1E0FC00F81FC03
                        HEX C00FE1C0E00700E0FB9FC1FC0782E004
                        HEX 707F0E0FFF0086000203308200016094
                        HEX 00020330820001609400090331F363EC
                        HEX 31F363C090000903F333866DB3338660
                        HEX 90000103823306066DB33307E0900001
                        HEX 0382330506666333069100090331F303
                        HEX E661F303C08800
About_LCA               HEX 4B1A02FF80870005380F070007850002
                        HEX FFE0870005381E070007850002E0F087
                        HEX 0002383C82000107850002E070870002
                        HEX 38788200010785002BE0707E01F707E0
                        HEX E3C038F03F01F70FC07E0EF8E071FF87
                        HEX FF1FF8EFC039E03F07FF1FE1FF8FFEE0
                        HEX F3C3CF0F823C05FC003FC007820F5D38
                        HEX 63C3CF0FFFE381CE07381CF8003FC007
                        HEX 0E07380381CE07FF8381CE073FFCF000
                        HEX 39E0070E071FC381CE07E3C381CE073F
                        HEX FCF00038F0070E070FE381CE07E1E381
                        HEX CF0F3800E0003878070E07007381CE07
                        HEX E0F3C3C7FF3C1CE000383C07820F2B30
                        HEX 73C3CE07E079FF81F71FF8E000381E3F
                        HEX E7FF3FE1FF8E07E0387E040E07F0E000
                        HEX 380F3FE1F71FC07E0E0783000207FC91
                        HEX 000203F8CB0002018082F0011F820001
                        HEX 0C8B00060181999819808D0001018281
                        HEX 0798198F0F1C3E7C8900010182810598
                        HEX 1999980C826689000101828105F8199F
                        HEX 8F0C826689000A018199981998018C3E
                        HEX 6689000501F8F1981F820F031E466691
                        HEX 00013C8600
About_Layout            HEX 501A0270388900031C71C08400047000
                        HEX 1C0E890003071C708400051C00070380
                        HEX 88000301C71C840005070001C0E08900
                        HEX 0271C784007101C00070383FE71E700E
                        HEX 0FC1C0E01C71C1F83BE01F707E1C0E3F
                        HEX F9DF9C038FFC7038071C71FF8FFE1FFC
                        HEX 7FE7FF9E0E7E0381C7879C0E01C71CF0
                        HEX F3C3CF0F3C3DFFE7039F00E071C0E703
                        HEX 8071C7381CE07381CE077039C0E7801C
                        HEX 387FF9C0E01C71CFFF381CE073FFDC0E
                        HEX 7039E0070E1FFE827825071C73FFCE07
                        HEX 381CFFF7039C0E7000E707000FFE01C7
                        HEX 1CE00381CE073801C0E7879C00198182
                        HEX E02FFB807BEF3C1CE073C3CF077038FF
                        HEX E70007E03FF000E00FDF87FE381C7FF1
                        HEX FF9C0E0FB9C000F003F8207001E3C07F
                        HEX 0E820703DC1FC08800020FF892000201
                        HEX FCCE0001C093000130840001188E0007
                        HEX 0C07CCC78CCF808D0082038333023180
                        HEX 8E0003C0CCDC82CC01608E000330331B
                        HEX 8233011B8E00070FC7C8C787C3808F00
                        HEX 0201E08A00
About_Firmware          HEX 4D1904003800078400013F8500010E85
                        HEX 0004038000708300020FFC850001E085
                        HEX 00033800078300010182E101C0830001
                        HEX 0E850004038000708300031C0E1C8400
                        HEX 01E0850036383F077C1DF001C00FFC1F
                        HEX 83BE0EF807E0EF80038FFC7FF1FFC01F
                        HEX 00FFC7FE3FF8FFE1FF8FFE0039E1E787
                        HEX 9E1E00FF01C0F0F3C3CF0F823C82F055
                        HEX 039C0E7039C0E003FC1C0E07381CE073
                        HEX 81CE070039C0E7039C0E0003E1C0FFF3
                        HEX 81CE073FFCE077039C0E7039C0E0000E
                        HEX 1C0FFF381CE073FFCE077039C0E7039C
                        HEX 0E01C0E1C0E00381CE073800E077879E
                        HEX 1E7039C0E0831E020F07823C26E073C1
                        HEX CE073FF0FFC7039C0E00FFC0FC7FE3FF
                        HEX 8E071FF8E071FE03F07039C0E003F007
                        HEX C1FC3B82E004707F0E078C0002038092
                        HEX 000138C6000301F18091000118920009
                        HEX 01838DBF9863E6C7808B00081E18E36D
                        HEX B66670CC8B000501818C36DB8266020F
                        HEX C08B00821806C36CCC6660C08B000901
                        HEX 83CC36CCC3E607808500831C89000203
                        HEX F09600013C84000260038200830C831E
                        HEX 0901E00001C18000C0F8820001C08300
                        HEX 01068200016685000603018019E63C83
                        HEX 33020330820001C0820082C089000C60
                        HEX 3C7C666CE1F3E3E01B360C8333050333
                        HEX E3E0C3828705C0C1F0F9C782C305C6CE
                        HEX 3E1F6083660970633331801B060C3382
                        HEX 1E010382330930C18CCCC0F19998C682
                        HEX 660267068233016082660A6E60633331
                        HEX 801B360C1F82331003F33330C18FCCC0
                        HEX C19998C667E7E606823383660A366061
                        HEX F331B019E60C038233010382330A30C1
                        HEX 8C0CC0C198F8C666830602331F823C07
                        HEX 7C4660F23330E0820C013F831E120333
                        HEX E3E1E3C787C0F99919E663C3C60F3323
                        HEX 820005603C0001E082000203F0850082
                        HEX 03870001F08600011EC2000403C00380
                        HEX 8200050603C001C08400010684001163
                        HEX C18606078C03000783C783C006600180
                        HEX 8200040C018003840001068400170186
                        HEX 6786618CCCCF000C04CC04C00603E183
                        HEX C3C018018782C7078DBF87CF8E1E3E82
                        HEX 031D00618660C0CCC3000F8CCF8CC003
                        HEX C661866600300186630CCE36CCC60682
                        HEX 330A000300C18660C18CC30F84CC11C0
                        HEX 00666187E3C0600186630CCC36CCC606
                        HEX 82330B0003018187E0C30FC3000C83CC
                        HEX 0FC0066661860060C00186630CCC36CC
                        HEX 82C68233010082030F018060C600C300
                        HEX 0CCC8CCC8003C3E382C31BC08003C663
                        HEX 078C36C7C38F1E33030187E7E0618FC0
                        HEX CFC0078F078F9500016082000106CD00
                        HEX 017E820003600030820002E00F88000D
                        HEX 63C18606078C03000783C78780820001
                        HEX 18820001608400036019808400101800
                        HEX 01866786618CCCCF000C04CC0CC08200
                        HEX 0118823C827C0B70F0F86018199F1F0F
                        HEX 1B3E82030D00618660C0CCC3000F8CCF
                        HEX 8CC082000118846606319998600F1983
                        HEX 990C9C18000300C18660C18CC30F84CC
                        HEX 01C0820003187E608266053181986001
                        HEX 84990D98180003018187E0C30FC3000C
                        HEX 82CC02C7C08200021860836605319998
                        HEX 6019849903981B0082030A018060C600
                        HEX C3000CCC8C82C082000118823C826604
                        HEX 78F0F8F0820F149F1F0F180E030187E7
                        HEX E0618FC0CFC0078F0787808D00821885
                        HEX 000160820001068900
About_AE                HEX 12168A00010787778B00017486440147
                        HEX 8A000107874402477789000174874482
                        HEX 47880001078344014785770147880001
                        HEX 74834401478544014787000107824402
                        HEX 47448247857787000174824402774482
                        HEX 478B0001078244824702444784778800
                        HEX 01748244027447854401478700010782
                        HEX 44034744478544024777860001748244
                        HEX 03744477854482478500010782440147
                        HEX 83770244478477014785000174874401
                        HEX 47844401478400010788448247847784
                        HEX 00017488448247870001078244014785
                        HEX 77024447857783000174824401748444
                        HEX 01478644014782000107824403474447
                        HEX 84778644044777007482440374447083
                        HEX 00010786448247010783770244478400
                        HEX 01078777014782000174824401708500
                        HEX 01078644034700078377860001078777

*-----------

CDA_Shutdown            RTL                         ; CDA

CDA_Startup             PHP
                        PHD
                        PHB
                        PEA $0000
                        PLD
                        PHK
                        PLB
                        SEP #$30
                        NOP
                        JSR NVRAM_Validate
                        REP #$30
                        NOP
LF6FD                   LDA #$0007
                        STA $5B
                        JSR Text_Init
                        LDX #$0001
                        LDY #$0017
                        JSR Text_Offset_For_X_Y
                        LDA #$004C
                        LDY #$0026
                        JSR Text_Repeat_Char_Horiz
                        LDX #$0000
                        LDY #$0001
                        JSR Text_Offset_For_X_Y
                        LDA #$005A
                        LDY #$0016
                        JSR Text_Repeat_Char_Vertical
                        LDX #$0027
                        LDY #$0001
                        JSR Text_Offset_For_X_Y
                        LDA #$005F
                        LDY #$0016
                        JSR Text_Repeat_Char_Vertical
LF73B                   JSR Text_Clear_Window_from_3
                        LDX #Menu_Options
                        SEC
                        JSR LA06E
                        JSR STROUT_SelectJK
LF748                   JSR STROUT_Open
                        JSR Display_Version_Info
LF74E                   JSR Set_No_Items_Selected
                        LDX #$0004
                        LDY #$0003
LF757                   JSR Text_Offset_For_X_Y
                        LDX #LF7E9
                        LDY $5B
                        JSR Display_Menu_Items
LF762                   JSR Menu_Input_Select
                        BCC LF762
                        CPY #$0000
                        BNE LF773
                        LDA #$0007
                        STA $5B
                        BRA LF74E
LF773                   CPY #$0007
                        BEQ LF78C
                        LDA $5B
                        PHA
                        JSR LF79C
                        PLA
                        STA $5B
                        SEP #$30
                        NOP
                        JSR Config_to_TW_MODE
                        REP #$30
                        NOP
                        BRA LF73B
LF78C                   SEP #$30
                        NOP
                        JSR NVRAM_Save
                        JSR Config_to_TW_MODE
                        REP #$30
                        NOP
                        PLB
                        PLD
                        PLP
                        RTL

LF79C                   CPY #$0001
                        BNE LF7AB
LF7A1                   LDX #LF856
                        JSR Display_Selected_Menu
                        JSR LA190
                        RTS

LF7AB                   CPY #$0002
                        BNE LF7BA
                        LDX #LF85E
                        JSR Display_Selected_Menu
                        JSR Configuration_Menu
                        RTS

LF7BA                   CPY #$0003
                        BNE LF7CA
                        LDX #LF86A
                        JSR Display_Selected_Menu
                        CLC
                        JSR LA318
                        RTS

LF7CA                   CPY #$0004
                        BNE LF7DA
                        LDX #LF87C
                        JSR Display_Selected_Menu
                        SEC
                        JSR LA318
                        RTS

LF7DA                   CPY #$0005
                        BNE LF7E8
                        LDX #LF893
                        JSR Display_Selected_Menu
                        JSR About_Transwarp_GS
LF7E8                   RTS

LF7E9                   STR "Speed"
                        BRK $00
LF7F1                   STR "Configure"
                        BRK $00
LF7FD                   STR "Quick Self-Test"
                        BRK $00
LF80F                   STR "Continuous Self-Test"
                        BRK $00
LF826                   STR "About TransWarp GS"
                        BRK $00
LF83B                   STR " "
                        BRK $00
LF83F                   STR "Quit"
                        DB  $00
                        DB  $00
                        DB  $00
Menu_Options            DW  $0000
                        STR "TransWarp GS"
LF856                   DW  $0002
                        STR "Speed"
LF85E                   DW  $0002
                        STR "Configure"
LF86A                   DW  $0002
                        STR "Quick Self-Test"
LF87C                   DW  $0002
                        STR "Continuous Self-Test"
LF893                   DW  $0002
                        STR "About TransWarp GS..."

Display_Selected_Menu   PHX
                        JSR Text_Clear_Window_from_3
                        LDX #Menu_Options
                        CLC
                        JSR LA06E
                        PLX
                        SEC
                        JSR LA06E
                        RTS

Display_Version_Info    LDX #$0007
                        LDY #$0011
                        JSR Text_Offset_For_X_Y
                        LDX #String_TW_Version
                        JSR Text_Out_Pascal_String
                        LDX #$000E
                        LDY #$0012
                        JSR Text_Offset_For_X_Y
                        LDX #String_TW_Revision
                        JSR Text_Out_Pascal_String
                        LDX #$0009
                        LDY #$0013
                        JSR Text_Offset_For_X_Y
                        LDX #String_TW_Copyright
                        JSR Text_Out_Pascal_String
                        LDX #$000A
                        LDY #$0014
                        JSR Text_Offset_For_X_Y
                        LDX #String_AE
                        JSR Text_Out_Pascal_String
                        RTS

String_TW_Version       STR "TransWarp GS version 8/32S"
String_TW_Revision      STR "Revision 1.8S"
String_TW_Copyright     STR "Copyright (c) 1989-1991"
String_AE               STR "Applied  Engineering"

                        MX  %10

LF94F                   REP #$10
                        NOP
                        LDX #$1770
LF955                   DEX
                        BEQ LF963
                        LDAL ADB_DATAREG            ; $E0C026
                        LDAL ADB_KMSTATUS           ; $E0C027
                        ROR
                        BCS LF955
LF963                   LDX #$1D4C
                        LDA #$07
                        STAL ADB_DATAREG            ; $E0C026
LF96C                   DEX
                        BEQ LF99B
                        LDAL ADB_DATAREG            ; $E0C026
                        LDAL ADB_KMSTATUS           ; $E0C027
                        ROR
LF978                   BCS LF96C
                        LDA #$0C
                        JSR LF99F
LF97F                   LDA #$32
                        JSR LF99F
                        LDA #$00
                        JSR LF99F
                        LDA #$00
                        JSR LF99F
                        LDA #$FF
                        SEC
LF991                   PHA
LF992                   SBC #$01
                        BNE LF992
                        PLA
                        SBC #$01
                        BNE LF991
LF99B                   SEP #$10
                        NOP
                        RTS

LF99F                   REP #$10
                        NOP
                        STAL ADB_DATAREG            ; $E0C026
                        LDX #$1D4C
LF9A9                   DEX
                        BEQ LF9B3
                        LDAL ADB_KMSTATUS           ; $E0C027
                        LSR
                        BCS LF9A9
LF9B3                   SEP #$10
                        NOP
                        RTS

LF9B7                   REP #$10
                        NOP
                        LDX #$1D4C
                        SEC
LF9BE                   DEX
                        BEQ LF9CE
                        LDAL ADB_KMSTATUS           ; $E0C027
                        AND #$20
                        BEQ LF9BE
                        CLC
                        LDAL ADB_DATAREG            ; $E0C026
LF9CE                   SEP #$10
                        NOP
                        RTS

LF9D2                   LDAL ADB_KMSTATUS           ; $E0C027
                        PHA
                        LDA #$00
                        STAL ADB_KMSTATUS           ; $E0C027
                        JSR LF94F
                        LDA #$09
                        JSR LF99F
                        BCS LFA01
                        LDA #$51
                        JSR LF99F
                        BCS LFA01
                        LDA #$00
                        JSR LF99F
                        BCS LFA01
                        JSR LF9B7
                        BCS LFA01
                        CMP #$A5
                        BEQ LFA01
                        SEC
                        BRA LFA02
LFA01                   CLC
LFA02                   PLA
                        STAL ADB_KMSTATUS           ; $E0C027
                        RTS

LFA08                   LDAL ADB_KMSTATUS           ; $E0C027
                        PHA
                        LDA #$00
                        STAL ADB_KMSTATUS           ; $E0C027
                        JSR LF94F
                        LDA #$08
                        JSR LF99F
                        BCS LFA29
                        LDA #$51
                        JSR LF99F
                        BCS LFA29
                        LDA #$00
                        JSR LF99F
LFA29                   PLA
                        STAL ADB_KMSTATUS           ; $E0C027
                        RTS

LFA2F                   REP #$20
                        NOP
                        PHB
                        PHA
                        PHA
                        LDA $06,S
                        STA $03,S
LFA39                   LDA $08,S
                        STA $05,S
                        LDA #>LFA5D-1               ; #$BCFA
                        STA $08,S
                        LDA #LFA5D-1
                        STA $07,S
                        LDAL LFB24
                        LDAL LFB24+2
                        LDAL LFFEA
                        LDAL LFFEA+2
                        PLA
                        RTI

LFA59                   JMPL LFA59

LFA5D                   PHP
                        REP #$30
                        NOP
                        PHA
                        PHX
                        PHY
                        PHB
                        LDX #$0000
                        LDY #$9F00
                        LDA #$00FF
                        MVN $000000,$E10000
                        PLB
                        JSR LFA88
                        PHB
                        LDX #$9F00
                        LDY #$0000
                        LDA #$00FF
                        MVN $E10000,$000000
                        PLB
                        PLY
                        PLX
                        PLA
                        PLP
                        RTL

LFA88                   PEA ^CDA_Ptr32              ; $00BC
                        PEA CDA_Ptr32
                        _InstallCDA
                        RTS

CDA_Ptr32               ADRL CDA_Install_Hdr

                        MX  %11

LFA9A                   LDX #$FF
                        TXS
                        CLC
                        XCE
                        JSR LF94F
                        LDAL $E0C062
                        BMI LFB07
                        JSR FPGA_Init_Readback
                        BCC LFAB0
                        JSR FPGA_Check_Readback
LFAB0                   LDA #$00
                        STAL SLTROMSEL              ; $E0C02D
                        LDAL $E0C0C8
LFABA                   LDAL $E0C0D8
                        LDAL $E0C0E8
                        LDAL $E0C0F8
LFAC6                   JSR NVRAM_Active_Check
                        BCC LFAF7
                        LDAL $E0C062
                        BMI LFB07
                        REP #$10
                        NOP
                        JSR Clear_Text_Pages_E0_E1
                        SEP #$10
                        NOP
                        JSR L9757
LFADD                   JSR LFA08
                        JSR NVRAM_Validate
                        JSR Play_Startup_Intro
                        REP #$30
                        NOP
                        JSR Time_Active_Screen
LFAEC                   JSR LA8CB
                        LDA $00
                        JSR NVRAM_Write_Speed
                        SEP #$30
                        NOP
LFAF7                   REP #$30
                        NOP
                        JSL FlushCache_L
LFAFE                   SEP #$30
                        NOP
                        JSR CONFIG_TW_From_NVRAM
                        JSR ENABLE_DATA_CACHE
LFB07                   SEC
                        XCE
                        LDA #$00
                        PHA
; LDAL LFFFC	; suspicious1
                        ldal $00FFFC
                        CMP #$01
; LDAL LFFFC+1	; suspicious2
                        ldal $00FFFD
                        SBC #$00
                        PHA
; LDAL LFFFC
                        ldal $00FFFC
                        DEC
                        PHA
                        RTL

LFB20                   JMPL LFA9A
LFB24                   JMPL LFA2F

                        MX  %00
GetTWInfo_L             LDA #$0000
                        LDX #$0108
                        RTL

ResetTW_L               JSR CONFIG_TW_From_NVRAM
                        JSR ENABLE_DATA_CACHE
                        RTL

LFB36                   RTL

GetMaxSpeed_L           JSR NVRAM_Read_Speed
                        RTL

GetNumISpeed_L          LDX #$0003                  ; I believe the 3 is a speed setting (GB has GetNumISpeed)
                        RTL

Index2Freq_L            LDA #$0000
                        CPX #$0003
                        BCS :exit
                        CPX #$0002
                        BCC :get_from_table
                        PHX
                        JSR NVRAM_Read_Speed
                        PLX
                        RTL

:get_from_table         PHX
                        TXA
                        ASL
                        TAX
                        LDAL _frequencyTable,X
                        PLX
:exit                   RTL

_frequencyTable         DW  $0400                   ; 1.024
                        DW  $0A28                   ; 2.600
                        DW  $1B58                   ; 7.000

Freq2Index_L            PHA
                        LDX #$0000
:loop                   JSL Index2Freq_L
                        CMP $01,S
                        BCS :found_it
                        INX
                        CPX #$0003
                        BCC :loop
                        DEX
:found_it               JSL Index2Freq_L
                        SEC
                        SBC $01,S
                        STA $01,S
                        PLA
                        RTL

SetCurISpeed_L          SEP #$20
                        NOP
                        CPX #$0000
                        BEQ :gs_1mhz
                        JSR GS_FAST
                        CPX #$0001
                        BEQ :no_accel
:accel                  JSR TWGS_ON
                        BRA :done
:no_accel               JSR TWGS_OFF
                        BRA :done
:gs_1mhz                JSR GS_1MHZ
                        JSR TWGS_OFF
:done                   REP #$20
                        NOP
                        RTL

GetCurISpeed_L          SEP #$20
                        NOP
                        LDAL CYAREG
                        BPL :off
                        LDAL TWGS_Config
                        AND #$04
                        BEQ :zero
                        LDX #$0002
                        BRA :done
:zero                   LDX #$0001
                        BRA :done
:off                    LDX #$0000
:done                   REP #$20
                        NOP
                        RTL

GetCurSpeed_L           JSL GetCurISpeed_L          ; in X
                        JSL Index2Freq_L            ; in M
                        RTL

LFBCF                   JSR Time_Active_Screen
                        JSR LA8CB
                        LDA $00
                        RTL

SetCurSpeed_L           JSL Freq2Index_L
                        PHA
                        JSL SetCurISpeed_L
                        PLA
                        RTL

FlushCache_L            PHB
                        JSR Check_Cache_Size
                        DEC
                        LDX #$8000
                        LDY #$8000
                        MVN TWGS_Config,TWGS_Config
                        PLB
                        RTL

DisableIRQLogic_L       JSR DISABLE_IRQ_LOGIC
                        RTL

EnableIRQLogic_L        JSR ENABLE_IRQ_LOGIC
                        RTL

EnableDataCache_L       JSR ENABLE_DATA_CACHE
                        RTL

DisableDataCache_L      JSR DISABLE_DATA_CACHE
                        RTL

GetTWConfig_L           JSR GET_TW_CONFIG
                        RTL

SetTWConfig_L           JSR SET_TW_CONFIG_KEEP_CACHE
                        RTL

GetCacheSize_L          JSR Check_Cache_Size
                        LDX #$000A
LFC11                   LSR
                        DEX
                        BNE LFC11
                        RTL

Filler                  DS  $EA

                        DS  $100
                        DS  $100

* These are specific address locations as provided in the TWGS Progammer's Reference.
* They MUST exist at these locations in the ROM:
* http://www.apple-iigs.info/doc/fichiers/AE%20TransWarp%20GS%20Programmer%20Reference.pdf
*  "The TransWarp GS Firmware has a jump table located at
*   $BCFFOO that can be used to identify and configure the
*   TransWarp GS hardware from within an application"
TransWarpID             ASC 'TWGS'                  ; $BC/FF00 - $BC/FF03
TransWarpID2            ASC 'SMJS'                  ; $BC/FF04 - $BC/FF07

* Firmware Routines - Call in full native mode (e=0, m=0, x=0) via JSL
GetTWInfo               JMPL GetTWInfo_L            ; $BC/FF08 - $BC/FF0B
ResetTW                 JMPL ResetTW_L              ; $BC/FF0C - $BC/FF0F
GetMaxSpeed             JMPL GetMaxSpeed_L          ; $BC/FF10 - $BC/FF13
GetNumISpeed            JMPL GetNumISpeed_L         ; $BC/FF14 - $BC/FF17
Freq2Index              JMPL Freq2Index_L           ; $BC/FF18 - $BC/FF1B
Index2Freq              JMPL Index2Freq_L           ; $BC/FF1C - $BC/FF1F
GetCurSpeed             JMPL GetCurSpeed_L          ; $BC/FF20 - $BC/FF23
SetCurSpeed             JMPL SetCurSpeed_L          ; $BC/FF24 - $BC/FF27
GetCurISpeed            JMPL GetCurISpeed_L         ; $BC/FF28 - $BC/FF2B
SetCurISpeed            JMPL SetCurISpeed_L         ; $BC/FF2C - $BC/FF2F
FlushCache              JMPL FlushCache_L           ; $BC/FF30 - $BC/FF33
DisableIRQLogic         JMPL DisableIRQLogic_L      ; $BC/FF34 - $BC/FF37
EnableIRQLogic          JMPL EnableIRQLogic_L       ; $BC/FF38 - $BC/FF3B
GetTWConfig             JMPL GetTWConfig_L          ; $BC/FF3C - $BC/FF3F
SetTWConfig             JMPL SetTWConfig_L          ; $BC/FF40 - $BC/FF43
GetCacheSize            JMPL GetCacheSize_L         ; $BC/FF44 - $BC/FF47
EnableDataCache         JMPL EnableDataCache_L      ; $BC/FF48 - $BC/FF4B
DisableDataCache        JMPL DisableDataCache_L     ; $BC/FF4C - $BC/FF4F
                        JMPL Run_Diagnostic_Tests
                        JMPL TWGS_Failed
                        JMPL LFBCF

Filler2                 ds  142                     ; hand adjust as I cent get ds working with math/pointers
LFFEA                   DA  LFB24                   ; NMI Vector
                        DA  LFA59
LFFEE                   DA  LFA59
                        DA  LFA59
                        DA  LFA59
                        DA  LFA59
                        DA  LFA59
                        DA  LFA59
                        DA  LFA59
LFFFC                   DA  LFB20                   ; Reset Vector
LFFFE                   DA  LFA59
















