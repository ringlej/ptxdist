#!/bin/bash

quilt mail \
	--mbox mailbox \
	--sender "r.schwebel@pengutronix.de" \
	--from "Robert Schwebel <r.schwebel@pengutronix.de>" \
	--to "python-dev@python.org" \
	--subject "[RFC] cross compiling python 3.0" \
	--signature patches/signature \
	-m "$(cat <<EOF

Embedded people have cross compiled python for quite some time now, with
more or less success. These activities have taken place in various
embedded build systems, such as PTXdist, OpenEmbedded and others.

I suppose instead of wasting the time over and over again, without
proper review by the Python core developers, I would like to find out if
it is possible to get cross compilation support integrated in the
upstream tree. This patch series reflects what we currently have in
PTXdist. Please see it as an RFC.

It is probably not perfect yet, but I would like to see some feedback
from you Python guys out there. Do you see issues with these patches?
Would it be possible in general to get something similar to this series
into the Python mainline?

Robert

EOF
)"
