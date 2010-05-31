# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_UBIFS_ROOT)	+= $(IMAGEDIR)/root.ubifs
SEL_ROOTFS-$(PTXCONF_IMAGE_UBI)		+= $(IMAGEDIR)/root.ubi

#
# create the UBIFS image
#
$(IMAGEDIR)/root.ubifs: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating $(notdir $(@)) from working dir... (-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) "
	@echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) -c $(PTXCONF_IMAGE_UBIFS_ROOT_MAX_LEB_COUNT)"
	@echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS)) "
	@cd $(WORKDIR);								\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&			\
	(									\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mkfs.ubifs ";		\
		echo -n "-d $(WORKDIR) ";					\
		echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) ";			\
		echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) ";	\
		echo -n "-c $(PTXCONF_IMAGE_UBIFS_ROOT_MAX_LEB_COUNT) ";	\
		echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS) ";			\
		echo -n "-o $@" )						\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the UBI image
#

ifdef PTXCONF_IMAGE_UBI_ROOT_VOL
$(IMAGEDIR)/root.ubi: $(IMAGEDIR)/root.ubifs
endif

$(IMAGEDIR)/root.ubi: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating $(notdir $(@)) from"
	@echo -n " $(notdir $(filter %.ubifs,$(^))) ... "
	@echo -n "(-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE) "
	@echo -n "-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET) -p $(PTXCONF_IMAGE_UBI_PEB_SIZE) "
	@echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)"
	@echo -n "$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)) "
ifdef PTXCONF_IMAGE_UBI_ROOT_VOL
	@UBI_VOLUME_SIZE="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_ROOT_VOL_SIZE))" \
	 UBI_VOLUME_NAME="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_ROOT_VOL_NAME))" \
	 UBI_VOLUME_ID="0" \
	 UBI_VOLUME_IMAGE="root.ubifs" \
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/mtd-utils/ubi.ini" > "${PTXDIST_TEMPDIR}/ubi_root.ini"
endif
	@cd $(IMAGEDIR);							\
	$(PTXCONF_SYSROOT_HOST)/sbin/ubinize					\
		-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE)				\
		-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET)			\
		-p $(PTXCONF_IMAGE_UBI_PEB_SIZE)				\
		-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)			\
		$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)					\
		-o $@								\
		${PTXDIST_TEMPDIR}/ubi_root.ini;					\

	@echo "done."

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
