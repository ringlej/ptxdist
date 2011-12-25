# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYSERIAL) += pyserial

#
# Paths and names
#
PYSERIAL_VERSION	:= 2.6
PYSERIAL_MD5		:= cde799970b7c1ce1f7d6e9ceebe64c98
PYSERIAL		:= pyserial-$(PYSERIAL_VERSION)
PYSERIAL_SUFFIX		:= tar.gz
PYSERIAL_URL		:= http://pypi.python.org/packages/source/p/pyserial/$(PYSERIAL).$(PYSERIAL_SUFFIX)
PYSERIAL_SOURCE		:= $(SRCDIR)/$(PYSERIAL).$(PYSERIAL_SUFFIX)
PYSERIAL_DIR		:= $(BUILDDIR)/$(PYSERIAL)
PYSERIAL_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYSERIAL_PATH		:= PATH=$(CROSS_PATH)
PYSERIAL_CONF_TOOL	:= NO
PYSERIAL_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Instal
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial.install:
	@$(call targetinfo)
	@cd $(PYSERIAL_DIR) && \
		$(PYSERIAL_PATH) $(PYSERIAL_MAKE_ENV) \
		python setup.py install --root=$(PYSERIAL_PKGDIR) --prefix=/usr
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pyserial.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pyserial)
	@$(call install_fixup, pyserial,PRIORITY,optional)
	@$(call install_fixup, pyserial,SECTION,base)
	@$(call install_fixup, pyserial,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, pyserial,DESCRIPTION, "Serial Communication for Python")

	@$(call install_copy, pyserial, 0, 0, 0755, $(PYTHON_SITEPACKAGES))
	@$(call install_copy, pyserial, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/serial)
	@$(call install_copy, pyserial, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/serial/tools)
	@$(call install_copy, pyserial, 0, 0, 0755, $(PYTHON_SITEPACKAGES)/serial/urlhandler)

	@for file in $(shell cd $(PYSERIAL_PKGDIR) && find . -name "*.pyc"); \
	do \
		$(call install_copy, pyserial, 0, 0, 0644, -, /$$file); \
	done

# note: the setup.py also installs the miniterm.py script, but with a really
# broken path to the python interpreter. As a workaround we use the plain script
# from the build directory instead
ifdef PTXCONF_PYSERIAL_MINITERM
	$(call install_copy, pyserial, 0, 0, 0755, \
		$(PYSERIAL_DIR)/serial/tools/miniterm.py, /usr/bin/miniterm.py)
endif

# there are some examples that could be useful to check and understand this package
ifdef PTXCONF_PYSERIAL_EXAMPLES
	@for file in run_all_tests.py test_high_load.py test.py test_url.py \
		test_advanced.py test_iolib.py test_readline.py; \
		do \
			$(call install_copy, pyserial, 0, 0, 0755, \
			$(PYSERIAL_DIR)/test/$$file, /usr/bin/$$file); \
		done
endif

# there are some test scripts that could be useful to check the installation
ifdef PTXCONF_PYSERIAL_TESTS
	@for file in enhancedserial.py scanlinux.py setup-miniterm-py2exe.py \
		tcp_serial_redirect.py port_publisher.py scan.py \
		setup-rfc2217_server-py2exe.py wxSerialConfigDialog.py \
		rfc2217_server.py scanwin32.py setup-wxTerminal-py2exe.py; \
		do \
			$(call install_copy, pyserial, 0, 0, 0755, \
			$(PYSERIAL_DIR)/examples/$$file, /usr/bin/$$file); \
		done
endif
	@$(call install_finish, pyserial)

	@$(call touch)

# vim: syntax=make
