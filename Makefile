.SILENT:
All: exo1
	./exo1 < test.txt -s
	
exo1: exo1.tab.c lex.yy.c
	gcc -o exo1 exo1.tab.c lex.yy.c -lm -lfl


lex.yy.c: exo1.l
	lex -l exo1.l

exo1.tab.h exo1.tab.c: exo1.y
	bison -d exo1.y

clean:
	rm -rf exo1 exo1.tab.c exo1.tab.h lex.yy.c
