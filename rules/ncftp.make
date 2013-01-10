# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NCFTP) += ncftp

#
# Paths and names
#
NCFTP_VERSION	:= 3.2.5
NCFTP_MD5	:= b05c7a6d5269c04891f02f43d4312b30
NCFTP		:= ncftp-$(NCFTP_VERSION)-src
NCFTP_SUFFIX	:= tar.bz2
NCFTP_URL	:= ftp://ftp.ncftp.com/ncftp/$(NCFTP).$(NCFTP_SUFFIX)
NCFTP_SOURCE	:= $(SRCDIR)/$(NCFTP).$(NCFTP_SUFFIX)
NCFTP_DIR	:= $(BUILDDIR)/$(NCFTP)
NCFTP_LICENSE	:= Clarified Artistic License

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NCFTP_CONF_TOOL := autoconf
NCFTP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--without-socks5 \
	--without-dnssec-local-validation

NCFTP_PROGS_y :=
NCFTP_PROGS_$(PTXCONF_NCFTP_NCTP) += ncftp
NCFTP_PROGS_$(PTXCONF_NCFTP_NCFTPBATCH_NCFTPSPOOLER) += ncftpbatch
NCFTP_PROGS_$(PTXCONF_NCFTP_NCFTPBOOKMARKS) += ncftpbookmarks
NCFTP_PROGS_$(PTXCONF_NCFTP_NCFTPGET) += ncftpget
NCFTP_PROGS_$(PTXCONF_NCFTP_NCFTPLS) += ncftpls
NCFTP_PROGS_$(PTXCONF_NCFTP_NCFTPPUT) += ncftpput

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ncftp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ncftp)
	@$(call install_fixup, ncftp,PRIORITY,optional)
	@$(call install_fixup, ncftp,SECTION,base)
	@$(call install_fixup, ncftp,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ncftp,DESCRIPTION,missing)

	@$(foreach prog, $(NCFTP_PROGS_y), \
		$(call install_copy, ncftp, 0, 0, 0755, -, /usr/bin/$(prog));)

ifdef PTXCONF_NCFTP_NCFTPBATCH_NCFTPSPOOLER
	@$(call install_link, ncftp, ncftpbatch, /usr/bin/ncftpspooler)
endif

	@$(call install_finish, ncftp)

	@$(call touch)

# vim: syntax=make
