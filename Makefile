CC=gcc
CFLAGS=-Wall -g
BINS=librarytest libmystaticcode.a static_librarytest libmycode.so runtime_librarytest

all: $(BINS)

clean: 
	rm *.o $(BINS)

# a simple object file, can be treated as a static library
# in fact, there is no real difference unless you have multiple
# object files you want in one static library
libmycode.o: libmycode.c mycode.h
	$(CC) $(CFLAGS) -c libmycode.c

# this is very similar to the object file, except that it is shared
# and may only be used in that way
# this is what a shared library file is
libmycode.so: libmycode.c mycode.h
	$(CC) $(CFLAGS) -fPIC -shared -o $@ libmycode.c -lc

# a static library
# in this case, it is same as a .o file, but if you have multiple
# .o's you want as one .a file, this is perfect
libmystaticcode.a: libmycode.o
	ar rcs libmystaticcode.a libmycode.o


## ----------- EXECUTABLES -----------

# uses a simple .o file
librarytest: librarytest.c libmycode.o
	$(CC) $(CFLAGS) -o $@ $^

# uses the static library, notice how we must give
# the linker hints about our external library
static_librarytest: librarytest.c
	$(CC) $(CFLAGS) -o $@ $^ -L. -lmystaticcode

# uses the shared library
# -Wl,-rpath=. is for our loader, it must know where
# to load our library from, if it is in a non-standard 
# location, which is our current directory
runtime_librarytest: librarytest.c
	$(CC) $(CFLAGS) -o $@ $^ -L. -lmycode -Wl,-rpath=.

