#!/usr/bin/env bash
set -e

if [ -d "${DOCUMENT_ROOT}" ]; then
	if [ -e "${DOCUMENT_ROOT}/init.sh" ]; then
		echo '> Exec init.sh script ...'
		cd ${DOCUMENT_ROOT}
		sh init.sh
	fi
fi

exec "$@"