--- ptxdist-0.7-trunk/rules/ntp.make	Fri Aug  5 11:09:32 2005
+++ ptxdist-0.7.5-kub/rules/ntp.make	Fri Jul 29 15:07:36 2005
@@ -72,7 +72,7 @@
 
 NTP_PATH	=  PATH=$(CROSS_PATH)
 NTP_ENV 	=  $(CROSS_ENV)
-#NTP_ENV	+=
+NTP_ENV 	+=  am_cv_CC_dependencies_compiler_type=gcc
 
 #
 # autoconf
