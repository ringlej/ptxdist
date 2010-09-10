# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETPBM) += libnetpbm

#
# Paths and names
#
LIBNETPBM_VERSION	:= 10.35.72
LIBNETPBM		:= netpbm-$(LIBNETPBM_VERSION)
LIBNETPBM_SUFFIX	:= tgz
LIBNETPBM_URL		:= $(PTXCONF_SETUP_SFMIRROR)/netpbm/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_SOURCE	:= $(SRCDIR)/$(LIBNETPBM).$(LIBNETPBM_SUFFIX)
LIBNETPBM_DIR		:= $(BUILDDIR)/$(LIBNETPBM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBNETPBM_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBNETPBM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNETPBM_MAKE_ENV	:= $(CROSS_ENV)
LIBNETPBM_MAKE_PAR	:= NO
LIBNETPBM_MAKE_OPT	:= XML2_LIBS=NONE
ifndef PTXCONF_LIBNETPBM_PNG2PNM
LIBNETPBM_MAKE_OPT	+= HAVE_PNGLIB=N
endif
LIBNETPBM_INSTALL_OPT	:= \
	$(LIBNETPBM_MAKE_OPT) \
	pkgdir=$(LIBNETPBM_PKGDIR)/usr \
	install-run install-dev


$(STATEDIR)/libnetpbm.prepare:
	@$(call targetinfo)

	cp $(LIBNETPBM_DIR)/Makefile.config.in $(LIBNETPBM_DIR)/Makefile.config
ifdef PTXCONF_LIBNETPBM_BUILD_FIASCO
	sed -i -e "s,^BUILD_FIASCO.*,BUILD_FIASCO=Y,g" $(LIBNETPBM_DIR)/Makefile.config
else
	sed -i -e "s,^BUILD_FIASCO.*,BUILD_FIASCO=N,g" $(LIBNETPBM_DIR)/Makefile.config
endif
	sed -i -e "s,^CC =.*,CC=$(CROSS_CC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -i -e "s,^LINKER_CAN_DO_EXPLICIT_LIBRARY.*,LINKER_CAN_DO_EXPLICIT_LIBRARY=Y,g" $(LIBNETPBM_DIR)/Makefile.config
	sed -i -e "s,^INTTYPES_H.*,INTTYPES_H = <stdint.h>,g" $(LIBNETPBM_DIR)/Makefile.config
	sed -i -e "s,^CC_FOR_BUILD.*,CC_FOR_BUILD=$(HOSTCC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -i -e "s,^LD_FOR_BUILD.*,LD_FOR_BUILD=$(HOSTCC),g" $(LIBNETPBM_DIR)/Makefile.config
	sed -i -e "s,^CFLAGS_FOR_BUILD.*,CFLAGS_FOR_BUILD=,g" $(LIBNETPBM_DIR)/Makefile.config
	echo "CFLAGS=$(CROSS_CFLAGS) $(CROSS_CPPFLAGS)" >> $(LIBNETPBM_DIR)/Makefile.config
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetpbm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetpbm)
	@$(call install_fixup, libnetpbm,PRIORITY,optional)
	@$(call install_fixup, libnetpbm,SECTION,base)
	@$(call install_fixup, libnetpbm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnetpbm,DESCRIPTION,missing)

	@$(call install_lib, libnetpbm, 0, 0, 0644, libnetpbm)

ifdef PTXCONF_LIBNETPBM_PBM2LJ
	@$(call install_copy, libnetpbm, 0, 0, 0755, -, /usr/bin/pbmtolj)
endif
ifdef PTXCONF_LIBNETPBM_PPM2LJ
	@$(call install_copy, libnetpbm, 0, 0, 0755, -, /usr/bin/ppmtolj)
endif
ifdef PTXCONF_LIBNETPBM_PNG2PNM
	@$(call install_copy, libnetpbm, 0, 0, 0755, -, /usr/bin/pngtopnm)
endif
ifdef PTXCONF_LIBNETPBM_PNM2XWD
	@$(call install_copy, libnetpbm, 0, 0, 0755, -, /usr/bin/pnmtoxwd)
endif
ifdef PTXCONF_LIBNETPBM_XWD2PNM
	@$(call install_copy, libnetpbm, 0, 0, 0755, -, /usr/bin/xwdtopnm)
endif
	@$(call install_finish, libnetpbm)

	@$(call touch)

# vim: syntax=make
