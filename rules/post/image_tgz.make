# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_TGZ)		+= $(IMAGEDIR)/root.tgz

ifdef PTXCONF_IMAGE_TGZ
$(IMAGEDIR)/root.tgz: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.tgz from working dir with label..."
	@cd $(image/work_dir);							\
	(awk -F: $(DOPERMISSIONS) $(image/permissions) &&		\
	(	echo -n "tar --label '${PTXCONF_PROJECT_VENDOR}-${PTXCONF_PROJECT}${PTXCONF_PROJECT_VERSION}' -zcf ";	\
		echo -n "$@ ." )					\
	) | $(FAKEROOT) --
	@echo "done."
endif

# vim: syntax=make
