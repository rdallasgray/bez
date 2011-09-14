SRC_DIR = src
BUILD_DIR = .
BEZ = jquery.bez
INTRO = ${SRC_DIR}/intro.js
VER = ${BUILD_DIR}/version.tmp

JS_ENGINE ?= `which node nodejs`
COMPILER ?= `which uglifyjs`

VERSION = $(shell git describe --tags --long | sed s/\-/\./)
YEAR = $(shell date +"%Y")

all: min bez

min:
	@@if test ! -z ${JS_ENGINE} && test ! -z ${COMPILER}; then \
	echo "Minifying Bez" ${MIN}; \
	${COMPILER} ${SRC_DIR}/${BEZ}.js > ${BUILD_DIR}/${BEZ}.tmp; \
	else \
		echo "You must have NodeJS and UglifyJS installed in order to minify Bez."; \
	fi

bez: version intro clean
	@@echo "Done"

version:
	@@echo "Setting version number (${VERSION}) and year (${YEAR})"
	@@sed 's/@VERSION/${VERSION}/' <${INTRO} | sed 's/@YEAR/${YEAR}/' > ${VER}

intro:
	@@echo "Attaching intro to minified file"
	@@cat ${BUILD_DIR}/version.tmp ${BUILD_DIR}/${BEZ}.tmp > ${BUILD_DIR}/${BEZ}.min.js

clean:
	@@echo "Removing temp files"
	@@rm -f ${BUILD_DIR}/${BEZ}.tmp
	@@rm -f ${BUILD_DIR}/version.tmp
