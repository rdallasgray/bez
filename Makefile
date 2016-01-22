PROJECT=Bez
SRC_DIR=src
BUILD_DIR=lib
MAIN=jquery.bez
YEAR=$(shell date +"%Y")
VERSION=$(shell node -pe "require('./package.json').version")

all: version min

version:
	@echo "Setting version number (${VERSION}) and year (${YEAR})" && \
	sed 's/@VERSION/${VERSION}/' <${SRC_DIR}/${MAIN}.js | sed 's/@YEAR/${YEAR}/' > ${BUILD_DIR}/${MAIN}.js

min:
	@echo "Minifying ${PROJECT}"; \
	uglifyjs ${BUILD_DIR}/${MAIN}.js > ${BUILD_DIR}/${MAIN}.min.js; \
	echo ";" >> ${BUILD_DIR}/${MAIN}.min.js; \
