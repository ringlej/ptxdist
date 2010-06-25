# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_SQUASHFS)	+= $(IMAGEDIR)/root.squashfs

IMAGE_SQUASHFS_EXTRA_ARGS := \
	$(call ptx/ifdef, PTXCONF_HOST_SQUASHFS_TOOLS_V3X, $(call ptx/ifdef, PTXCONF_ENDIAN_BIG, -be, -le), ) \
	$(PTXCONF_IMAGE_SQUASHFS_EXTRA_ARGS)

$(IMAGEDIR)/root.squashfs: $(STATEDIR)/image_working_dir $(STATEDIR)/host-squashfs-tools.install.post
	@echo -n "Creating root.squashfs from working dir..."
	@cd $(WORKDIR);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mksquashfs ";	\
		echo -n "$(WORKDIR) ";					\
		echo -n "$@ ";						\
		echo -n "-noappend ";					\
		echo -n "-b $(PTXCONF_IMAGE_SQUASHFS_BLOCK_SIZE) ";	\
		echo -n $(IMAGE_SQUASHFS_EXTRA_ARGS) )	\
	) | $(FAKEROOT) --
	@echo "done."

# vim: syntax=make
