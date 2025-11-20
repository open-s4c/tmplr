.POSIX:

CFLAGS=-Wall -Werror -O3 -std=c99 -D_XOPEN_SOURCE=700
CFLAGS_=-Wall -Werror -O3 -std=c99 -D_XOPEN_SOURCE=700

all: tmplr
clean:
	rm -rf tmplr version.h

version.h: version.h.in
	./versionize.sh version.h.in > $@

tmplr: tmplr.c version.h
	$(CC) $(CFLAGS) -o $@ $<
