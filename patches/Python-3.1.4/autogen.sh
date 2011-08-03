#!/bin/bash

# to add config.guess and config.sub
automake --copy --add-missing || true

autoheader --force

autoconf \
	--force \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported

