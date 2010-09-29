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
SEL_ROOTFS-$(PTXCONF_IMAGE_UBIFS_DATA)	+= $(IMAGEDIR)/data.ubifs
SEL_ROOTFS-$(PTXCONF_IMAGE_UBI)		+= $(IMAGEDIR)/root.ubi
SEL_ROOTFS-$(PTXCONF_IMAGE_UBI_DATA)	+= $(IMAGEDIR)/data.ubi

#
# create the UBIFS image
#
$(IMAGEDIR)/root.ubifs: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating $(notdir $(@)) from working dir... (-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) "
	@echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) -c $(PTXCONF_IMAGE_UBIFS_ROOT_MAX_LEB_COUNT)"
	@echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS)) "
	@cd $(image/work_dir);								\
	(awk -F: $(DOPERMISSIONS) $(image/permissions) &&			\
	(									\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mkfs.ubifs ";		\
		echo -n "-d $(image/work_dir) ";					\
		echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) ";			\
		echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) ";	\
		echo -n "-c $(PTXCONF_IMAGE_UBIFS_ROOT_MAX_LEB_COUNT) ";	\
		echo -n "$(PTXCONF_IMAGE_UBIFS_EXTRA_ARGS) ";			\
		echo -n "-o $@" )						\
	) | $(FAKEROOT) --
	@echo "done."

$(IMAGEDIR)/data.ubifs: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating $(notdir $(@)) from empty dir... (-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE) "
	@echo -n "-e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE) -c $(PTXCONF_IMAGE_UBIFS_DATA_MAX_LEB_COUNT)"
	@echo -n "$(PTXCONF_IMAGE_UBIFS_DATA_EXTRA_ARGS)) "
	@cd $(PTXDIST_TEMPDIR);						\
	DATA_TMPDIR="$$(mktemp -d $(PTXDIST_TEMPDIR)/data.XXXXXX)";	\
	echo $(PTXCONF_SYSROOT_HOST)/sbin/mkfs.ubifs			\
	 -d $${DATA_TMPDIR}						\
	 -e $(PTXCONF_IMAGE_UBIFS_LEB_SIZE)				\
	 -m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)			\
	 -c $(PTXCONF_IMAGE_UBIFS_DATA_MAX_LEB_COUNT)			\
	 $(PTXCONF_IMAGE_UBIFS_DATA_EXTRA_ARGS)				\
	 -o $@								\
	| $(FAKEROOT) --
	@echo "done."

#
# create the UBI image
#

ifdef PTXCONF_IMAGE_UBI_ROOT_VOL
$(IMAGEDIR)/root.ubi: $(IMAGEDIR)/root.ubifs
endif

ifdef PTXCONF_IMAGE_UBI_DATA_VOL
$(IMAGEDIR)/root.ubi: $(IMAGEDIR)/data.ubifs
endif

$(IMAGEDIR)/root.ubi: $(STATEDIR)/image_working_dir $(STATEDIR)/host-mtd-utils.install.post
	@echo -n "Creating $(notdir $(@)) from"
	@echo -n " $(notdir $(filter %.ubifs,$(^))) ... "
	@echo -n "(-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE) "
	@echo -n "-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET) -p $(PTXCONF_IMAGE_UBI_PEB_SIZE) "
	@echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)"
	@echo -n "$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)) "
# Only one partition can be marked as autoresize. Hence if we generate more than
# one volume, we check for autoresize option first and remove it from the .ini
# file.
ifdef PTXCONF_IMAGE_UBI_ROOT_VOL
	@UBI_VOLUME_SIZE="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_ROOT_VOL_SIZE))" \
	 UBI_VOLUME_NAME="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_ROOT_VOL_NAME))" \
	 UBI_VOLUME_ID="0" \
	 UBI_VOLUME_IMAGE="root.ubifs" \
	ptxd_replace_magic "$(PTXDIST_TOPDIR)/config/mtd-utils/ubi.ini" > "$(PTXDIST_TEMPDIR)/ubi_root.ini"
endif
ifdef PTXCONF_IMAGE_UBI_DATA_VOL
	@if [ -r "$(PTXDIST_TEMPDIR)/ubi_root.ini" ]; then \
		sed -i "/.*autoresize.*/d" "$(PTXDIST_TEMPDIR)/ubi_root.ini"; \
	 else \
		echo "WARNING: unable to read $(PTXDIST_TEMPDIR)/ubi_root.ini, prepare for troubles with the UBI image"; \
	 fi
	@UBI_VOLUME_SIZE="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_DATA_VOL_SIZE))" \
	 UBI_VOLUME_NAME="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_DATA_VOL_NAME))" \
	 UBI_VOLUME_ID="1" \
	 UBI_VOLUME_IMAGE="data.ubifs" \
	ptxd_replace_magic "$(PTXDIST_TOPDIR)/config/mtd-utils/ubi.ini" >> "$(PTXDIST_TEMPDIR)/ubi_root.ini"
endif
	@cd $(IMAGEDIR);							\
	$(PTXCONF_SYSROOT_HOST)/sbin/ubinize					\
		-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE)				\
		-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET)			\
		-p $(PTXCONF_IMAGE_UBI_PEB_SIZE)				\
		-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)			\
		$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)					\
		-o $@								\
		$(PTXDIST_TEMPDIR)/ubi_root.ini;					\

	@echo "done."

$(IMAGEDIR)/data.ubi: $(STATEDIR)/host-mtd-utils.install.post $(IMAGEDIR)/data.ubifs
	@echo -n "Creating $(notdir $(@)) from"
	@echo -n " $(notdir $(filter %.ubifs,$(^))) ... "
	@echo -n "(-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE) "
	@echo -n "-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET) -p $(PTXCONF_IMAGE_UBI_PEB_SIZE) "
	@echo -n "-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)"
	@echo -n "$(PTXCONF_IMAGE_UBI_EXTRA_ARGS)) "
	@UBI_VOLUME_SIZE="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_DATA_VOL_SIZE))" \
	 UBI_VOLUME_NAME="$(call remove_quotes, $(PTXCONF_IMAGE_UBI_DATA_VOL_NAME))" \
	 UBI_VOLUME_ID="0" \
	 UBI_VOLUME_IMAGE="data.ubifs" \
	ptxd_replace_magic "$(PTXDIST_TOPDIR)/config/mtd-utils/ubi.ini" > "$(PTXDIST_TEMPDIR)/ubi_data.ini"
	@cd $(IMAGEDIR);							\
	$(PTXCONF_SYSROOT_HOST)/sbin/ubinize				\
		-s $(PTXCONF_IMAGE_UBI_SUB_PAGE_SIZE)				\
		-O $(PTXCONF_IMAGE_UBI_VID_HEADER_OFFSET)			\
		-p $(PTXCONF_IMAGE_UBI_PEB_SIZE)				\
		-m $(PTXCONF_IMAGE_UBIFS_MINIMUM_IO_UNIT_SIZE)			\
		$(PTXCONF_IMAGE_UBI_DATA_EXTRA_ARGS)				\
		-o $@								\
		$(PTXDIST_TEMPDIR)/ubi_data.ini;

	@echo "done."

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
