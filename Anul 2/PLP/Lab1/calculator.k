module CALCULATOR-SYNTAX
  syntax Expressions ::= Int
                       | "(" Expressions ")" [brackets]
                       | Expressions "*" Expressions [left, strict]
                       | Expressions "/" Expressions [left, strict]
                       > Expressions "+" Expressions [left, strict]
                       > Expressions "-" Expressions [left, strict]

endmodule

module CALCULATOR
  imports CALCULATOR-SYNTAX
  syntax KResult ::= Int
  configuration <k> $PGM:Expressions </k>
  rule I1:Int + I2:Int => I1 +Int I2
  rule I1:Int - I2:Int => I1 -Int I2
  rule I1:Int * I2:Int => I1 *Int I2
  rule I1:Int / I2:Int => I1 /Int I2
endmodule