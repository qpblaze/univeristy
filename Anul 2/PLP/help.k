module IMP-SYNTAX
  syntax AExp ::= Int // builtin
                | Id  // builtin
                | String // builtin
                | "read" "(" ")"
                | "++" Id
                > left:
                  AExp "*" AExp [left]
                | AExp "/" AExp [left]
                > left:
                  AExp "+" AExp [left, strict]
                | AExp "-" AExp [left]
                | "(" AExp ")"  [bracket]

  syntax BExp ::= Bool // builtin
                | "!" BExp
                | BExp "&&" BExp [non-assoc]
                | AExp "<=" AExp [strict]
                | AExp "<"  AExp
                
                | "(" BExp ")" [bracket]

  syntax Block ::= "{" Stmt "}"
                 | "{" "}"

  syntax Stmt ::= Block
                | "int" Id ";"
                | "print" "(" AExp ")" ";" [strict]
                |Id "=" AExp ";"  [strict(2)]
                | "if" BExp Block "else" Block [strict(1)]
                | "while" BExp Block
              //|BExp "?" Block ":" Block ";" [strict(1)] 
                > Stmt Stmt [right]
/*  syntax Pgm ::= "int" Ids ";" Stmt
               | Pgm
  syntax Ids ::= List{Id, ","}*/
endmodule

module IMP
  imports IMP-SYNTAX

  syntax KResult ::= Bool | Int | String

  configuration <k> $PGM:Stmt </k>
                <env> .Map </env>
                <store> .Map </store>
                <stack> .List </stack>
                <in stream="stdin"> .List </in>
                <out stream="stdout"> .List </out>

  rule I1:Int <= I2:Int => I1 <=Int I2
  rule I1:Int + I2:Int => I1 +Int I2
   rule S1:Int / S2:Int => S1 /Int S2 when S2 =/=Int 0
//Sequences
  rule S1:Stmt S2:Stmt => S1 ~> S2
// var declarations  DACA NU AI BLOCURI, ENVIRONMENT SI CHESTII DIN ASTEA NECURATE
  /* rule <k> int (X, Xs => Xs) ; S </k>
       <env> Rho:Map (. => (X |-> 0)) </env> requires notBool(X in keys(Rho))
  rule (int .Ids ; S) => S */

// var declarations DACA AI BLOCURI, ENVIRONMENT SI CHESTII DIN ASTEA NECURATE
  rule <k> int X:Id ; => . ...</k>
       <env> M:Map => M[X <- !L:Int] </env>
       <store> M':Map (.Map => !L |-> 0) </store>


// Assignment
  /* rule <k> (X = V:Int ; => .) ...</k>
       <env>... X |-> (_ => V) ...</env>*/
   rule <k> (X:Id = V:Int ; => .)  ...</k>
        <env>... X |-> L:Int  ...</env>
        <store>... L |-> (_ => V) ...</store>
 
 // Lookup
        /*  rule <k> (X => V) ...</k>
       <env>... X |-> V:Int ...</env>*/

   rule <k> (X:Id => V) ...</k>
        <env>... X |-> L:Int ...</env>
        <store>... L |-> V:Int ...</store>
// if  sau rule if (true)  S else _ => S    rule if (false) _ else S => S
  rule if true  B1:Block else B2:Block => B1 
  rule if false B1:Block else B2:Block => B2 
//RestoreLaEnvironment
  syntax KItem ::= "restoreEnv"
  rule <k> { S:Stmt } => S ~> restoreEnv ...</k>
       <env> Env </env>
       <stack> (.List => ListItem(Env)) ...</stack>

  rule <k> (restoreEnv => .) ...</k>
       <env> _ => Env:Map </env>
       <stack> (ListItem(Env) => .List) ...</stack>
// Blocks
// rule { S:Stmt } => S
rule { } => .

//while roolup
  rule while B:BExp { S:Stmt } =>
       if B { S while B { S } } else { }

  // increment
  rule <k> ( ++ X:Id => V +Int 1) ...</k>
       <env>... X |-> L ...</env>
       <store>... (L:Int |-> (V:Int=> V +Int 1)) ...</store>

 rule <k> (  X:Id ++ => V +Int 1) ...</k>
       <env>... X |-> L ...</env>
       <store>... (L:Int |-> (V:Int=> V +Int 1)) ...</store>

  // read
  rule <k> (read() => V) ...</k>
       <in> (ListItem(V:Int) => .List) ...</in>

  // print
  syntax Printable ::= Int | String 
  syntax AExp ::= Printable
  rule <k> (print(V:Printable); => .) ...</k>
       <out>... (.List => ListItem(V)) </out>

 //if(a>b){a}:{b} "if" "("Bexp")" Block ":" Block 
// ifswitch
  /*   rule true ? B1:Block : B2:Block ;=> B1
		rule false ? B1:Block : B2:Block ;=> B2*/

endmodule
