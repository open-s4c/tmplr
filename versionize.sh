#!/bin/sh
# Usage: versionize.sh <FILE>
#
# Reads FILE and replaces occurences of __VERSION__ with the project version and
# occurences of __DATE__ with the current date. Emits results to stdout.
set -eu

# determine project version
VERSION='$Format:%h$'

if echo "$VERSION" | grep tag >/dev/null 2>&1; then
    VERSION=$(printf '%s' "$VERSION" | sed -n 's/.*tag: \([^,)]*\).*/\1/p')
else
    VERSION=$(git describe --tags --always --dirty 2>/dev/null || echo '')
fi

# fallback
if [ -z "$VERSION" ]; then
    VERSION="v0.0-unknown"
fi

VERSION=$(printf '%s' "$VERSION" | sed -n 's/v\(.*\)$/\1/p')

# determine current date
DATE=$(date '+%Y-%m-%d')

# if no filename passed, simply print version and date
if [ $# -eq 0 ]; then
    printf '%s %s %s\n' "$VERSION" "$DATE" "$*"
    exit 0
fi

# replace patterns in input file and print output to stdout
exec sed -e 's&__VERSION__&'"${VERSION}"'&' -e 's&__DATE__&'"${DATE}"'&' "$1"
