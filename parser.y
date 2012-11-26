%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);

extern char *yytext;	// defined and maintained in lex.c
%}

%union{
  int		val;
  string*	str;
}

%start	l 

%token 	<str> IDCLASS
%token 	<str> ID
%token 	<str> MAIS
%token 	<str> MENOS
%token 	<str> MULT
%token 	<str> DIV
%token 	<str> MOD

%token <str> OULOG
%token <str> ELOG
%token <str> NEGLOG

%token <str> IGUAL
%token <str> DIFERENTE
%token <str> MENOR
%token <str> MAIOR
%token <str> MENORIGUAL
%token <str> MAIORIGUAL

%token <str> PRINT
%token <str> READ
%token <str> WRITE

%token <str> INT
%token <str> FLOAT
%token <str> BOOL
%token <str> CHAR
%token <str> STRING

%token <str> TRUE
%token <str> FALSE
%token <str> NUM

%token <str> LPAREN
%token <str> RPAREN
%token <str> LCHAVE
%token <str> RCHAVE
%token <str> LCOLCH
%token <str> RCOLCH

%token <str> PNT
%token <str> VIRG
%token <str> PNTEVIRG
%token <str> DOISPNT
%token <str> ATRIB

%token <str> LOOP
%token <str> FOR
%token <str> IF
%token <str> ELSE
%token <str> SWITCH
%token <str> CASE
%token <str> DEFAULT
%token <str> BREAK
%token <str> EXIT
%token <str> WHEN
%token <str> SIZE

%token <str> NEW
%token <str> THIS

%type	<str> l
%type	<str> stmt
%type	<val> exp
%type	<val> t
%type	<val> f
%type	<str> v
%type	<str> id

%%

l:					stmt										{ std::cout << "Passou 1!" << std::endl; }
					| stmt l									{ std::cout << "Passou 2!" << std::endl; }
					;

stmt:				tipo id PNTEVIRG
					| tipo id ATRIB exp PNTEVIRG
					| id ATRIB exp PNTEVIRG						{ std::cout << "Passou 3!" << std::endl; }
					| id LCHAVE exp RCHAVE ATRIB exp			{ std::cout << "Passou 4!" << std::endl; }
					| PRINT exp									{ std::cout << "Passou 5!" << std::endl; }
					| estr_cond									{ std::cout << "Passou 6!" << std::endl; }
					| estr_contr									
					| seq										{ std::cout << "Passou 7!" << std::endl; }
					;

estr_cond:			IF LPAREN exp RPAREN LCOLCH l RCOLCH							{ std::cout << "Passou 8!" << std::endl; }
					| IF LPAREN exp RPAREN LCOLCH l RCOLCH ELSE LCOLCH l RCOLCH 	{ std::cout << "Passou 9!" << std::endl; }
					| SWITCH LPAREN exp RPAREN LCOLCH switch_case RCOLCH			{ std::cout << "Passou 10!" << std::endl; }
					;
					
estr_contr:			LOOP LCOLCH l RCOLCH
					| FOR LPAREN PNTEVIRG PNTEVIRG RPAREN LCOLCH l RCOLCH

switch_case:		CASE NUM DOISPNT l switch_case
					| DEFAULT DOISPNT l
					;
					
seq:				BREAK PNTEVIRG
					| EXIT WHEN LPAREN exp RPAREN PNTEVIRG
					;
					
tipo:				IDCLASS
					| INT
					| BOOL
					| FLOAT
					| CHAR
					| STRING
					| tipo LCHAVE NUM RCHAVE
					| tipo LCHAVE NUM VIRG NUM RCHAVE
					;
					
exp:				t
					| NEGLOG f
					| exp MAIS t			
					| exp MENOS t		
					| exp OULOG t
					| exp IGUAL t
					| exp MENOR t
					| exp MAIOR t
					| exp MENORIGUAL t
					| exp MAIORIGUAL t
					| id LCHAVE exp RCHAVE
					| id PNT SIZE
					| THIS
					| NEW IDCLASS LPAREN RPAREN
					;
					
t:					f
					| t MULT f				
					| t DIV f				
					| t MOD f	
					| t ELOG f			
					;
					
f:					v
					| LPAREN exp RPAREN
					;

v:					id
					| NUM	
					| TRUE					
					| FALSE				
					;

id:					ID						{ $$ = new std::string(yytext) }


%%

int yyerror(string s)
{
	extern int yylineno;	// defined and maintained in lex.c
	extern char *yytext;	// defined and maintained in lex.c
	
	cerr << "ERROR: " << s << " at symbol \"" << yytext;
	cerr << "\" on line " << yylineno << endl;
	exit(1);
}

int yyerror(char *s)
{
	return yyerror(string(s));
}

