# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_SW_EK_LM3S3748
ifneq ($(shell test -h $(PTXDIST_WORKSPACE)/selected_toolchain_stellaris && echo ok),ok)
    $(warning *** selected_toolchain_stellaris must point to a valid stellaris toolchain)
    $(error )
endif
ifneq ($(shell test -x $(PTXDIST_WORKSPACE)/selected_toolchain_stellaris/$(PTXCONF_STELLARIS_CC) && echo ok),ok)
    $(warning *** $(PTXDIST_WORKSPACE)/selected_toolchain_stellaris/$(PTXCONF_STELLARIS_CC) not found)
    $(error )
endif
endif

#
# We provide this package
#
PACKAGES-$(PTXCONF_SW_EK_LM3S3748) += sw-ek-lm3s3748

#
# Paths and names
#
SW_EK_LM3S3748_VERSION	:= 4423
SW_EK_LM3S3748_MD5	:=
SW_EK_LM3S3748		:= SW-EK-LM3S3748-$(SW_EK_LM3S3748_VERSION)
SW_EK_LM3S3748_SUFFIX	:= tar.bz2
SW_EK_LM3S3748_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(SW_EK_LM3S3748).$(SW_EK_LM3S3748_SUFFIX)
SW_EK_LM3S3748_SOURCE	:= $(SRCDIR)/$(SW_EK_LM3S3748).$(SW_EK_LM3S3748_SUFFIX)
SW_EK_LM3S3748_DIR	:= $(BUILDDIR)/$(SW_EK_LM3S3748)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SW_EK_LM3S3748_SOURCE):
	@$(call targetinfo)
	@$(call get, SW_EK_LM3S3748)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SW_EK_LM3S3748_MAKEVARS := \
	PREFIX=$(PTXDIST_WORKSPACE)/selected_toolchain_stellaris/$(PTXCONF_STELLARIS_GNU_TARGET)

$(STATEDIR)/sw-ek-lm3s3748.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/sw-ek-lm3s3748.compile:
	@$(call targetinfo)
#	# build static libraries
	cd $(SW_EK_LM3S3748_DIR) && $(SW_EK_LM3S3748_PATH) $(MAKE) \
		$(SW_EK_LM3S3748_MAKEVARS) $(PARALLELMFLAGS_BROKEN)
#	# build bootloader
ifdef PTXCONF_SW_EK_LM3S3748_BOOTLOADER
	cd $(SW_EK_LM3S3748_DIR)/boards/ek-lm3s3748/boot_usb/ && $(MAKE) \
		$(SW_EK_LM3S3748_MAKEVARS) $(PARALLELMFLAGS_BROKEN)
endif
#	# hacky, hacky
#	#cd $(SW_EK_LM3S3748_DIR)/boards/ek-lm3s3748/blinky/ && $(MAKE) \
#	#	$(SW_EK_LM3S3748_MAKEVARS) $(PARALLELMFLAGS_BROKEN)

#	# dfu wrapper (host tool)
	cd $(SW_EK_LM3S3748_DIR)/tools/dfuwrap && $(MAKE) \
		$(HOST_ENV) $(PARALLELMFLAGS_BROKEN)

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sw-ek-lm3s3748.install:
	@$(call targetinfo)

#	# install static libraries
	mkdir -p $(PTXDIST_PLATFORMDIR)/sysroot-stellaris/lib
	cp $(SW_EK_LM3S3748_DIR)/usblib/gcc/libusb.a \
		$(PTXDIST_PLATFORMDIR)/sysroot-stellaris/lib/libusb.a
	cp $(SW_EK_LM3S3748_DIR)/grlib/gcc/libgr.a \
		$(PTXDIST_PLATFORMDIR)/sysroot-stellaris/lib/libgr.a
	cp $(SW_EK_LM3S3748_DIR)/driverlib/gcc/libdriver.a \
		$(PTXDIST_PLATFORMDIR)/sysroot-stellaris/lib/libdriver.a

#	# install header files
	mkdir -p $(PTXDIST_PLATFORMDIR)/sysroot-stellaris/include
	cd $(SW_EK_LM3S3748_DIR) && \
	for i in `find . -name "*.h"`; do \
		mkdir -p $(PTXDIST_PLATFORMDIR)/sysroot-stellaris/include/`dirname $$i`; \
		cp $$i $(PTXDIST_PLATFORMDIR)/sysroot-stellaris/include/$$i; \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sw-ek-lm3s3748.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
