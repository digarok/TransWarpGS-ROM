_NewHandle      MAC
                Tool      $902
                <<<
_DisposeHandle  MAC
                Tool      $1002
                <<<
_PtrToHand      MAC
                Tool      $2802
                <<<
_HandToPtr      MAC
                Tool      $2902
                <<<
_WriteBParam    MAC
                Tool      $B03
                <<<
_ReadBParam     MAC
                Tool      $C03
                <<<
Tool            MAC
                LDX       #]1
                JSL       $E10000
                <<<


_InstallCDA     MAC
                Tool      $F05
                <<<

PushLong        MAC
                IF        #=]1
                PushWord  #^]1
                ELSE
                PushWord  ]1+2
                FIN
                PushWord  ]1
                <<<

PushWord        MAC
                IF        #=]1
                PEA       ]1
                ELSE
                IF        MX/2
                LDA       ]1+1
                PHA
                FIN
                LDA       ]1
                PHA
                FIN
                <<<

