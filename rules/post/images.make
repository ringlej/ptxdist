# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

DOPERMISSIONS := '{	\
	if ($$1 == "f")	\
		printf("chmod %s \".%s\"; chown %s.%s \".%s\";\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mkdir -p \".`dirname \"%s\"`\"; mknod -m %s \".%s\" %s %s %s; chown %s.%s \".%s\";\n", $$2, $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'

ifdef PTXCONF_IMAGE_HD_PART1
	GENHDIMARGS = -p $(PTXCONF_IMAGE_HD_PART1_START):$(PTXCONF_IMAGE_HD_PART1_END):$(PTXCONF_IMAGE_HD_PART1_TYPE):$(IMAGEDIR)/root.ext2
endif
ifdef PTXCONF_IMAGE_HD_PART2
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART2_START):$(PTXCONF_IMAGE_HD_PART2_END):$(PTXCONF_IMAGE_HD_PART2_TYPE):
endif
ifdef PTXCONF_IMAGE_HD_PART3
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART3_START):$(PTXCONF_IMAGE_HD_PART3_END):$(PTXCONF_IMAGE_HD_PART3_TYPE):
endif
ifdef PTXCONF_IMAGE_HD_PART4
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART4_START):$(PTXCONF_IMAGE_HD_PART4_END):$(PTXCONF_IMAGE_HD_PART4_TYPE):
endif
ifdef PTXCONF_GRUB
	GENHDIMARGS += -m $(GRUB_DIR)/stage1/stage1
	GENHDIMARGS += -n $(GRUB_DIR)/stage2/stage2
endif

#
# generate the list of source permission files
#
PERMISSION_FILES := $(foreach pkg, $(PACKAGES), $(wildcard $(STATEDIR)/$(pkg)*.perms))
ifdef PTXDIST_PROD_PLATFORMDIR
PERMISSION_FILES += $(wildcard $(PTXDIST_PROD_PLATFORMDIR)/state/*.perms)
endif

#
# list of all ipkgs being selected for the root image
# UGLY: Just these files have '_' substituted to '-'; the permission files above have NOT.
#	Consistency would be nicer, but when fixing, change for side-effects carefully!
IPKG_FILES := $(foreach pkg, $(PACKAGES), $(wildcard $(PKGDIR)/$(subst _,-,$(pkg))*.ipk))

ifdef PTXDIST_PROD_PLATFORMDIR
IPKG_FILES += $(wildcard $(PTXDIST_PROD_PLATFORMDIR)/packages/*.ipk)
endif

#
# create one file with all permissions from all permission source files
#
PHONY += $(IMAGEDIR)/permissions
$(IMAGEDIR)/permissions: $(PERMISSION_FILES)
	@cat $^ > $@

#
# to extract the ipkgs we need a dummy config file
#
$(IMAGEDIR)/ipkg.conf:
	@echo -e "dest root /\narch $(PTXDIST_IPKG_ARCH_STRING) 10\narch all 1\narch noarch 1\n" > $@

#
# Working directory to create any kind of image
#
WORKDIR := $(IMAGEDIR)/work_dir

#
# Define what images should be build
#
SEL_ROOTFS-$(PTXCONF_IMAGE_HD)		+= $(IMAGEDIR)/hd.img
SEL_ROOTFS-$(PTXCONF_IMAGE_SQUASHFS)	+= $(IMAGEDIR)/root.squashfs

#
# extract all current ipkgs into the working directory
#
PHONY += $(STATEDIR)/image_working_dir
$(STATEDIR)/image_working_dir: $(IPKG_FILES) $(IMAGEDIR)/permissions $(IMAGEDIR)/ipkg.conf
	@rm -rf $(WORKDIR)
	@mkdir $(WORKDIR)
	@echo -n "Extracting ipkg packages into working directory..."
	@DESTDIR=$(WORKDIR) $(FAKEROOT) -- $(PTXCONF_SYSROOT_HOST)/bin/ipkg-cl -f $(IMAGEDIR)/ipkg.conf -o $(WORKDIR) install $(IPKG_FILES) 2>&1 >/dev/null
	@$(call touch, $@)

#
# create the squashfs image
#
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

#
# TODO
#
$(IMAGEDIR)/hd.img: $(IMAGEDIR)/root.ext2
	@echo -n "Creating hdimg from root.ext2";					\
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$$PATH $(PTXDIST_TOPDIR)/scripts/genhdimg	\
	-o $@ $(GENHDIMARGS)
	@echo "done."

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
