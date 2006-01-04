#!/bin/bash
# 
# Autogenerate Dependencies for Package-Makefiles
# 
# Arguments:  $1: command
#			  $2: label of the packet
# 			  $3 $4 Rules Directories
# 			  $5: Imagedir
# 			  $6: Statedir

DEBUG=true

label="$2"
RULESDIR="$3"
PROJECTRULESDIR="$4"
IMAGEDIR="$5"
STATEDIR="$6"

[ -z "$RULESDIR" ] || rulesfiles="$RULESDIR/* $rulesfiles"  
[ -z "$PROJECTRULESDIR" ] || rulesfiles="$PROJECTRULESDIR/* $rulesfiles"
[ -z "$rulesfiles" ] && exit 1

#
# helper functions
#
debug_out(){
[ $DEBUG ] && echo "$0: $1" >&2
}

debug_out "Rules set to $rulesfiles"

#
# identify package
#
my_target=$(grep -s "^PACKAGES-\$(PTXCONF_$(echo $label)" $rulesfiles | sed s/.*+=[\ ]//g)
debug_out "creating deoendencies for make target ${my_target}_${1}"

deps_extract(){
	#
	# minimal extract rule
	#
	echo "$STATEDIR/${my_target}.get"
}

deps_prepare(){
	#
	# 1) search $(IMAGEDIR)/configdeps for packet labels of dependees^
	# 2) find out packet name corresponding to these labels
	# 3) prepare deps are:
	#       $(STATEDIR)/thispacket.extract
	#       $(STATEDIR)/virtual-xchain.install
	#       $(STATEDIR)/dependee.install <- loop for all dependees  
	#
	
	#
	# identify dependencies
	#
	if [ -e "$IMAGEDIR/configdeps" ]; then
	 	debug_out "found dependency tree"
		echo -n "$STATEDIR/${my_target}.extract" 
		for dependency in $(grep "^DEP:$label" $IMAGEDIR/configdeps | sed -e s/^DEP:$label://g -e "s/:/\ /g"); do 
			targetname=$(grep -s "^PACKAGES-\$(PTXCONF_$(echo $dependency)" $rulesfiles | sed s/.*+=[\ ]//g)
			if [ -z "$targetname" ]; then
				debug_out "Package not identified for $dependency"
			else
				echo -n " $STATEDIR/$targetname.install"
			fi	
		done  
		echo " $STATEDIR/virtual-xchain.install"                                                       
	else
	        debug_out "ERROR - dependency tree not found" >&2
	fi
}

deps_compile(){
	#
	# 1) compile deps are:
	#       $(STATEDIR)/thispacket.prepare
	#
	echo "$STATEDIR/${my_target}.prepare"	
}

deps_install(){
	#
	# 1) install deps are:
	#       $(STATEDIR)/thispacket.compile
	#
	echo "$STATEDIR/${my_target}.compile"
}


deps_targetinstall(){
	#
	# 1) targetinstall deps are:
	#       $(STATEDIR)/thispacket.compile
	#       $(STATEDIR)/dependee.targetinstall <- loop for all dependees
	#

    #
    # identify dependencies
    #
    if [ -e "$IMAGEDIR/configdeps" ]; then
        debug_out "found dependency tree"
        for dependency in $(grep "^DEP:$label" $IMAGEDIR/configdeps | sed -e s/^DEP:$label://g -e "s/:/\ /g"); do
            targetname=$(grep -s "^PACKAGES-\$(PTXCONF_$(echo $dependency)" $rulesfiles | sed s/.*+=[\ ]//g)
            if [ -z "$targetname" ]; then
                debug_out "Package not identified for $dependency"
            else
                echo -n " $STATEDIR/$targetname.targetinstall"
            fi
        done
        echo "$STATEDIR/${my_target}.compile" 
    else
            debug_out "ERROR - dependency tree not found" >&2
    fi
}

#
# argument handling
#
case $1 in
	extract)
	deps_extract
	;;
	prepare)
	deps_prepare
	;;
	compile)
	deps_compile
	;;
	install)
	deps_install
	;;
	targetinstall)
	deps_targetinstall
	;;
esac

# vim: syntax=sh
# vim: tabstop=4
