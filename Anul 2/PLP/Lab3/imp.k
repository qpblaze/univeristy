module IMP-SYNTAX
    syntax AExp ::= 
        Int 
        | Id
        > left:
        AExp "*" AExp [left, klabel(mult)]
        | AExp "/" AExp [left, klabel(div)]
        > left:
        AExp "+" AExp [left, klabel(plus)]
        | AExp "-" AExp [left, klabel(minus)]
        | "(" AExp ")"  [bracket]

    syntax BExp ::= 
        Bool
        | "!" BExp
        | BExp "&&" BExp [non-assoc]
        | AExp "<=" AExp
        | AExp "<" AExp
        | AExp ">"  AExp
        | AExp ">=" AExp
        | AExp "==" AExp
        | BExp "and" BExp [non-assoc]
        | BExp "or" BExp [non-assoc]
        | "(" BExp ")" [bracket]

    syntax Block ::= 
        "{" Stmt "}"
        | "{" "}"

    syntax Stmt ::= 
        Id "=" AExp ";"
        | Id "=" AExp
        | "if" BExp "then" Stmt
        | "while" BExp "do" Stmt
        | "while" BExp "do" Block
        | Block
        | Class
        | Function
        > Stmt Stmt [right]

    syntax FunctionCall ::=
        Id "(" ")"
        | Id "(" Param ")"

    syntax Param ::=
        Int
        | Id
        | AExp ", " Param

    syntax Function ::=
        FunctionCall Block

    syntax Class ::=
        "class" Id Block
endmodule

module IMP
  imports IMP-SYNTAX
  
  configuration <k> $PGM:Stmt </k>
endmodule