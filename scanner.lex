%option noyywrap

%{
	#include "heading.h"
	#include "tok.h"
	int yyerror(char *s);
%}

comment						\\\*(.)*\*\\
letter						[A-Za-z]
digit						[0-9]
id							{letter}({letter}|{digit})*
idClass						[A-Z]({letter}|{digit})*
number						{digit}+(\.{digit}+)?

%%

[ \t]*						{}
[\n]						{ yylineno++;	}

"+"							{yylval.str = new std::string(yytext); return (MAIS);}
"-"							{yylval.str = new std::string(yytext); return (MENOS);}
"*"							{yylval.str = new std::string(yytext); return (MULT);}
"/"							{yylval.str = new std::string(yytext); return (DIV);}
"%"							{yylval.str = new std::string(yytext); return (MOD);}

"!="						{yylval.str = new std::string(yytext); return (DIFERENTE);}
"=="						{yylval.str = new std::string(yytext); return (IGUAL);}
"<"							{yylval.str = new std::string(yytext); return (MENOR);}
">"							{yylval.str = new std::string(yytext); return (MAIOR);}
"<="						{yylval.str = new std::string(yytext); return (MENORIGUAL);}
">="						{yylval.str = new std::string(yytext); return (MAIORIGUAL);}

"||"						{yylval.str = new std::string(yytext); return (OULOG);}
"&&"						{yylval.str = new std::string(yytext); return (ELOG);}
"!"							{yylval.str = new std::string(yytext); return (NEGLOG);}

"("							{yylval.str = new std::string(yytext); return (LPAREN);}
")"							{yylval.str = new std::string(yytext); return (RPAREN);}
"["							{yylval.str = new std::string(yytext); return (LCHAVE);}
"]"							{yylval.str = new std::string(yytext); return (RCHAVE);}
"{"							{yylval.str = new std::string(yytext); return (LCOLCH);}
"}"							{yylval.str = new std::string(yytext); return (RCOLCH);}

","							{yylval.str = new std::string(yytext); return (VIRG);}
"."							{yylval.str = new std::string(yytext); return (PNT);}
";"							{yylval.str = new std::string(yytext); return (PNTEVIRG);}
":"							{yylval.str = new std::string(yytext); return (DOISPNT);}
"="							{yylval.str = new std::string(yytext); return (ATRIB);}

int							{yylval.str = new std::string(yytext); return (INT);}
boolean						{yylval.str = new std::string(yytext); return (BOOL);}
float						{yylval.str = new std::string(yytext); return (FLOAT);}
char						{yylval.str = new std::string(yytext); return (CHAR);}
string						{yylval.str = new std::string(yytext); return (STRING);}

true						{yylval.str = new std::string(yytext); return (TRUE);}
false						{yylval.str = new std::string(yytext); return (FALSE);}

read						{yylval.str = new std::string(yytext); return (READ);}
write						{yylval.str = new std::string(yytext); return (WRITE);}
print						{yylval.str = new std::string(yytext); return (PRINT);}

loop						{yylval.str = new std::string(yytext); return (LOOP);}
for							{yylval.str = new std::string(yytext); return (FOR);}

if							{yylval.str = new std::string(yytext); return(IF);}
else						{yylval.str = new std::string(yytext); return (ELSE);}
switch						{yylval.str = new std::string(yytext); return (SWITCH);}

case						{yylval.str = new std::string(yytext); return (CASE);}
default						{yylval.str = new std::string(yytext); return (DEFAULT);}
break						{yylval.str = new std::string(yytext); return (BREAK);}
exit						{yylval.str = new std::string(yytext); return (EXIT);}
when						{yylval.str = new std::string(yytext); return (WHEN);}
size						{yylval.str = new std::string(yytext); return (SIZE);}

new							{yylval.str = new std::string(yytext); return (NEW);}
this						{yylval.str = new std::string(yytext); return (THIS);}

{idClass}					{yylval.str = new std::string(yytext); return (IDCLASS);}
{id}						{yylval.str = new std::string(yytext); return (ID);}
{number}					{yylval.val = atoi(yytext); return (NUM);}

.							{ std::cerr << "SCANNER "; yyerror(""); exit(1);	}

%%
