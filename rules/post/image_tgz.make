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

$(IMAGEDIR)/root.tgz: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.tgz from working dir..."
	@cd $(image/work_dir);							\
	(awk -F: $(DOPERMISSIONS) $(image/permissions) &&		\
	(	echo -n "tar -zcf ";					\
		echo -n "$@ ." )					\
	) | $(FAKEROOT) --
	@echo "done."

# vim: syntax=make
