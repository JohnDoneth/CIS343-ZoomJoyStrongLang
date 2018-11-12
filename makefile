build:
	flex zjs.lex
	bison -d zjs.y
	clang -o zjs zjs.c lex.yy.c zjs.tab.c -lSDL2 -lm -lfl
