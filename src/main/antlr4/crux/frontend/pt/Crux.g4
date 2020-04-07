grammar Crux;
program
 : declarationList EOF
 ;

declarationList
 : declaration*
 ;

declaration
 : variableDeclaration
 | arrayDeclaration
 | functionDefinition
 ;

variableDeclaration
 : Var Identifier ':' type ';'
 ;

arrayDeclaration
 : Array Identifier ':' type '[' Integer ']' ';'
 ;

functionDefinition
 : Func Identifier OPEN_PAREN parameterList CLOSE_PAREN Colon type statementBlock
 ;

type
 : Identifier
 ;

literal
 : Integer
 | True
 | False
 ;

designator
 : Identifier (OPEN_BRACKET expression0 CLOSE_BRACKET)*
 ;

op0
 : GREATER_EQUAL
 | LESSER_EQUAL
 | NOT_EQUAL
 | EQUAL
 | GREATER_THAN
 | LESS_THAN
 ;
op1
 : ADD
 | SUB
 | Or
 ;
op2
 : MUL
 | DIV
 | And
 ;

expression0
 : expression1 (op0 expression1)?
 ;
expression1
 : expression2 (op1 expression2)*
 ;
expression2
 : expression3 (op2 expression3)*
 ;
expression3
 : Not expression3
 | OPEN_PAREN expression0 CLOSE_PAREN
 | designator
 | callExpression
 | literal
 ;
callExpression
 : CALL Identifier OPEN_PAREN expressionList CLOSE_PAREN
 ;
expressionList
 : (expression0 (COMMA expression0)*)?
 ;

parameter
 : Identifier Colon type
 ;
parameterList
 : (parameter (COMMA parameter)*)?
 ;

assignmentStatement
 : Let designator ASSIGN expression0 SemiColon
 ;
callStatement
 : callExpression SemiColon
 ;
ifStatement
 : If expression0 statementBlock (Else statementBlock)?
 ;
whileStatement
 : While expression0 statementBlock
 ;
returnStatement
 : Return expression0
 ;
statement
 : variableDeclaration
 | callStatement
 | assignmentStatement
 | ifStatement
 | whileStatement
 | returnStatement
 ;
statementList
 : statement*
 ;
statementBlock
 : OPEN_BRACE statementList CLOSE_BRACE
 ;



//~~~~~~~~~~~
// start here
And : 'and';
Or : 'or' ;
Not : 'not';
Let : 'let';
Array : 'array';
Func : 'func';
If : 'if';
Else : 'else';
While : 'while';
Return : 'return';

OPEN_PAREN : '(';
CLOSE_PAREN : ')';
OPEN_BRACE : '{';
CLOSE_BRACE : '}';
OPEN_BRACKET : '[';
CLOSE_BRACKET : ']';
ADD : '+' ;
SUB : '-';
MUL : '*';
DIV : '/';
GREATER_EQUAL : '>=';
LESSER_EQUAL : '<=';
NOT_EQUAL : '!=';
EQUAL : '==';
GREATER_THAN : '>';
LESS_THAN : '<';
ASSIGN : '=';
COMMA : ',';
CALL : '::';
//~~~~~~~~~~~~~~~~~~

SemiColon: ';';
Colon: ':';

Integer
 : '0'
 | [1-9] [0-9]*
 ;

True: 'true';
False: 'false';

Var: 'var';

Identifier
 : [a-zA-Z] [a-zA-Z0-9_]*
 ;

WhiteSpaces
 : [ \t\r\n]+ -> skip
 ;

Comment
 : '//' ~[\r\n]* -> skip
 ;