%{ 
#include<stdio.h>
#include<stdlib.h>  
#include"exo1.tab.h" 

int yylex(void);
void yyerror(char*);

%} 
%union {
	
	char* ch;
	 
		
}

%token <ch> TYPE ID POUR DE A FAIRE FINPOUR SI ALORS SINONSI SINON FINSI AFFECTATION FONCTION CHAINE VIRGULE OP PO PF DPTS VALNUM NBENT BOOL
%start Input 
%left VIRGULE OP
%%
Input : ListeDeclarations LesInstuctions ;

ListeDeclarations:  {printf("int  ");}Declaration {printf("; \n");}  | ListeDeclarations Declaration   ;
Declaration:ListeVar DPTS TYPE  ;
ListeVar : ID {printf("%s ",$1);free($1) ;}| ListeVar VIRGULE  {printf(", ");} ListeVar;  



LesInstuctions :  |  Instruction LesInstuctions;

Instruction: Branchement|Affectation|Operation| FONCTION{ printf("%s ;\n",$1);free($1);}  ;

Branchement: Conditionnelle | Boucle ;

Boucle: POUR ID DE NBENT A {printf("for(%s=%s ; %s>",$2,$4,$2);free($4);} Expression FAIRE {printf(" ; %s++){\n",$2); free($2);} LesInstuctions FINPOUR {printf("}\n");} ;


Conditionnelle: SI PO BOOL PF ALORS {printf("if ( %s ){\n",$3);free($3);} LesInstuctions FINSI {printf("}\n");} ;

	       


Operation: Expression OP {printf("%s ",$2);free($2);} Expression  ;

VarOuConst: ID {printf("%s",$1);free($1);}  |VALNUM {printf("%s",$1);free($1);}|NBENT {printf("%s ",$1);free($1);} ;

Expression:  VarOuConst| Operation;

Affectation: ID AFFECTATION {printf("%s= ",$1);free($1);}  Expression {printf(";\n"); };

%%
void yyerror(char *s) {
	extern int yylineno;
	char str[100];
	sprintf(str,"Erreur syntaxique à la ligne n %d : %s\n", yylineno, s);
}
int main(void)
{
	yyparse();
	printf("\n----- Terminé ! ----- \n" );
}
