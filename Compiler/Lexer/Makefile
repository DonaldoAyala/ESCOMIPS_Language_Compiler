lex.yy.c: mipl_lex.l
	    flex mipl_lex.l

lex.yy.o: lex.yy.c
	    gcc -c lex.yy.c

main.o: main.c
	    gcc -c main.c

a.out: main.o lex.yy.o
	    gcc main.o lex.yy.o -lfl 

clean:
	    rm -f main.o lex.yy.o a.out lex.yy.c run.log

run: a.out
	    ./a.out
	    
test: a.out test.in
	    echo "\n--MIPL HIGH LEVEL LANGUAGE--\n" > run.log && cat test.in >> run.log && echo "\n---TOKENS---\n" >> run.log && ./a.out < test.in >> run.log && cat run.log | less

