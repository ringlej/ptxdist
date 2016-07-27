#!/bin/bash

autoreconf \
	--force \
	--install \
	--warnings=cross \
	--warnings=syntax \
	--warnings=obsolete \
	--warnings=unsupported
