--- ptxdist-0.7-trunk/rules/crosstool.make	Fri Aug  5 11:09:31 2005
+++ ptxdist-0.7.5-kub/rules/crosstool.make	Tue Jul 19 17:49:11 2005
@@ -113,7 +113,7 @@
 # Environment 
 #
 CROSSTOOL_ENV 	=  TARBALLS_DIR=$(SRCDIR)
-CROSSTOOL_ENV	+= RESULT_TOP=$(call remove_quotes,$(PTXCONF_PREFIX))
+CROSSTOOL_ENV	+= PREFIX=$(call remove_quotes,$(PTXCONF_PREFIX))
 CROSSTOOL_ENV	+= GCC_LANGUAGES="$(CROSSTOOL_GCCLANG)"
 CROSSTOOL_ENV	+= KERNELCONFIG=$(call remove_quotes,$(CROSSTOOL_DIR)/$(PTXCONF_CROSSTOOL_KERNELCONFIG))
 CROSSTOOL_ENV	+= TARGET=$(call remove_quotes,$(PTXCONF_GNU_TARGET))
@@ -174,7 +174,10 @@
 		echo "done" 						\
 		exit 1;							\
 	)
-	touch $(call remove_quotes,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/gcc-$(GCC_VERSION)-$(CROSSTOOL_LIBC_DIR)/$(PTXCONF_GNU_TARGET)/include/linux/autoconf.h)
+ifdef PTXCONF_UCLIBC
+	perl -i -p -e "s,-dynamic-linker[ \t]*/[^}]*},-dynamic-linker $(DYNAMIC_LINKER)},;" $(call remove_quotes,$(PTXCONF_PREFIX)/lib/gcc/$(PTXCONF_GNU_TARGET)/$(PTXCONF_GCC_VERSION)/specs)
+endif
+	touch $(call remove_quotes,$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/linux/autoconf.h)
 	touch $@
 
 # ----------------------------------------------------------------------------
