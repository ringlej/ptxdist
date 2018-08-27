# -*-makefile-*-
#
# Copyright (C) 2017 by Enrico Joerns <e.joerns@pengutronix.de>
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RAUC) += image-rauc

#
# Paths and names
#
IMAGE_RAUC		:= image-rauc
IMAGE_RAUC_DIR		:= $(BUILDDIR)/$(IMAGE_RAUC)
IMAGE_RAUC_IMAGE	:= $(IMAGEDIR)/update.raucb
IMAGE_RAUC_CONFIG	:= rauc.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_RAUC_KEY = $(PTXDIST_PLATFORMCONFIGDIR)/config/rauc/rauc.key.pem
IMAGE_RAUC_CERT = $(PTXDIST_PLATFORMCONFIGDIR)/config/rauc/rauc.cert.pem

IMAGE_RAUC_ENV	:= \
	RAUC_BUNDLE_COMPATIBLE="$(call remove_quotes,$(PTXCONF_RAUC_COMPATIBLE))" \
	RAUC_BUNDLE_VERSION="$(call remove_quotes, $(PTXCONF_RAUC_BUNDLE_VERSION))" \
	RAUC_BUNDLE_BUILD=$(shell date +%FT%T%z) \
	RAUC_BUNDLE_DESCRIPTION=$(PTXCONF_IMAGE_RAUC_DESCRIPTION) \
	RAUC_KEY=$(IMAGE_RAUC_KEY) \
	RAUC_CERT=$(IMAGE_RAUC_CERT)

$(IMAGE_RAUC_IMAGE): $(IMAGE_RAUC_KEY) $(IMAGE_RAUC_CERT)
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_RAUC)
	@$(call finish)

$(IMAGE_RAUC_KEY):
	@echo
	@echo "****************************************************************************"
	@echo "******** Please place your signing key in config/rauc/rauc.key.pem. ********"
	@echo "*                                                                          *"
	@echo "* Note: For test-purpose you can create one by running rauc-gen-certs.sh   *"
	@echo "*       from the scripts/ folder of your PTXdist installation              *"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1

$(IMAGE_RAUC_CERT):
	@echo
	@echo "****************************************************************************"
	@echo "**** Please place your signing certificate in config/rauc/rauc.cert.pem. ***"
	@echo "*                                                                          *"
	@echo "* Note: For test-purpose you can create one by running rauc-gen-certs.sh   *"
	@echo "*       from the scripts/ folder of your PTXdist installation              *"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1

# vim: syntax=make
