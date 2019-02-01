all: parser lexer

lexer: ./Lexer.x
	alex Lexer.x

parser: ./HappyParser.y
	happy HappyParser.y

clean:
	rm Lexer.hs HappyParser.hs
