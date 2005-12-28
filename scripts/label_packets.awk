#!/usr/bin/awk

#
# find lines matching PACKAGES-$(PTXCONF_APACHE2) += apache2
#
/^[[:blank:]]*PACKAGES-\$\(.*\)[[:blank:]]*\+\=.*[[:blank:]]*$/ {

	# remove everything but the label and packet name
	gsub(/^[[:blank:]]*PACKAGES-\$\(/,"")
	gsub(/\)[[:blank:]]*\+\=/,":")
	gsub(/[[:blank:]]/,"")
	
	print $0
}

