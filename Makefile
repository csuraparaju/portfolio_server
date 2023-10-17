CC=gcc
CFLAGS=-Wall -Wextra -g

OBJS=server.o net.o file.o mime.o cache.o hashtable.o llist.o

all: server

server: $(OBJS)
	gcc -g -lpthread -o $@ $^

net.o: net.c ./lib/net.h

server.o: server.c ./lib/net.h

file.o: file.c ./lib/file.h

mime.o: mime.c ./lib/mime.h

cache.o: cache.c ./lib/cache.h

hashtable.o: hashtable.c ./lib/hashtable.h

llist.o: llist.c ./lib/llist.h

clean:
	rm -f $(OBJS)
	rm -f server
	rm -f cache_tests/cache_tests
	rm -f cache_tests/cache_tests.exe
	rm -f cache_tests/cache_tests.log

TEST_SRC=$(wildcard cache_tests/*_tests.c)
TESTS=$(patsubst %.c,%,$(TEST_SRC))

cache_tests/cache_tests:
	cc cache_tests/cache_tests.c cache.c hashtable.c llist.c -o cache_tests/cache_tests

test:
	tests

tests: clean $(TESTS)
	sh ./cache_tests/runtests.sh

.PHONY: all, clean, tests
