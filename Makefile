PROJECT = Bez
SRC_DIR = src
BUILD_DIR = .
MAIN = jquery.bez

JS_ENGINE ?= `which node nodejs`
COMPILER ?= `which uglifyjs`

VERSION = $(shell git describe --tags --long | sed s/\-/\./)
YEAR = $(shell date +"%Y")

all: main min clean

nomin: main clean

main: version

version:
	@@echo "Setting version number (${VERSION}) and year (${YEAR})"
	@@sed 's/@VERSION/${VERSION}/' <${SRC_DIR}/${MAIN}.js | sed 's/@YEAR/${YEAR}/' > ${BUILD_DIR}/${MAIN}.tmp

min:
	@@if test ! -z ${JS_ENGINE} && test ! -z ${COMPILER}; then \
	echo "Minifying ${PROJECT}"; \
	${COMPILER} ${BUILD_DIR}/${MAIN}.tmp > ${BUILD_DIR}/${MAIN}.min.js; \
	echo ";" >> ${BUILD_DIR}/${MAIN}.min.js; \
	else \
		echo "You must have NodeJS and UglifyJS installed in order to minify ${PROJECT}."; \
	fi

clean:
	@@echo "Removing temp files"
	@@rm -f ${BUILD_DIR}/${MAIN}.tmp
	@@echo "Done"