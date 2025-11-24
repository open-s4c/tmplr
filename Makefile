.POSIX:

CFLAGS=		-O3
CFLAGS.tmplr=	-std=c99
CFLAGS.tmplr+=	-D_XOPEN_SOURCE=700 -D_POSIX_SOURCE
CFLAGS.tmplr+=	-Wall -Wextra -Wpedantic -Wshadow -Werror
CFLAGS.cov=	-g -O0 --coverage

PREFIX=		/usr/local
BINDIR=		${PREFIX}/bin
MANDIR=		${PREFIX}/share/man/man1
INCLUDEDIR=	${PREFIX}/include

all: tmplr tmplr.1
clean:
	rm -rf tmplr version.h tmplr.1
	@cd test && ${MAKE} clean

tmplr: tmplr.c version.h
	${CC} ${CFLAGS.tmplr} ${CFLAGS} -o $@ tmplr.c

version.h: version.h.in
	./versionize.sh -r version.h.in > $@

tmplr.1: tmplr.1.in
	./versionize.sh -r tmplr.1.in > $@

coverage: clean
	${MAKE} CFLAGS="${CFLAGS.cov}" all

install: ${TARGETS}
	mkdir -p ${DESTDIR}${BINDIR} ${DESTDIR}${MANDIR} ${DESTDIR}${INCLUDEDIR}
	install -m 755 tmplr ${DESTDIR}${BINDIR}/
	install -m 644 tmplr.1 ${DESTDIR}${MANDIR}/
	install -m 644 include/tmplr.h ${DESTDIR}${INCLUDEDIR}/

test: all
	@cd test && ${MAKE}

format:
	@find . -name '*.h' -exec clang-format -i -style=file {} +
	@find . -name '*.c' -exec clang-format -i -style=file {} +
