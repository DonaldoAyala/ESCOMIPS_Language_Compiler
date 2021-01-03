a.out: lex.yy.o mipl.tab.o main.o
	gcc main.o lex.yy.o mipl.tab.o -ll

main.o: main.c mipl.tab.h
	gcc -c main.c

lex.yy.o: lex.yy.c mipl.tab.h
	gcc -c lex.yy.c

mipl.tab.o: mipl.tab.c
	gcc -c mipl.tab.c

mipl.tab.h: mipl.y
	bison -d mipl.y
	
lex.yy.c: mipl.l
	flex mipl.l

mipl.tab.c: mipl.y
	bison -d mipl.y

clean:
	rm *.o lex.yy.c mipl.tab.c mipl.tab.h

run: a.out
	./a.out

test: test.txt
	cat test.txt | ./a.out

