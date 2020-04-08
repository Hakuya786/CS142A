grammar Crux;

AND: 'and';
OR: 'or';
NOT: 'not';
LET: 'let';

ARRAY: 'array';
FUNC: 'func';
IF: 'if';
ELSE: 'else';
WHILE: 'while';
RETURN: 'return';

OPEN_PAREN:	'(';
CLOSE_PAREN: ')';
OPEN_BRACE: '{';
CLOSE_BRACE: '}';
OPEN_BRACKET: '[';
CLOSE_BRACKET: ']';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
GREATER_EQUAL: '>=';
LESSER_EQUAL: '<=';
NOT_EQUAL: '!=';
EQUAL: '==';
GREATER_THAN: '>';
LESS_THAN: '<';
ASSIGN: '=';
COMMA: ',';
CALL: '::';

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

literal
 : Integer
 | True
 | False
 ;

designator
 : Identifier (OPEN_BRACKET expression0 CLOSE_BRACKET)*
 ;

type
 : Identifier
 ;

op0
  : GREATER_EQUAL | LESSER_EQUAL | NOT_EQUAL | EQUAL | GREATER_THAN | LESS_THAN
  ;

op1
 : ADD | SUB | OR
 ;

op2
 : MUL | DIV | AND
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
 : NOT expression3
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
 : Var Identifier Colon type SemiColon
 ;

arrayDeclaration
 : ARRAY Identifier ':' type '[' Integer ']' ';'
 ;

functionDefinition
 : FUNC Identifier OPEN_PAREN parameterList CLOSE_PAREN Colon type statementBlock
 ;

assignmentStatement
 : 'let' designator '=' expression0 ';'
 ;

callStatement
 : callExpression ';'
 ;

ifStatement
 : 'if' expression0 statementBlock ('else' statementBlock)?
 ;

whileStatement
 : 'while' expression0 statementBlock
 ;

returnStatement
 : 'return' expression0 SemiColon
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

