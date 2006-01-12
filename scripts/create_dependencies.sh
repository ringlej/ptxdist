#!/bin/bash
# 
# Autogenerate Dependencies for Package-Makefiles
# 

FULLARGS="$@"

#DEBUG=true

#
# helper functions
#

debug_out(){
	[ $DEBUG ] && echo "$0: $1" >&2
}

my_exit(){
	debug_out "$0: $1"
	exit $2
}

usage() {
        echo 
        [ -n "$1" ] && echo -e "${PREFIX} error: $1\n"
        echo "usage: $0 <args>"
        echo
        echo " Arguments:"
        echo
        echo "  --action    defaults"
        echo "  --imagedir  <dir> 	  PTX Image Directory"
        echo "  --statedir  <dir>         PTX State Directory"
        echo "  --rulesdir  <dir>         PTX Rules Directory"
        echo "  --projectrulesdir <dir>   optional local Rules Directory"
        echo "  --dependency-file   <file>        optional outfile for default dependencies"
        echo
        exit 0
}

check_argument(){
case "$1" in 
	--*|"")
	debug_out "missing argument"
	return 1
	;;
	[[:alnum:]/]*)
	#debug_out "argument $1 accepted"
	return 0
	;;
esac
}

#
# Option parser
#
while [ $# -gt 0 ]; do
        case "$1" in
                --help) usage ;;
                --action)
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				ACTION="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                --imagedir) 		
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				IMAGEDIR="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                --statedir) 		
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				STATEDIR="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                --rulesdir) 		
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				RULESDIR="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                --projectrulesdir)  
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				PROJECTRULESDIR="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                --dependency-file)    	
			check_argument $2  		
			if [ "$?" == "0" ] ; then 
				OUTFILE="$2";      		
				shift 2 ;
			else	
				debug_out "skipping option $1";
				shift 1 ;
			fi
			;;
                *)  
			usage "unknown option $1" 
			;;
        esac
done

#
# Sanity checks
#

[ -z "$RULESDIR" ] || rulesfiles="$RULESDIR/*.make $rulesfiles"  
[ -z "$PROJECTRULESDIR" ] || rulesfiles="$PROJECTRULESDIR/*.make $rulesfiles"
[ -z "$rulesfiles" ] && my_exit "Insufficient Arguments - Rules missing" 1
[ -z "$IMAGEDIR" ] && my_exit "Insufficient Arguments - Image Directory missing" 1
[ -z "$STATEDIR" ] && my_exit "Insufficient Arguments State Directory missing" 1

debug_out "Rules set to $rulesfiles"

identify(){
	#
	# identify package
	#
	debug_out "--dependency-file set to: $OUTFILE"
	TARGET=$(basename $OUTFILE .dep)
	[ -z "$TARGET" ] && echo "# FIXME: dep file creation failed - broken package ?" > $OUTFILE
	[ -z "$TARGET" ] && DEBUG=true my_exit "ERROR while identifying target" 1
	# Nothing is true, everything is permitted (Illuminatus) 	
	TARGET_MAKEFILE_BASENAME=${TARGET}.make
	TARGET_MAKEFILE="NOT_DEFINED"
	if [ -n "$PROJECTRULESDIR" ] && [ -e "$PROJECTRULESDIR/$TARGET_MAKEFILE_BASENAME" ] ; then
		TARGET_MAKEFILE="$PROJECTRULESDIR/$TARGET_MAKEFILE_BASENAME"
	else
	   [ -e "$RULESDIR/$TARGET_MAKEFILE_BASENAME" ] && TARGET_MAKEFILE="$RULESDIR/$TARGET_MAKEFILE_BASENAME"
	fi
	debug_out "creating:"
	debug_out " RULESDIR=$RULESDIR"
	debug_out " PROJECTRULESDIR=$PROJECTRULESDIR"
	debug_out " OUTFILE=${OUTFILE}"
	debug_out " TARGET=${TARGET}"
	debug_out " TARGET_MAKEFILE=${TARGET_MAKEFILE}"
	LABEL=$(grep -s -h "^.*PACKAGES-\$(PTXCONF_" $TARGET_MAKEFILE | sed s/'^.*PACKAGES-$(PTXCONF_\(.*\)).*'/'\1'/g)
	[ -z "$LABEL" ] && echo "# FIXME: dep file creation failed - broken package ?" > $OUTFILE
	[ -z "$LABEL" ] && DEBUG=true my_exit "ERROR while identifying CONFIG LABEL  for $TARGET_MAKEFILE" 1
	debug_out "LABEL is: >$LABEL<"
}

