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

ifdef PTXCONF_IMAGE_TGZ
IMAGE_TGZ_LABEL := $(call remove_quotes,$(PTXCONF_IMAGE_TGZ_LABEL))
ifneq ($(IMAGE_TGZ_LABEL),)
IMAGE_TGZ_LABEL_ARGS=--label '$(IMAGE_TGZ_LABEL)'
endif

$(IMAGEDIR)/root.tgz: $(STATEDIR)/image_working_dir
	@echo -n 'Creating root.tgz from working dir$(if $(IMAGE_TGZ_LABEL), with label "$(IMAGE_TGZ_LABEL)",)... '
	@cd $(image/work_dir);					\
	(awk $(DOPERMISSIONS) $(image/permissions) &&		\
	(	echo -n "tar ${IMAGE_TGZ_LABEL_ARGS} -zcf ";	\
		echo -n "$@ ." )				\
	) | $(FAKEROOT) --
	@echo "done."
endif

# vim: syntax=make
