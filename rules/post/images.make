# -*-makefile-*-

# ----------------------------------------------------------------------------
# Images
# ----------------------------------------------------------------------------

DOPERMISSIONS := '{	\
	if ($$1 == "f")	\
		printf("chmod %s .%s; chown %s.%s .%s;\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mkdir -p .`dirname %s`; mknod -m %s .%s %s %s %s; chown %s.%s .%s;\n", $$2, $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'

ifdef PTXCONF_MKNBI_NBI
MKNBI_EXT = nbi
else
MKNBI_EXT = elf
endif

MKNBI_KERNEL = $(KERNEL_TARGET_PATH)

MKNBI_ROOTFS = $(IMAGEDIR)/root.ext2
ifdef PTXCONF_IMAGE_EXT2_GZIP
MKNBI_ROOTFS = $(IMAGEDIR)/root.ext2.gz
endif

images: $(STATEDIR)/images

ipkg-push: $(STATEDIR)/ipkg-push

$(STATEDIR)/ipkg-push: $(STATEDIR)/host-ipkg-utils.install
	@$(call targetinfo, $@)
	( \
	PATH=$(PTXCONF_SYSROOT_CROSS)/bin:$(PTXCONF_SYSROOT_CROSS)/usr/bin:$$PATH; \
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$(PTXCONF_SYSROOT_HOST)/usr/bin:$$PATH; \
	export $$PATH; \
	$(PTXDIST_TOPDIR)/scripts/ipkg-push \
		--ipkgdir  $(call remove_quotes,$(IMAGEDIR)) \
		--repodir  $(call remove_quotes,$(PTXCONF_SETUP_IPKG_REPOSITORY)) \
		--revision $(call remove_quotes,$(FULLVERSION)) \
		--project  $(call remove_quotes,$(PTXCONF_PROJECT)) \
		--dist     $(call remove_quotes,$(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION)); \
	echo; \
	)
	$(call touch, $@)

images_deps =  world
ifdef PTXCONF_IMAGE_IPKG_IMAGE_FROM_REPOSITORY
images_deps += $(STATEDIR)/ipkg-push
endif

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
PERMISSION_FILES := $(foreach pkg, $(PACKAGES-y), $(wildcard $(STATEDIR)/$(pkg)*.perms))

#
# list of all ipkgs being selected for the root image
#
IPKG_FILES := $(foreach pkg, $(PACKAGES-y), $(wildcard $(PKGDIR)/$(pkg)*.ipk))

#
# create one file with all permissions from all permission source files
#
$(IMAGEDIR)/permissions: $(PERMISSION_FILES) $(PTXCONFIG)
	@cat $^ > $@

#
# to extract the ipkgs we need a dummy config file
#
$(IMAGEDIR)/ipkg.conf:
	@echo -e "dest root /\narch $(PTXCONF_ARCH_STRING) 10\narch all 1\narch noarch 1\n" > $@

#
# Working directory to create any kind of image
#
WORKDIR := $(IMAGEDIR)/work_dir

#
# Create architecture type for mkimge
# Most architectures are working with label $(PTXCONF_ARCH_STRING)
# but the i386 family needs "x86" instead!
#
ifeq ($(PTXCONF_ARCH_STRING),"i386")
MKIMAGE_ARCH := x86
else
MKIMAGE_ARCH := $(PTXCONF_ARCH_STRING)
endif

#
# Define what images should be build
#
SEL_ROOTFS-y				:=
SEL_ROOTFS-$(PTXCONF_IMAGE_TGZ)		+= $(IMAGEDIR)/root.tgz
SEL_ROOTFS-$(PTXCONF_IMAGE_JFFS2)	+= $(IMAGEDIR)/root.jffs2
SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2)	+= $(IMAGEDIR)/root.ext2
SEL_ROOTFS-$(PTXCONF_IMAGE_HD)		+= $(IMAGEDIR)/hd.img
SEL_ROOTFS-$(PTXCONF_IMAGE_EXT2_GZIP)	+= $(IMAGEDIR)/root.ext2.gz
SEL_ROOTFS-$(PTXCONF_IMAGE_UIMAGE)	+= $(IMAGEDIR)/uRamdisk
SEL_ROOTFS-$(PTXCONF_IMAGE_CPIO)	+= $(IMAGEDIR)/initrd.gz

