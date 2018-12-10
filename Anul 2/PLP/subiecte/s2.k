module SUB2-SYNTAX
    syntax AExp ::= Int
                | Id

    syntax Stmt ::=
                "int" Id ";"
                | "print" "(" AExp ")" ";" [strict]
                | Id "=" AExp ";"  [strict(2)]
                > Stmt Stmt [right]
endmodule

module SUB2
    imports SUB2-SYNTAX

    syntax KResult ::= Int

    configuration <k> $PGM:Stmt </k>
                <env> .Map </env>
                <store> .Map </store>
                <stack> .List </stack>
                <out stream="stdout"> .List </out>

    // Sequences
    rule S1:Stmt S2:Stmt => S1 ~> S2
    
    // Declaration
    rule <k> int (X, Xs => Xs) ; S </k>
       <env> Rho:Map (. => (X |-> 0)) </env> 
       requires notBool(X in keys(Rho))

    // rule <k> (X:Id <- V:Int ; => .)  ...</k>
    //     <env>... X |-> L:Int  ...</env>
    //     <store>... L |-> (_ => V) ...</store>
    
    // rule <k> (X:Id => V) ...</k>
    //     <env>... X |-> L:Int ...</env>
    //     <store>... L |-> V:Int ...</store>
        
    // syntax KItem ::= "restoreEnv"
    // rule <k> begin S:Stmt end => S ~> restoreEnv ...</k>
    //    <env> Env </env>
    //    <stack> (.List => ListItem(Env)) ...</stack>
    // rule <k> (restoreEnv => .) ...</k>
    //    <env> _ => Env:Map </env>
    //    <stack> (ListItem(Env) => .List) ...</stack>

    // Print
    rule <k> (print (V:AExp); => .) ...</k>
       <out>... (.List => ListItem(V)) </out>
endmodule