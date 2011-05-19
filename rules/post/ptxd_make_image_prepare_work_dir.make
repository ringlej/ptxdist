# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_IMAGE_INSTALL_FROM_IPKG_REPOSITORY
IMAGE_REQUIRES := $(STATEDIR)/ipkg-push
endif

#
# extract all current ipkgs into the working directory
#
PHONY += $(STATEDIR)/image_working_dir
$(STATEDIR)/image_working_dir: $(IMAGE_REQUIRES)
	@$(call image/env) \
	ptxd_make_image_prepare_work_dir
	@$(call touch, $@)

# vim: syntax=make
