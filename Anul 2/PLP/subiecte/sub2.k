module SUB2-SYNTAX
    syntax AExp ::= Int 
        | Id

    syntax Stmt ::= "int" Id ";"
        | Id "=" AExp ";" [strict(2)]
        > Stmt Stmt [right]

endmodule

module SUB2
    imports SUB2-SYNTAX

    syntax KResult ::= Int 

    configuration <k> $PGM:Stmt </k>

    // Sequences
    rule S1:Stmt S2:Stmt => S1 ~> S2

    // Declaration
    rule <k> int (X, Xs => Xs) ; S </k>
    <env> Rho:Map (. => (X |-> 0)) </env> requires notBool(X in keys(Rho))

endmodule