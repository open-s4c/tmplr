.POSIX:

CFLAGS=-Wall -Werror -O3 -std=c99 -D_XOPEN_SOURCE=700

all: tmplr
clean:
	rm -rf tmplr

tmplr: tmplr.c
	$(CC) $(CFLAGS) -o $@ $<