#
# extract all current ipkgs into the working directory
#
$(STATEDIR)/image_working_dir: $(IPKG_FILES) $(IMAGEDIR)/permissions $(IMAGEDIR)/ipkg.conf
	@rm -rf $(WORKDIR)
	@mkdir $(WORKDIR)
	@echo -n "Extracting ipkg packages into working directory..."
	@DESTDIR=$(WORKDIR) $(FAKEROOT) -- $(PTXCONF_SYSROOT_HOST)/bin/ipkg-cl -f $(IMAGEDIR)/ipkg.conf -o $(WORKDIR) install $(IPKG_FILES) 2>&1 >/dev/null
	@$(call touch, $@)

#
# create the root.tgz image
#
$(IMAGEDIR)/root.tgz: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.tgz from working dir..."
	@cd $(WORKDIR);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(	echo -n "tar -zcf ";					\
		echo -n "$@ ." )			\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the JFFS2 image
#
$(IMAGEDIR)/root.jffs2: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.jffs2 from working dir..."
	@cd $(WORKDIR);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/sbin/mkfs.jffs2 ";	\
		echo -n "-d $(WORKDIR) ";				\
		echo -n "--eraseblock=$(PTXCONF_IMAGE_JFFS2_BLOCKSIZE) "; \
		echo -n "$(PTXCONF_IMAGE_JFFS2_EXTRA_ARGS) ";		\
		echo -n "-o $@" )			\
	) | $(FAKEROOT) --
	@echo "done."

#
# create the ext2 image
#
$(IMAGEDIR)/root.ext2: $(STATEDIR)/image_working_dir
	@echo -n "Creating root.ext2 from working dir..."
	@cd $(WORKDIR);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/bin/genext2fs ";	\
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) ";		\
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) ";		\
		echo -n "-d $(WORKDIR) ";				\
		echo "$@" )				\
	) | $(FAKEROOT) --
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/hd.img: $(IMAGEDIR)/root.ext2
	@echo -n "Creating hdimg from root.ext2";			\
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$$PATH $(PTXDIST_TOPDIR)/scripts/genhdimg	\
	-o $@ $(GENHDIMARGS)
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/root.ext2.gz: $(IMAGEDIR)/root.ext2
	@echo -n "Creating root.ext2.gz from root.ext2...";
	@rm -f $@
	@cat $< | gzip -v9 > $@
	@echo "done."

#
# TODO
#
$(IMAGEDIR)/uRamdisk: $(IMAGEDIR)/root.ext2.gz
	@echo -n "Creating U-Boot ramdisk from root.ext2.gz...";
	@$(PTXCONF_SYSROOT_HOST)/bin/mkimage \
		-A $(MKIMAGE_ARCH) \
		-O Linux \
		-T ramdisk \
		-C gzip \
		-n $(PTXCONF_IMAGE_UIMAGE_NAME) \
		-d $< \
		$@
	@echo "done."

#
# create traditional initrd.gz, to be used
# as initramfs (-> "-H newc")
#
$(IMAGEDIR)/initrd.gz: $(STATEDIR)/image_working_dir
	@echo -n "Creating initrd.gz from working dir..."
	@cd $(WORKDIR);							\
	(awk -F: $(DOPERMISSIONS) $(IMAGEDIR)/permissions &&		\
	(								\
		echo "find . | ";					\
		echo "cpio --quiet -H newc -o | ";			\
		echo "gzip -9 -n > $@" )				\
	) | $(FAKEROOT) --
	@echo "done."

#
# TODO: Find a way to always find the correct zipped kernel image on every
# architecture.
#
#$(IMAGEDIR)/muimage: $(IMAGEDIR)/initrd.gz $(KERNEL_DIR)/???????
#	@echo -n "Creating multi content uimage..."
#	@$(PTXCONF_SYSROOT_HOST)/bin/mkimage -A $(PTXCONF_ARCH_STRING)	\
#		-O Linux -T multi -C gzip -a 0 -e 0			\
#		-n 'Multi-File Image'					\
#		-d $(KERNEL_DIR)/vmlinux.bin.gz:$(IMAGEDIR)/initrd.img	\
#       	$(IMAGEDIR)/muimage
#	@echo "done."

#
# create all requested images and clean up when done
#
$(STATEDIR)/images:  $(SEL_ROOTFS-y) $(images_deps)
	@echo "Clean up temp working directory"
	@rm -rf $(WORKDIR) $(STATEDIR)/image_working_dir
	@$(call touch, $@)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
