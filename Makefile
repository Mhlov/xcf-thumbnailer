CURRENT_DIR=$(shell pwd -P)
BIN_NAME=xcf-thumbnailer.pl
THUMB_NAME=xcf.thumbnailer
TARGET_BIN_DIR=${HOME}/bin
TARGET_THUMB_DIR=${HOME}/.local/share/thumbnailers

TARGET_BIN=${TARGET_BIN_DIR}/${BIN_NAME}
TARGET_THUMB=${TARGET_THUMB_DIR}/${THUMB_NAME}

ORIGIN_BIN=${CURRENT_DIR}/bin/${BIN_NAME}
ORIGIN_THUMB=${CURRENT_DIR}/share/${THUMB_NAME}


help:
	@echo "Usage:"
	@echo "\tmake install | link | uninstall"


install: make-dir
	@test -e "${TARGET_BIN}" || \
		cp "${ORIGIN_BIN}" "${TARGET_BIN}"

	@test -e "${TARGET_THUMB}" || \
		cp "${ORIGIN_THUMB}" "${TARGET_THUMB}"


link: make-dir
	@test -e "${TARGET_BIN}" || \
		ln -s "${ORIGIN_BIN}" "${TARGET_BIN}"

	@test -e "${TARGET_THUMB}" || \
		ln -s "${ORIGIN_THUMB}" "${TARGET_THUMB}"


uninstall:
	@test -e "${TARGET_BIN}" && \
		rm "${TARGET_BIN}"

	@test -e "${TARGET_THUMB}" && \
		rm "${TARGET_THUMB}"

make-dir:
	mkdir -p "${TARGET_THUMB_DIR}"
