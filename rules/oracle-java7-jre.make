# -*-makefile-*-
#
# Copyright (C) 2014 by Martin Hejnfelt <mh@newtec.dk>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_ORACLE_JAVA7_JRE) += oracle-java7-jre

#
# Paths and names
#
ifdef PTXCONF_ARCH_X86_64
ORACLE_JAVA7_JRE_ARCH		:= x64
ORACLE_JAVA7_JRE_MD5		:= 9007c79167be0177fb47e5313c53d5cb
else
ORACLE_JAVA7_JRE_ARCH		:= i586
ORACLE_JAVA7_JRE_MD5		:= 2a256eb2a91f0084e58c612636342c2b
endif

ORACLE_JAVA7_JRE_VERSION	:= 7u67

ORACLE_JAVA7_JRE		:= jre-$(ORACLE_JAVA7_JRE_VERSION)-linux-$(ORACLE_JAVA7_JRE_ARCH)
ORACLE_JAVA7_JRE_SUFFIX		:= tar.gz
ORACLE_JAVA7_JRE_URL		:= http://download.oracle.com/otn-pub/java/jdk/$(ORACLE_JAVA7_JRE_VERSION)-b01/$(ORACLE_JAVA7_JRE).$(ORACLE_JAVA7_JRE_SUFFIX);cookie:oraclelicense=accept-securebackup-cookie
ORACLE_JAVA7_JRE_SOURCE		:= $(SRCDIR)/$(ORACLE_JAVA7_JRE).$(ORACLE_JAVA7_JRE_SUFFIX)
ORACLE_JAVA7_JRE_DIR		:= $(BUILDDIR)/$(ORACLE_JAVA7_JRE)
ORACLE_JAVA7_JRE_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ORACLE_JAVA7_JRE_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/oracle-java7-jre.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/oracle-java7-jre.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/oracle-java7-jre.targetinstall:
	@$(call targetinfo)

	@$(call install_init, oracle-java7-jre)
	@$(call install_fixup, oracle-java7-jre,PRIORITY,optional)
	@$(call install_fixup, oracle-java7-jre,SECTION,base)
	@$(call install_fixup, oracle-java7-jre,AUTHOR,"Martin Hejnfelt <mh@newtec.dk>")
	@$(call install_fixup, oracle-java7-jre,DESCRIPTION,"Oracle Java 7 Runtime Environment")

	@$(call install_tree, oracle-java7-jre, -, -, \
		$(ORACLE_JAVA7_JRE_DIR), \
		/usr/lib/jvm/jre-$(ORACLE_JAVA7_JRE_VERSION))

	@$(call install_link, oracle-java7-jre, \
		/usr/lib/jvm/jre-$(ORACLE_JAVA7_JRE_VERSION)/bin/java, \
		/usr/bin/java)

	@$(call install_link, oracle-java7-jre, \
		/usr/lib/jvm/jre-$(ORACLE_JAVA7_JRE_VERSION)/bin/javaws, \
		/usr/bin/javaws)

	@$(call install_finish, oracle-java7-jre)

	@$(call touch)

# vim: syntax=make
