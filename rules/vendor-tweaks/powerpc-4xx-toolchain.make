# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

VENDORTWEAKS = powerpc-4xx-toolchain
SELFEXTRACT = install-ppc4xx-toolchain.sh
ARCHIVE = ppc4xx-toolchain.tar.bz2
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

powerpc-4xx-toolchain_targetinstall: $(STATEDIR)/powerpc-4xx-toolchain.targetinstall

$(STATEDIR)/powerpc-4xx-toolchain.targetinstall:
	@$(call targetinfo, vendor-tweaks.targetinstall)
	tar cjPf $(ARCHIVE) $(PTXCONF_PREFIX)
	echo '#! /bin/bash' > $(SELFEXTRACT)
	echo 'echo ""' >> $(SELFEXTRACT)
	echo 'echo "PTXdist PowerPC 4xx Toolchain - extracting archive... please wait"' >> $(SELFEXTRACT)
	echo 'echo ""' >> $(SELFEXTRACT)
	echo 'if [ $(whoami) != root ] ; then' >> $(SELFEXTRACT)
	echo '  echo "You must be root to install!"' >> $(SELFEXTRACT)
	echo '	return 1;' >> $(SELFEXTRACT)
	echo 'fi' >> $(SELFEXTRACT)
	echo 'SKIP=`awk'" '/^__ARCHIVE_FOLLOWS__/ { print NR + 1; exit 0; }'"' $$0`' >> $(SELFEXTRACT)
	echo '# take the archive portion of this file and pipe it to tar' >> $(SELFEXTRACT)
	echo 'DIR=`pwd`' >> $(SELFEXTRACT)
	echo 'cd /' >> $(SELFEXTRACT)
	echo 'tail +$$SKIP $$DIR/$0 | bzip2 -cd | tar xf -' >> $(SELFEXTRACT)
	echo 'exit 0' >> $(SELFEXTRACT)
	echo 'cd $$DIR'
	echo '__ARCHIVE_FOLLOWS__' >> $(SELFEXTRACT)
	cat $(ARCHIVE) >> $(SELFEXTRACT)
	touch $@

# vim: syntax=make
