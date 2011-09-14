PROJECT = Bez
SRC_DIR = src
BUILD_DIR = .
MAIN = jquery.bez
INTRO = ${SRC_DIR}/intro.js
VER = ${BUILD_DIR}/version.tmp

JS_ENGINE ?= `which node nodejs`
COMPILER ?= `which uglifyjs`

VERSION = $(shell git describe --tags --long | sed s/\-/\./)
YEAR = $(shell date +"%Y")

all: min main

min:
	@@if test ! -z ${JS_ENGINE} && test ! -z ${COMPILER}; then \
	echo "Minifying ${PROJECT}"; \
	${COMPILER} ${SRC_DIR}/${MAIN}.js > ${BUILD_DIR}/${MAIN}.tmp; \
	else \
		echo "You must have NodeJS and UglifyJS installed in order to minify ${PROJECT}."; \
	fi

main: version intro clean
	@@echo "Done"

version:
	@@echo "Setting version number (${VERSION}) and year (${YEAR})"
	@@sed 's/@VERSION/${VERSION}/' <${INTRO} | sed 's/@YEAR/${YEAR}/' > ${VER}

intro:
	@@echo "Attaching intro to minified file"
	@@cat ${BUILD_DIR}/version.tmp ${BUILD_DIR}/${MAIN}.tmp > ${BUILD_DIR}/${MAIN}.min.js

clean:
	@@echo "Removing temp files"
	@@rm -f ${BUILD_DIR}/${MAIN}.tmp
	@@rm -f ${VER}
