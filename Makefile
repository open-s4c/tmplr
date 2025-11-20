.POSIX:

CFLAGS=		-O3
CFLAGS_=	${CFLAGS}
CFLAGS_+=	-std=c99
CFLAGS_+=	-D_XOPEN_SOURCE=700 -D_POSIX_SOURCE
CFLAGS_+=	-Wall -Wextra -Wpedantic -Wshadow -Werror

COV_FLAGS=	-g -O0 --coverage

PREFIX=		/usr/local
BINDIR=		${PREFIX}/bin
MANDIR=		${PREFIX}/man/man1

all: tmplr tmplr.1
clean:
	rm -rf tmplr version.h tmplr.1
	@${MAKE} -C test clean

tmplr: tmplr.c version.h
	${CC} ${CFLAGS} -o $@ $<

version.h: version.h.in
	./versionize.sh version.h.in > $@

tmplr.1: tmplr.1.in
	./versionize.sh tmplr.1.in > $@

coverage: clean
	${MAKE} CFLAGS="${COV_FLAGS}" all

install: ${TARGETS}
	mkdir -p ${DESTDIR}${BINDIR}
	install -m 755 tmplr ${DESTDIR}${BINDIR}/
	mkdir -p ${DESTDIR}${MANDIR}
	install -m 644 tmplr.1 ${DESTDIR}${MANDIR}/

test: all
	${MAKE} -C test

format:
	@find . -name '*.h' -exec astyle --options=.astylerc {} +
	@find . -name '*.c' -exec astyle --options=.astylerc {} +

