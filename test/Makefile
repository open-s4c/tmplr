.POSIX:
.SUFFIXES: .in .done

ROOTDIR=	..
TMPLR=		${ROOTDIR}/tmplr
TESTS!=		ls *.in
TARGETS!=	echo "${TESTS}" | sed -e 's/\.in/.done/g'


all: ${TMPLR} ${TARGETS}

clean:
	rm -rf *.out *.done *.err

${TMPLR}:
	${MAKE} -C ${ROOTDIR} tmplr

.in.done:
	# Run tmplr and check whether it crashes. If crash is controlled (ie,
	# not a signal) and expected (a file $*.rc exists), then tmplr is ok.
	# Error codes > 128 (should) mean an uncaught signal.
	# (TODO: hangs)
	@echo "$*"
	@${TMPLR} -P _tmpl $< > $*.out 2> $*.err || ( \
		rc=$$?; \
		if [ "$$rc" -gt 128 ]; then \
			echo "error: Uncaught signal, return code $$rc"; \
			exit 1; \
		elif [ ! -f $*.rc ]; then \
			echo -n "error: Unexpected return code $$rc."; \
			echo " If this is expected, add an .rc file."; \
			exit 1; \
		elif [ "$$rc" != "$$(cat $*.rc)" ]; then \
			echo -n "error: Wrong return code $$rc."; \
			echo " Return code in .rc file does not match."; \
			exit 1; \
		fi; \
	)


	# check expected output if available
	@if [ -f "$*.exp" ]; then diff $*.exp $*.out; fi

	# mark test as done
	@touch $@
