--- ptxdist-0.7-trunk/rules/nfs-utils.make	Fri Aug  5 11:09:31 2005
+++ ptxdist-0.7.5-kub/rules/nfs-utils.make	Thu Aug  4 10:40:40 2005
@@ -66,7 +66,8 @@
 # arcitecture dependend configuration
 #
 NFSUTILS_PATH		=  PATH=$(CROSS_PATH)
-NFSUTILS_ENV		+= CC_FOR_BUILD=$(HOSTCC) $(CROSS_ENV)
+NFSUTILS_ENV		+= $(CROSS_ENV) CPPFLAGS=""
+NFSUTILS_ENV		+= am_cv_CC_dependencies_compiler_type=gcc
 
 NFSUTILS_AUTOCONF	=  $(CROSS_AUTOCONF)
 
@@ -198,12 +199,18 @@
 	@$(call install_copy, 0, 0, 0644, \
 		$(NFSUTILS_DIR)/support/export/.libs/libexport.so.0.0.0, \
 		/usr/lib/libexport.so.0.0.0)
+	@$(call install_link, libexport.so.0.0.0, /usr/lib/libexport.so.0)
+	@$(call install_link, libexport.so.0.0.0, /usr/lib/libexport.so)
 	@$(call install_copy, 0, 0, 0644, \
 		$(NFSUTILS_DIR)/support/nfs/.libs/libnfs.so.0.0.0, \
 		/usr/lib/libnfs.so.0.0.0)
+	@$(call install_link, libnfs.so.0.0.0, /usr/lib/libnfs.so.0)
+	@$(call install_link, libnfs.so.0.0.0, /usr/lib/libnfs.so)
 	@$(call install_copy, 0, 0, 0644, \
 		$(NFSUTILS_DIR)/support/misc/.libs/libmisc.so.0.0.0, \
 		/usr/lib/libmisc.so.0.0.0)
+	@$(call install_link, libmisc.so.0.0.0, /usr/lib/libmisc.so.0)
+	@$(call install_link, libmisc.so.0.0.0, /usr/lib/libmisc.so)
 
 	# create stuff necessary for nfs
 	rm -rf $(ROOTDIR)/var/lib/nfs 
