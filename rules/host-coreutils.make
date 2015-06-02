# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_COREUTILS) += host-coreutils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_COREUTILS_SKIP := \
	base64 basename cat chcon chgrp chmod chown chroot cksum comm cp \
	csplit cut date dd df dir dircolors dirname du echo env expand \
	expr factor false fmt fold groups head hostid id install join \
	kill link logname ls md5sum mkdir mkfifo mknod mktemp mv nice nl \
	nohup nproc numfmt od paste pathchk pinky pr printenv printf ptx \
	pwd readlink realpath rm rmdir runcon seq sha1sum sha224sum \
	sha256sum sha384sum sha512sum shred shuf sleep sort split stat \
	stdbuf stty sum sync tac tail tee test [ timeout touch tr true \
	truncate tsort tty uname unexpand uniq unlink uptime users vdir \
	wc who whoami yes

#
# autoconf
#
HOST_COREUTILS_CONF_TOOL	:= autoconf
HOST_COREUTILS_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--disable-silent-rules \
	--enable-threads=posix \
	--disable-assert \
	--disable-rpath \
	--disable-libsmack \
	--disable-xattr \
	--disable-libcap \
	--enable-install-program=ln \
	--enable-no-install-program=$(subst $(space),$(comma),$(strip $(HOST_COREUTILS_SKIP))) \
	--disable-nls \
	--without-openssl \
	--without-selinux \
	--without-gmp

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-coreutils.install:
	@$(call targetinfo)
	@$(call world/install, HOST_COREUTILS)
	@find $(HOST_COREUTILS_PKGDIR) -type f -executable ! -name ln | xargs rm
	@$(call touch)

# vim: syntax=make
