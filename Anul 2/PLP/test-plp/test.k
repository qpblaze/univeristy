module TEST-SYNTAX
    syntax AExp ::= Int
                | Id 
                | String
                
    syntax BExp ::= Bool
        | AExp "==" AExp [strict]
        | "(" BExp ")"   [bracket]

     syntax Block ::= "{" Stmt "}"
                 | "{" "}"

    syntax Stmt ::= Block 
                | "int" Ids ";"
                | "print" "(" AExp ")" ";" [strict]
                | "if" "(" BExp ")" Stmt "else" Stmt    [strict(1)]
                | "fork" "(" ")" ";"
                | "getPid" "(" ")"
                | Id "=" AExp ";" [strict(2)]
                > Stmt Stmt [right]

    syntax Ids ::= List{Id, ","}

endmodule

module TEST
  imports TEST-SYNTAX

  configuration 
                <threads>
                    <thread multiplicity="*">
                      <k> $PGM:Stmt </k>
                      <env> .Map </env>
                      <stack> .List </stack>
                    </thread>
                  </threads>
                <store> .Map </store>
                <out stream="stdout"> .List </out>

    syntax KResult ::= Bool | Int | String

  rule I1:Int == I2:Int => I1 ==Int I2
//Sequences
  rule S1:Stmt S2:Stmt => S1 ~> S2

    // var dec
  rule <k> int (X, Xs => Xs) ; S </k>
       <env> Rho:Map (. => (X |-> 0)) </env> 
       requires notBool(X in keys(Rho))
rule (int .Ids ; S) => S

 </thread>
 // Lookup
 rule <k>(X:Id = V:Int ; => .)...</k>
          <env>...X |-> L:Int...</env>
          <store>...L|->(_=>V)...</store>

     rule <k>(X:Id=>V:Int)...</k></thread>
          <env>...X |-> L:Int...</env>
          <store>...L |-> V...</store>


// if  sau rule if (true)  S else _ => S    rule if (false) _ else S => S
  rule if (true)  B1:Block else B2:Block => B1 
  rule if (false) B1:Block else B2:Block => B2 

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

 // fork
  rule <k> (fork(); S => .) ...</k> <env> Rho </env>
       (.Bag => <thread>...
                  <k> S </k>
                  <env> Rho </env></thread>
                ...</thread>)
  // print

       rule <k> (print (V:AExp); => .) ...</k>
       <out>... (.List => ListItem(V)) </out>
    
    // thread termination
  rule (<thread> <k> . </k> ...</thread> => .Bag)

endmodule