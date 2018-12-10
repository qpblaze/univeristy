// module IMP-SYNTAX

//   syntax AExp ::= Int | Id
//                 | AExp "/" AExp [left]
//                 > left:
// 					AExp "+" AExp [left, strict]
//                 | "(" AExp ")"  [bracket]

//   syntax BExp ::= Bool
//                 | "!" BExp [strict]
//                 | AExp "<=" AExp [strict]
// 				| AExp "<"  AExp
//                 | "(" BExp ")"   [bracket]


//   syntax Block ::= "{" "}"
//                  | "{" Stmt "}"

//   syntax Stmt ::= Block
// 				| "int" Ids ";"
//                 | Id "=" AExp ";" [strict(2)]
//                 | "if" "(" BExp ")" Block "else" Block [strict(1)]
//                 | "while" "(" BExp ")" Block [strict(1)]
//                 > Stmt Stmt [right]

//   syntax Ids ::= List{ Id, "," }
// endmodule

// module IMP
// 	imports IMP-SYNTAX

// 	configuration <T>
// 			<k> $PGM:Stmt </k>
// 			<state> .Map </state>
// 		</T>

// 	syntax KResult ::= Int | Bool
// //	rule int .Ids ; => .
// 	// Assignment
// 	rule <k> int (X, Xs => Xs) ; S </k>
// 		<state> Rho:Map (.Map => X |-> 0) </state> 
// 		when notBool(X in keys(Rho))
// 	//rule int .Ids ; S => S

// 	// Sequence
// 	rule S1:Stmt S2:Stmt => S1 ~> S2

// 	// Sum
// 	rule I1:Int + I2:Int => I1 +Int I2

// 	// Comparation
// 	rule I1:Int <= I2:Int => I1 <=Int I2

// 	// If - else
// 	rule if (true)  B1:Block else B2:Block => B1 
//   	rule if (false) B1:Block else B2:Block => B2 
// endmodule

module IMP-SYNTAX

  syntax AExp ::= Int | Id
                | AExp "/" AExp [left]
                > AExp "+" AExp [left]
                | "(" AExp ")"  [bracket]

  syntax BExp ::= Bool
                | "!" BExp 
                | AExp "<=" AExp [strict]
                | "(" BExp ")"   [bracket]


  syntax Block ::= "{" "}"
                 | "{" Stmt "}"

  syntax Stmt ::= Block
				| "int" Ids ";"
                | Id "=" AExp ";" [strict(2)]
                | "if" "(" BExp ")" Block "else" Block [strict(1)]
                | "while" "(" BExp ")" Block
                > Stmt Stmt [right]

  syntax Ids ::= List{Id, ","}
endmodule

module IMP
	imports IMP-SYNTAX

	configuration <T>
			<k> $PGM:Stmt </k>
			<state> .Map </state>
		</T>

	syntax KResult ::= Int | Bool

	// Sequence
	rule S1:Stmt S2:Stmt => S1 ~> S2

	// Comparation 
	rule I1:Int <= I2:Int => I1 <=Int I2

	// Add
	rule I1:Int + I2:Int => I1 +Int I2

	// Pgm
	rule <k> int (X, Xs => Xs) ; S </k>
		<state> Rho:Map (.Map => X |-> 0) </state> 
		when notBool(X in keys(Rho))
	rule int .Ids ; S => S

	// Seq
	rule S1:Stmt S2:Stmt => S1 ~> S2

	// If - Else
	rule if (true)  B1:Block else B2:Block => B1 
  	rule if (false) B1:Block else B2:Block => B2 

endmodule