deps_extract(){
	#
	# minimal extract rule
	#
	echo "${TARGET}_extract_deps_default := \$(STATEDIR)/${TARGET}.get"
}

deps_prepare(){
	#
	# 1) search $(RULESDIR)/configdeps for packet labels of dependees^
	# 2) find out packet name corresponding to these labels
	# 3) prepare deps are:
	#       $(STATEDIR)/thispacket.extract
	#       $(STATEDIR)/virtual-xchain.install
	#       $(STATEDIR)/dependee.install <- loop for all dependees  
	#
	
	#
	# identify dependencies
	#
	if [ -e "$RULESDIR/configdeps" ]; then
	 	debug_out "found dependency tree"
		echo -n "${TARGET}_prepare_deps_default := \$(STATEDIR)/${TARGET}.extract" 
		for dependency in $(grep "^DEP:$LABEL:" $RULESDIR/configdeps | sed -e s/^DEP:$LABEL://g -e "s/:/\ /g"); do 
			targetname=$(grep -s "^PACKAGES-\$(PTXCONF_$(echo $dependency))" $rulesfiles | sed s/.*+=[\ ]//g)
			if [ -z "$targetname" ]; then
				debug_out "Package not identified for $dependency"
			else
				echo -n " \$(STATEDIR)/${targetname}.install"
			fi	
		done  
		echo " \$(STATEDIR)/virtual-xchain.install"                                                       
	else
	        debug_out "ERROR - dependency tree not found" >&2
	fi
}

deps_compile(){
	#
	# 1) compile deps are:
	#       $(STATEDIR)/thispacket.prepare
	#
	echo "${TARGET}_compile_deps_default := \$(STATEDIR)/${TARGET}.prepare"	
}

deps_install(){
	#
	# 1) install deps are:
	#       $(STATEDIR)/thispacket.compile
	#
	echo "${TARGET}_install_deps_default := \$(STATEDIR)/${TARGET}.compile"
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
    if [ -e "$RULESDIR/configdeps" ]; then
        debug_out "found dependency tree"
	echo -n "${TARGET}_targetinstall_deps_default := " 
        for dependency in $(grep "^DEP:$LABEL:" $RULESDIR/configdeps | sed -e s/^DEP:$LABEL://g -e "s/:/\ /g"); do
            targetname=$(grep -s -h "^PACKAGES-\$(PTXCONF_$(echo $dependency))" $rulesfiles | sed s/.*+=[\ ]//g)
            if [ -z "$targetname" ]; then
		debug_out "Package not identified for $dependency"
            else
               debug_out "dependency: $dependency"
               debug_out "target: $targetname"
               echo -n " \$(STATEDIR)/${targetname}.targetinstall"
           fi
        done
        echo " \$(STATEDIR)/${TARGET}.compile" 
    else
            debug_out "ERROR - dependency tree not found" >&2
    fi
}

do_defaults(){
    #
    # write defaults to some file
    #
	identify
	debug_out "Writing default Dependencies for package $TARGET to file $OUTFILE"
	echo "# autogenerated by $(basename $0) - DO NOT EDIT" > $OUTFILE
	[ $DEBUG ] && echo "# options: $FULLARGS" >> $OUTFILE
	echo "# " >> $OUTFILE
	echo "# Package: $TARGET" >> $OUTFILE 
	[ $DEBUG ] && echo "# User: $(whoami)" >> $OUTFILE
	[ $DEBUG ] && echo "# Path: $(pwd)" >> $OUTFILE
	echo "# " >> $OUTFILE
	echo "$LABEL -> $OUTFILE"
	ACTION=extract deps_extract >> $OUTFILE
	ACTION=prepare deps_prepare >> $OUTFILE
	ACTION=compile deps_compile >> $OUTFILE
	ACTION=install deps_install >> $OUTFILE
	ACTION=targetinstall deps_targetinstall >> $OUTFILE
}

#
# argument handling
#
case $ACTION in
	defaults)
	do_defaults
	;;
	*)
	my_exit "Sorry, unknown --action specified: $ACTION"
	;;
esac

# vim: syntax=sh
# vim: tabstop=4
