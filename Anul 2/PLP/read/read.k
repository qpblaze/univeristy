module READ-SYNTAX
    syntax Operator ::= "MUL"
        | "PRINT"
        | "READ"

    syntax Iterator ::= Operator
        > Operator Iterator [right]
 
endmodule

module READ
    imports READ-SYNTAX

    configuration <T> 
        <k> $PGM:Iterator </k>
        <stack> .List </stack>
        <in stream="stdin"> .List </in>
        <out stream="stdout"> .List </out> 
    </T>

    // Sequences
    rule S1:Operator S2:Iterator => S1 ~> S2

    // READ
    rule <k> (READ => .) ... </k>
        <stack> .List => ListItem(V) ... </stack>
        <in> (ListItem(V:Int) => .List) ... </in>

    // PRINT 
    rule <k> (PRINT => .) ... </k>
        <stack> .(ListItem(V) => .List) ... </stack>
        <out>... (.List => ListItem(V) ListItem("\n")) </out>

    // MUL
    rule <k> (MUL => .) ... </k>
        <stack> (ListItem(V:Int) ListItem(U:Int)) => ListItem (V *Int U) ... </stack>
endmodule
