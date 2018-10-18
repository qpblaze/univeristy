// SYNTAX module
module CALCULATOR-SYNTAX
//Expressions can be integers or can be built using the *constructor + from other Expressions.*
syntax Expressions ::= Int
					| "(" Expressions ")"	[bracket]
					| Expressions "*" Expressions [left, strict]
					| Expressions "/" Expressions [left, strict]
					> Expressions "+" Expressions [left, strict]
					//  The LEFT attribute enables left associativity for our expressions and 1+2+4 will be actually understood as (1+2)+4.
					| Expressions "-" Expressions [left, strict]
					
endmodule

// SEMANTICS module
module CALCULATOR
	imports CALCULATOR-SYNTAX
	syntax KResult ::= Int
	//In K we need a place to put computations, and that place is called configuration.
	//The configuration is constructed using cells, and everything we want to compute is included in a cell.
	//For our simple example, the configuration has a single cell called <k> $PGM:Expressions </k> and this cell will contain our programs, that is, our Expressions that we defined in the syntax.
	configuration <k> $PGM:Expressions </k>
	rule I1:Int + I2:Int => I1 +Int I2
	rule I1:Int - I2:Int => I1 -Int I2
	rule I1:Int * I2:Int => I1 *Int I2
	rule I1:Int / I2:Int => I1 /Int I2
endmodule

