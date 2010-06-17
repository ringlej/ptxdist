# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MONO) += mono

#
# Paths and names
#
MONO_VERSION	:= 2.10.1
MONO		:= mono-$(MONO_VERSION)
MONO_SUFFIX	:= tar.bz2
MONO_URL	:= http://ftp.novell.com/pub/mono/sources/mono/$(MONO).$(MONO_SUFFIX)
MONO_SOURCE	:= $(SRCDIR)/$(MONO).$(MONO_SUFFIX)
MONO_DIR	:= $(BUILDDIR)/$(MONO)
MONO_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MONO_SOURCE):
	@$(call targetinfo)
	@$(call get, MONO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MONO_CONF_ENV	:= \
	$(CROSS_ENV) \
	CPPFLAGS="$(CROSS_CPPFLAGS) -DARM_FPU_NONE=1" \
	mono_cv_uscore=yes
#
# autoconf
#
MONO_CONF_TOOL	:= autoconf
MONO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-solaris-tar-check \
	--disable-nls \
	--disable-mcs-build \
	--enable-quiet-build \
	--disable-parallel-mark \
	--disable-dev-random \
	--enable-shared-handles \
	--disable-nunit-tests \
	--disable-big-arrays \
	--disable-dtrace \
	--disable-llvm \
	--with-libgdiplus=installed \
	--with-glib=embedded \
	--with-gc=included \
	--with-tls=pthread \
	--with-sigaltstack=no \
	--with-static_mono=no \
	--with-xen_opt=no \
	--with-large-heap=no \
	--with-ikvm-native=yes \
	--with-jit=yes \
	--with-interp=no \
	--without-x \
	--with-profile2=no \
	--with-profile4=no \
	--with-moonlight=no \
	--with-monotouch=no \
	--with-oprofile=no \
	--with-malloc-mempools=no \
	--with-mcs-docs=no

#  --enable-minimal=LIST      drop support for LIST subsystems.
#     LIST is a comma-separated list from: aot, profiler, decimal, pinvoke, debug,
#     reflection_emit, reflection_emit_save, large_code, logging, com, ssa, generics, attach, jit, simd,soft_debug.

#  --with-glib=embedded|system    Choose glib API: system or embedded (default to system)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mono.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  mono)
	@$(call install_fixup, mono,PACKAGE,mono)
	@$(call install_fixup, mono,PRIORITY,optional)
	@$(call install_fixup, mono,VERSION,$(MONO_VERSION))
	@$(call install_fixup, mono,SECTION,base)
	@$(call install_fixup, mono,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mono,DEPENDS,)
	@$(call install_fixup, mono,DESCRIPTION,missing)

	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/machine.config)

	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/DefaultWsdlHelpGenerator.aspx)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/Browsers/Compat.browser)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/DefaultWsdlHelpGenerator.aspx)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/machine.config)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/settings.map)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/2.0/web.config)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/browscap.ini)
	@$(call install_copy, mono, 0, 0, 0644, -, /etc/mono/config)

	@$(call install_tree, mono, -, -, $(MONO_PKGDIR)/usr/bin, /usr/bin)
	@$(call install_tree, mono, -, -, $(MONO_PKGDIR)/usr/lib, /usr/lib)

	@$(call install_copy, mono, 0, 0, 0644, -, /usr/share/mono-2.0/mono/cil/cil-opcodes.xml)

	# looks like we have to install this, otherwhise not even helloworld.cs does work
	@$(call install_copy, mono, 0, 0, 0755, \
		$(MONO_DIR)/mcs/class/lib/monolite/mscorlib.dll, \
		/usr/lib/mono/1.0/mscorlib.dll)

	@$(call install_finish, mono)

	@$(call touch)

