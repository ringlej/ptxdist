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
PACKAGES-$(PTXCONF_VORBIS_TOOLS) += vorbis-tools

#
# Paths and names
#
VORBIS_TOOLS_VERSION	:= 1.4.0
VORBIS_TOOLS_MD5	:= 567e0fb8d321b2cd7124f8208b8b90e6
VORBIS_TOOLS		:= vorbis-tools-$(VORBIS_TOOLS_VERSION)
VORBIS_TOOLS_SUFFIX	:= tar.gz
VORBIS_TOOLS_URL	:= http://downloads.xiph.org/releases/vorbis/$(VORBIS_TOOLS).$(VORBIS_TOOLS_SUFFIX)
VORBIS_TOOLS_SOURCE	:= $(SRCDIR)/$(VORBIS_TOOLS).$(VORBIS_TOOLS_SUFFIX)
VORBIS_TOOLS_DIR	:= $(BUILDDIR)/$(VORBIS_TOOLS)
VORBIS_TOOLS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
VORBIS_TOOLS_CONF_TOOL := autoconf
VORBIS_TOOLS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-threads \
	--disable-rpath \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_OGG123)-ogg123 \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_OGGDEC)-oggdec \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_OGGENC)-oggenc \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_OGGINFO)-ogginfo \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_VCUT)-vcut \
	--$(call ptx/endis, PTXCONF_VORBIS_TOOLS_VORBISCOMMENT)-vorbiscomment \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-curltest \
	--$(call ptx/wwo, PTXCONF_VORBIS_TOOLS_FLAC)-flac \
	--$(call ptx/wwo, PTXCONF_VORBIS_TOOLS_OGG123)-speex \
	--without-kate \
	--without-curl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

VORBIS_TOOLS_PROGS_y :=
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_OGG123) += ogg123
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_OGGDEC) += oggdec
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_OGGENC) += oggenc
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_OGGINFO) += ogginfo
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_VCUT) += vcut
VORBIS_TOOLS_PROGS_$(PTXCONF_VORBIS_TOOLS_VORBISCOMMENT) += vorbiscomment

$(STATEDIR)/vorbis-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vorbis-tools)
	@$(call install_fixup, vorbis-tools,PRIORITY,optional)
	@$(call install_fixup, vorbis-tools,SECTION,base)
	@$(call install_fixup, vorbis-tools,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, vorbis-tools,DESCRIPTION,missing)

	@$(foreach prog, $(VORBIS_TOOLS_PROGS_y), \
		$(call install_copy, vorbis-tools, 0, 0, 0755, -, /usr/bin/$(prog));)

	@$(call install_finish, vorbis-tools)

	@$(call touch)

# vim: syntax=make
