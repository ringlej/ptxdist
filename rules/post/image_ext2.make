# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2)	+= $(IMAGEDIR)/root.ext2
SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2_GZIP)	+= $(IMAGEDIR)/root.ext2.gz

$(IMAGEDIR)/root.ext2: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.ext2 from working dir..."
	@cd $(image/work_dir);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/bin/genext2fs ";	\
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) ";		\
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) ";		\
		echo -n "-d $(image/work_dir) ";				\
		echo "$@" )						\
	) | $(FAKEROOT) --
	@echo "done."


$(IMAGEDIR)/root.ext2.gz: $(IMAGEDIR)/root.ext2
	@echo -n "Creating root.ext2.gz from root.ext2...";
	@rm -f $@
	@cat $< | gzip -v9 > $@
	@echo "done."

# vim: syntax=make
