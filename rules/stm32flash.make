# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STM32FLASH) += stm32flash

#
# Paths and names
#
STM32FLASH_VERSION	:= 0.5
STM32FLASH_SUFFIX	:= tar.gz
STM32FLASH_MD5		:= 40f673502949f3bb655d2bcc539d7b6a
STM32FLASH		:= stm32flash-$(STM32FLASH_VERSION)
STM32FLASH_URL		:= $(call ptx/mirror, SF, stm32flash/$(STM32FLASH).$(STM32FLASH_SUFFIX))
STM32FLASH_DIR		:= $(BUILDDIR)/$(STM32FLASH)
STM32FLASH_SOURCE	:= $(SRCDIR)/$(STM32FLASH).$(STM32FLASH_SUFFIX)
STM32FLASH_LICENSE	:= GPLv2


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STM32FLASH_CONF_TOOL	:= NO
STM32FLASH_MAKE_ENV	:= $(CROSS_ENV)
STM32FLASH_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stm32flash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stm32flash)
	@$(call install_fixup, stm32flash, PRIORITY,optional)
	@$(call install_fixup, stm32flash, SECTION,base)
	@$(call install_fixup, stm32flash, AUTHOR,"Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, stm32flash, DESCRIPTION,missing)

	@$(call install_copy, stm32flash, 0, 0, 0755, -, /usr/bin/stm32flash)

	@$(call install_finish, stm32flash)
	
	@$(call touch)

# vim: syntax=make
