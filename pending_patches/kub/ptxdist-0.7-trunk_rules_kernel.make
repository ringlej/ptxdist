--- ptxdist-0.7-trunk/rules/kernel.make	Fri Aug  5 11:09:31 2005
+++ ptxdist-0.7.5-kub/rules/kernel.make	Thu Jul 14 12:50:57 2005
@@ -451,7 +451,7 @@
 
 	for i in $(KERNEL_TARGET_PATH); do 				\
 		if [ -f $$i ]; then					\
-			$(call install_copy, 0, 0, 0644, $$i, /boot/$(KERNEL_TARGET), n)\
+			$(call install_copy, 0, 0, 0644, $$$$i, /boot/$(KERNEL_TARGET), n)\
 		fi;							\
 	done
 	@$(call install_finish)
@@ -470,10 +470,11 @@
 
 	cd $(KERNEL_DIR) && $(KERNEL_PATH) make 			\
 		modules_install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(KERNEL_INST_DIR)
+	$(CROSS_STRIP) -S `find $(KERNEL_INST_DIR) -name '*o'`
 
 	cd $(KERNEL_INST_DIR) &&					\
 		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
-			$(call install_copy, 0, 0, 0664, $(KERNEL_INST_DIR)/$$file, $$file, n) \
+			$(call install_copy, 0, 0, 0664, $(KERNEL_INST_DIR)/$$$$file, $$$$file, n) \
 		done
 
 	rm -fr $(KERNEL_INST_DIR)
