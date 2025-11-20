#!/bin/sh
set -e

TMPLR=../tmplr
TEST_IN=$1

if [ -z "$TEST_IN" ]; then
	echo "Usage: ./runtest.sh <testfile.in>"
	exit 1
fi

TARGET=$(basename ${TEST_IN} .in)
printf "%s" "[TEST] ${TARGET} ..."

set +e
${TMPLR} -P _tmpl ${TEST_IN} > ${TARGET}.out 2> ${TARGET}.err
rc=$?
set -e
if [ "$rc" -gt 128 ]; then
	printf "\n%s\n" "error: Uncaught signal, return code $rc"
	exit 1
elif ! test -f ${TARGET}.rc && [ "$rc" != "0" ]; then
	printf "\n%s" "error: Unexpected return code $rc."
	printf " %s\n" "If this is expected, add an .rc file."
	exit 1
elif test -f ${TARGET}.rc && [ "$rc" != "$(cat ${TARGET}.rc)" ]; then
	printf "\n%s" "error: Wrong return code $rc"
	printf " %s\n" "(expected $(cat ${TARGET}.rc))"
	exit 1
elif test -f ${TARGET}.exp && ! diff ${TARGET}.out ${TARGET}.exp; then
	printf "\n%s\n" "error: Unexpected output."
	exit 1
fi
echo "done"
