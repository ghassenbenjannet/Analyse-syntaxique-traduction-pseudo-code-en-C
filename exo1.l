%{ 
#include<stdio.h> 
#include<stdlib.h> 
#include<string.h> 
#include<malloc.h> 
#include"exo1.tab.h" 
%}
%option yylineno

ESPACE [ |\n|\t]*
ID [A-Za-z]+[A-Za-z0-9]*
LESTYPES (entiers|reels|chaine|caractere)
NBR  ([0-9]+|[0-9]+"."[0-9]+)
ENT [0-9]+

%% 
entiers return TYPE;

[Pp]our return POUR;
de return DE;
a return A;
[Ff]aire return FAIRE;

{ENT} {
		
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return NBENT;
	}
{NBR} {
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return VALNUM;
	}


[Ff]in[ ]*pour return FINPOUR; 
[sS]i return SI;
[Aa]lors return ALORS;
[sS]inon[]*[sS]i return SINONSI;
[sS]inon return SINON;
[Ff]in[ ]*[sS]i return FINSI;
"<-"  {return AFFECTATION;}

{ID}[ ]*"\("[ ]*({ID}|{NBR})[ ]*"\)" {
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return FONCTION;
		}
 


{ID} 		{
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return ID;
		}




{ID}("=="|"!="|"<"|">")({ID}|TRUE|FALSE) {
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return BOOL;
		}

\'.*\' return CHAINE;
"," return VIRGULE; 
":" return DPTS; 
(\+|\-|\*|\/) {
		yylval.ch=(char*) malloc(sizeof(char) *yyleng+1);
		strncpy(yylval.ch,yytext,yyleng+1);
		return OP;
		};

"(" return PO; 
")" return PF; 
[ \t\n]+	/* rien à faire */

. printf("erreur lexicale %s à la ligne %d\n",yytext,yylineno);

%%
int yywrap()
{
	return 1;
}

