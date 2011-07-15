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
	(awk -F: $(DOPERMISSIONS) $(image/permissions) &&		\
	(								\
		echo -n "$(PTXCONF_SYSROOT_HOST)/bin/genext2fs ";	\
		echo -n "-b $(PTXCONF_IMAGE_EXT2_SIZE) ";		\
		echo -n "$(PTXCONF_IMAGE_EXT2_EXTRA_ARGS) ";		\
		echo -n "-d $(image/work_dir) ";				\
		echo "$@" )						\
	) | $(FAKEROOT) --
	@echo "done."

ifdef PTXCONF_IMAGE_EXT2_JOURNAL
#	# Since genext2fs cannot generate ext3 images, we use tune2fs to create
#	# the journal entry and then run e2fsck to update the revision from 0
#	# to 1 to prevent a mount warning. Since both programs lack a quiet
#	# mode we use output redirection (and since we're operating on files
#	# and not on real block devices, it's very unlikely that there are
#	# errors we want to see.
	@echo -n "Adding a journal to root.ext2 ..."
	@tune2fs -j "$(IMAGEDIR)/root.ext2" > /dev/null
	@e2fsck -y "$(IMAGEDIR)/root.ext2" > /dev/null 2>&1
	@echo  "done."
endif

$(IMAGEDIR)/root.ext2.gz: $(IMAGEDIR)/root.ext2
	@echo -n "Creating root.ext2.gz from root.ext2...";
	@rm -f $@
	@cat $< | gzip -v9 > $@
	@echo "done."

# vim: syntax=make
