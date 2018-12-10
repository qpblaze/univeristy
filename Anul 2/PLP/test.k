module TEST-SYNTAX
  syntax AExp ::= Int // builtin
                | Id  // builtin
                | String
                | AExp "+" AExp [left, strict]
                | AExp "-" AExp [left]
                
  syntax Stmt ::= "int" Ids ";"
                | "print" "(" AExp ")" ";" [strict]
                |Id "=" Sfunc ";" [strict(2)]
                |Id "=" Func ";" [strict(2)]
                
                > Stmt Stmt [right]
 syntax Func ::= AExp
            |Id".inc()"
            |Id".dec()"
syntax Ids ::= List{Id, ","}
syntax Sfunc ::= List{Func,"/"}

endmodule

module TEST
  imports TEST-SYNTAX

  syntax KResult ::= Int 

  configuration <k> $PGM:Stmt </k>
                <env> .Map </env>
                <out stream="stdout"> .List </out>

rule I1:Int + I2:Int => I1 +Int I2
rule I1:Int - I2:Int => I1 -Int I2

 rule S1:Stmt S2:Stmt => S1 ~> S2
rule <k> int (X, Xs => Xs) ; S </k>
       <env> Rho:Map (. => (X |-> 0)) </env> 
       requires notBool(X in keys(Rho))
rule (int .Ids ; S) => S

 rule <k> (X = V:Int ; => .) ...</k>
       <env>... X |-> (_ => V) ...</env>

rule <k> (X => V) ...</k>
 <env>... X |-> V:Int ...</env>


rule <k> X:Id.inc() => I +Int 1 ...</k>
     <env>... X |-> (I => I +Int 1) ...</env>

  rule <k> X:Id.dec() => I -Int 1 ...</k>
 <env>... X |-> (I => I -Int 1) ...</env>   

 rule <k> (print(V:Int); => .) ...</k>
       <out>... (.List => ListItem(V)) </out>
       
endmodule