all: basic

basic:
	gcc basic.s -o basic.so -shared -fPIC
