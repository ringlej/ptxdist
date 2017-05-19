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
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_MONO) += mono
endif

#
# Paths and names
#
MONO_VERSION	:= 3.2.8
MONO_MD5	:= 1075f99bd8a69890af9e30309728e684
MONO		:= mono-$(MONO_VERSION)
MONO_SUFFIX	:= tar.bz2
MONO_URL	:= http://download.mono-project.com/sources/mono/$(MONO).$(MONO_SUFFIX)
MONO_SOURCE	:= $(SRCDIR)/$(MONO).$(MONO_SUFFIX)
MONO_DIR	:= $(BUILDDIR)/$(MONO)
MONO_LICENSE	:= unknown
MONO_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/mono.extract:
	@$(call targetinfo)
	@$(call clean, $(MONO_DIR))
	@$(call extract, MONO)
#	# The mono archive has some stray .git files in it's externals-subdirs
	@find $(MONO_DIR) -name .git -print0 | xargs -0 rm -v
	@$(call patchin, MONO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MONO_CONF_ENV	:= \
	$(CROSS_ENV) \
	CPPFLAGS="$(CROSS_CPPFLAGS) $(call ptx/ifdef, PTXCONF_HAS_HARDFLOAT,,-DARM_FPU_NONE)" \
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
	--enable-silent-rules \
	--disable-parallel-mark \
	--disable-dev-random \
	--enable-shared-handles \
	--disable-nunit-tests \
	--disable-big-arrays \
	--disable-dtrace \
	--disable-llvm \
	--disable-loadedllvm \
	--disable-llvm-version-check \
	--with-libgdiplus=installed \
	--with-gc=included \
	--with-tls=pthread \
	--with-sigaltstack=no \
	--with-static_mono=no \
	--with-shared_mono=yes \
	--with-xen_opt=no \
	--with-large-heap=no \
	--with-ikvm-native=yes \
	--with-profile2=no \
	--with-profile4=no \
	--with-profile4_5=no \
	--with-monodroid=no \
	--with-monotouch=no \
	--with-mobile=no \
	--with-oprofile=no \
	--with-malloc-mempools=no \
	--with-mcs-docs=no \
	--with-lazy-gc-thread-creation=no \
	--enable-libraries \
	--enable-executables \
	--disable-extension-module \
	--disable-small-config \
	--enable-system-aot \
	--enable-boehm \
	--disable-nacl-codegen \
	--disable-nacl-gc \
	--disable-icall-symbol-map \
	--enable-icall-export \
	--disable-icall-tables \
	--with-jumptables=no \
	--with-sgen=yes

# --enable-minimal=LIST      drop support for LIST subsystems.
# --with-crosspkgdir=/path/to/pkg-config/dir      Change pkg-config dir to custom dir
#
# LIST is a comma-separated list from: aot, profiler, decimal, pinvoke, debug,
# appdomains, verifier, reflection_emit, reflection_emit_save, large_code,
# logging, com, ssa, generics, attach, jit, simd, soft_debug, perfcounters,
# normalization, assembly_remapping, shared_perfcounters, remoting, security,
# sgen_remset, sgen_marksweep_par, sgen_marksweep_fixed,
# sgen_marksweep_fixed_par, sgen_copying.],

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

# vim: syntax=make
