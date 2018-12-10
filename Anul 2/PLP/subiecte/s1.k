module S1-SYNTAX
    syntax AExp ::= Int // builtin
                | Id  // builtin


    syntax Block ::= "begin" Stmt "end"
                 | "begin" "end"

    syntax Stmt ::= Block
                | "var" Id ";"
                | "print" AExp "," [strict]
                | Id "<-" AExp ";"  [strict(2)]
                > Stmt Stmt [right]
endmodule

module S1
    imports S1-SYNTAX

    syntax KResult ::= Int

    configuration <k> $PGM:Stmt </k>
                <env> .Map </env>
                <store> .Map </store>
                <stack> .List </stack>
                <out stream="stdout"> .List </out>

    rule S1:Stmt S2:Stmt => S1 ~> S2
    
    rule <k> var X:Id ; => . ...</k>
       <env> M:Map => M[X <- !L:Int] </env>
       <store> M':Map (.Map => !L |-> 0) </store>

    rule <k> (X:Id <- V:Int ; => .)  ...</k>
        <env>... X |-> L:Int  ...</env>
        <store>... L |-> (_ => V) ...</store>
    
    rule <k> (X:Id => V) ...</k>
        <env>... X |-> L:Int ...</env>
        <store>... L |-> V:Int ...</store>
        
    syntax KItem ::= "restoreEnv"
    rule <k> begin S:Stmt end => S ~> restoreEnv ...</k>
       <env> Env </env>
       <stack> (.List => ListItem(Env)) ...</stack>
    rule <k> (restoreEnv => .) ...</k>
       <env> _ => Env:Map </env>
       <stack> (ListItem(Env) => .List) ...</stack>

    rule <k> (print V:AExp , => .) ...</k>
       <out>... (.List => ListItem(V)) </out>
endmodule