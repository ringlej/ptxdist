# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_JFFS2)	+= $(IMAGEDIR)/root.jffs2
SEL_ROOTFS-$(PTXCONF_IMAGE_JFFS2_SUM)	+= $(IMAGEDIR)/root.sum.jffs2

$(IMAGEDIR)/root.jffs2: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating root.jffs2 from working dir... (--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) $(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS))"
	@cd $(image/work_dir);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mkfs.jffs2 ";	\
		echo -n "-d $(image/work_dir) ";				\
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo -n "$(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS) ";		\
		echo -n "-o $@" )					\
	) | $(FAKEROOT) --
	@echo "done."

$(IMAGEDIR)/root.sum.jffs2: $(IMAGEDIR)/root.jffs2
	@echo -n "Creating root.sum.jffs2 with summary... (--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) $(PTXCONF_IMAGE_JFFS2_SUM_EXTRA_ARGS))"
	@cd $(image/work_dir);							\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/sumtool ";	\
		echo -n "-i $< ";					\
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo -n "$(PTXCONF_IMAGE_JFFS2_SUM_EXTRA_ARGS) ";	\
		echo -n "-o $@"						\
	) | $(FAKEROOT) --
	@echo "done."

# vim: syntax=make
