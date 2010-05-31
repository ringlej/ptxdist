# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_UBIFS)	+= $(IMAGEDIR)/root.ubifs
SEL_ROOTFS-$(PTXCONF_IMAGE_UBI)		+= $(IMAGEDIR)/root.ubi

#
# create the UBIFS image
#
$(IMAGEDIR)/root.ubifs: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating root.ubifs from working dir... (-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) "
	@echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) -c $(PTXCONF_IMAGE_UBIFS_MAX_LEB_COUNT)"
	@echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS)) "
	@cd $(WORKDIR);								\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&			\
	(									\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mkfs.ubifs ";		\
		echo -n "-d $(WORKDIR) ";					\
		echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) ";			\
		echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) ";	\
		echo -n "-c $(PTXCONF_IMAGE_UBIFS_MAX_LEB_COUNT) ";		\
		echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS) ";			\
		echo -n "-o $@" )						\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the UBI image
#
$(IMAGEDIR)/root.ubi: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post $(IMAGEDIR)/root.ubifs
	@echo -n "Creating root.ubi from root.ubifs... (-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE) "
	@echo -n "-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET) -p $(PTXCONF_IMAGE_UBI_PEB_SIZE) "
	@echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)"
	@echo -n "$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)) "
	@export UBI_VOLUME_SIZE=${PTXCONF_IMAGE_UBI_VOLUME_SIZE} && \
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/mtd-utils/ubi.ini" > "${PTXDIST_TEMPDIR}/ubi.ini"
	@cd $(IMAGEDIR);							\
	$(PTXCONF_SYSROOT_HOST)/sbin/ubinize					\
		-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE)				\
		-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET)			\
		-p $(PTXCONF_IMAGE_UBI_PEB_SIZE)				\
		-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)			\
		$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)					\
		-o $@								\
		${PTXDIST_TEMPDIR}/ubi.ini;					\

	@echo "done."

