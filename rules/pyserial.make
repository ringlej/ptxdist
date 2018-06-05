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
PYSERIAL_VERSION	:= 2.7
PYSERIAL_MD5		:= 794506184df83ef2290de0d18803dd11
PYSERIAL		:= pyserial-$(PYSERIAL_VERSION)
PYSERIAL_SUFFIX		:= tar.gz
PYSERIAL_URL		:= https://pypi.python.org/packages/source/p/pyserial/$(PYSERIAL).$(PYSERIAL_SUFFIX)
PYSERIAL_SOURCE		:= $(SRCDIR)/$(PYSERIAL).$(PYSERIAL_SUFFIX)
PYSERIAL_DIR		:= $(BUILDDIR)/$(PYSERIAL)
PYSERIAL_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYSERIAL_CONF_TOOL	:= python
PYSERIAL_MAKE_OPT	= build -e "/usr/bin/python$(PYTHON_MAJORMINOR)"


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

ifdef PTXCONF_PYSERIAL_MINITERM
	$(call install_copy, pyserial, 0, 0, 0755, -, /usr/bin/miniterm.py)
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
			$(call install_copy, pyserial, 0, 0, 0644, \
			$(PYSERIAL_DIR)/examples/$$file, /usr/share/pyserial/$$file); \
		done
endif
	@$(call install_finish, pyserial)

	@$(call touch)

# vim: syntax=make
