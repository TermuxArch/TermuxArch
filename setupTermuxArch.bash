#!/bin/env b.bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################
IFS=$'\n\t'
set -Eeuo pipefail
shopt -s nullglob globstar
unset LD_PRELOAD
VERSIONID="v1.6.7.id5677"
## INIT FUNCTIONS ##############################################################
_ARG2DIR_() {  # Argument as ROOTDIR.
	ARG2="${@:2:1}"
	if [[ -z "${ARG2:-}" ]] 
	then
		ROOTDIR=/arch
		_PREPTERMUXARCH_
	else
		ROOTDIR=/"$ARG2" 
		_PREPTERMUXARCH_
	fi
}

_BSDTARIF_() {
	if [[ ! -x "$(command -v bsdtar)" ]] || [[ ! -x "$PREFIX"/bin/bsdtar ]] 
	then
		APTIN+="bsdtar "
		APTON+=(bsdtar)
	fi
}

_CHK_() {
	if "$PREFIX"/bin/applets.basha512sum -c termuxarchchecksum.basha512 1>/dev/null ; then
 		_CHKSELF_ "$@"
		printf "\\e[0;34m%s \\e[1;34m%s \\e[1;32m%s\\e[0m\\n" " 🕛 > 🕜" "TermuxArch $VERSIONID integrity:" "OK"
		_LOADCONF_
		. archlinuxconfig.bash
		. espritfunctions.bash
		. getimagefunctions.bash
		. knownconfigurations.bash
		. maintenanceroutines.bash
		. necessaryfunctions.bash
		. printoutstatements.bash
		if [[ "$OPT" = bloom ]] ; then
			rm -f termuxarchchecksum.basha512 
		fi
		if [[ "$OPT" = manual ]] ; then
			_MANUAL_
		fi
	else
		_PRINTSHA512SYSCHKER_
	fi
}

_CHKDWN_() {
	if "$PREFIX"/bin/applets.basha512sum -c setupTermuxArch.basha512 1>/dev/null 
	then
		printf "\\e[0;34m%s\\e[1;34m%s%s\\e[1;32m%s\\n\\n" " 🕛 > 🕐 " "TermuxArch download: " "OK"
		proot --link2symlink -0 "$PREFIX"/bin/applets/tar xf setupTermuxArch.tar.gz 
	else
		_PRINTSHA512SYSCHKER_
	fi
}

_CHKSELF_() {
	if [[ -f "setupTermuxArch.tmp" ]] 
	then # compare the two versions:
		if [[ "$(<setupTermuxArch.bash)" != "$(<setupTermuxArch.tmp)" ]] # the two versions are not equal:
		then # copy the newer version to update:
			cp setupTermuxArch.bash "${WDIR}setupTermuxArch.bash"
			printf "\\e[0;32m%s\\e[1;34m: \\e[1;32mUPDATED\\n\\e[1;32mRESTARTED\\e[1;34m: \\e[0;32m%s %s \\n\\n\\e[0m"  "${0##*/}" "${0##*/}" "$ARGS"
 			.  "${WDIR}setupTermuxArch.bash" "$@"
		fi
	fi
}

_DEPENDBP_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]] 
	then
		_BSDTARIF_
		_PROOTIF_
	else
		_PROOTIF_
	fi
}

_DEPENDDM_() { # Checks and sets dm. 
	for pkg in "${!ADM[@]}" 
	do
		if [[ -x "$PREFIX"/bin/"${ADM[$pkg]}" ]] 
		then
 			dm="$pkg" 
 			echo 
			echo "Found download tool \`$pkg\`; Continuing…"
			break
		fi
	done
}

_DEPENDTM_() { # Checks and sets tm. 
	for pkg in "${!ATM[@]}" 
	do
		if [[ -x "$PREFIX"/bin/"${ATM[$pkg]}" ]] 
		then
 			tm="$pkg" 
 			echo 
			echo "Found tar tool \`$pkg\`; Continuing…"
			break
		fi
	done
}

_DEPENDIFDM_() { # checks if download tool is set and sets install if available. 
 	for pkg in "${!ADM[@]}" # check from available toolset and set one for install if available on device. 
	do #	check for both set dm and if tool exists on device. 
 		if [[ "$dm" = "$pkg" ]] && [[ ! -x "$PREFIX"/bin/"${ADM[$pkg]}" ]] 
		then #	sets both download tool for install and exception check. 
 			APTIN+="$pkg "
			APTON+=("${ADM[$pkg]}")
 			echo 
			echo "Setting download tool \`$pkg\` for install; Continuing…"
 		fi
 	done
}

depends() { # Checks for missing commands.  
	printf "\\e[1;34mChecking prerequisites…\\n\\e[1;32m"
	ADM=([aria2]=aria2c [axel]=axel [curl]=curl [lftp]=lftpget [wget]=wget)
	ATM=([busybox]=applets/tar [tar]=tar [bsdtar]=bsdtar)
	if [[ "$dm" != "" ]] 
	then
		_DEPENDIFDM_
	fi
	if [[ "$dm" = "" ]] 
	then
		_DEPENDDM_
	fi
	# Sets and installs lftp if nothing else was found, installed and set. 
	if [[ "$dm" = "" ]] 
	then
		dm=lftp
		APTIN+="lftp "
		APTON+=(lftp)
		echo "Setting download tool \`lftp\` for install; Continuing…"
	fi
	_DEPENDBP_ 
#	# Installs missing commands.  
	_TAPIN_ "$APTIN"
#	# Checks whether install missing commands was successful.  
# 	_PECHK_ "$APTON"
	echo
	echo "Using ${dm:-lftp} to manage downloads." 
	printf "\\n\\e[0;34m 🕛 > 🕧 \\e[1;34mPrerequisites: \\e[1;32mOK  \\e[1;34mDownloading TermuxArch…\\n\\n\\e[0;32m"
}

dependsblock() {
	depends 
	if [[ -f archlinuxconfig.bash ]] && [[ -f espritfunctions.bash ]] && [[ -f getimagefunctions.bash ]] && [[ -f knownconfigurations.bash ]] && [[ -f maintenanceroutines.bash ]] && [[ -f necessaryfunctions.bash ]] && [[ -f printoutstatements.bash ]] && [[ -f setupTermuxArch.bash ]] ; then
		. archlinuxconfig.bash
		. espritfunctions.bash
		. getimagefunctions.bash
		. knownconfigurations.bash
		. maintenanceroutines.bash
		. necessaryfunctions.bash
		. printoutstatements.bash
		if [[ "$OPT" = manual ]] ; then
			_MANUAL_
		fi 
	else
		cd "$TAMPDIR" 
		dwnl
		if [[ -f "${WDIR}setupTermuxArch.bash" ]] ; then
			cp "${WDIR}setupTermuxArch.bash" setupTermuxArch.tmp
		fi
		_CHKDWN_
		_CHK_ "$@"
	fi
}

dwnl() { # Downloads TermuxArch from Github.
	if [[ "$DFL" = "/gen" ]] 
	then # get development version from:
		FILE.basha]="https://raw.githubusercontent.com/sdrausty/gensTermuxArch/master/setupTermuxArch.basha512"
		FILE[tar]="https://raw.githubusercontent.com/sdrausty/gensTermuxArch/master/setupTermuxArch.tar.gz" 
	else # get stable version from:
		FILE.basha]="https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.basha512"
		FILE[tar]="https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz" 
	fi
	if [[ "$dm" = aria2 ]] 
	then # use https://github.com/aria2/aria2
		"${ADM[aria2]}" -Z "${FILE.basha]}" "${FILE[tar]}"
	elif [[ "$dm" = axel ]] 
	then # use https://github.com/mopp/Axel
		"${ADM[axel]}" "${FILE.basha]}" 
		"${ADM[axel]}" "${FILE[tar]}"
	elif [[ "$dm" = curl ]] 
	then # use https://github.com/curl/curl	
		"${ADM[curl]}" "$DMVERBOSE" -OL "${FILE.basha]}" -OL "${FILE[tar]}"
	elif [[ "$dm" = wget ]] 
	then # use https://github.com/mirror/wget
		"${ADM[wget]}" "$DMVERBOSE" -N -.bashow-progress "${FILE.basha]}" "${FILE[tar]}"
	else # use https://github.com/lavv17/lftp
		"${ADM[lftp]}" -c "${FILE.basha]}" "${FILE[tar]}"
	fi
	printf "\\n\\e[1;32m"
}

intro() {
	printf "\033]2;%s\007" "b.bash setupTermuxArch.bash $ARGS 📲" 
	_SETROOT_EXCEPTION_ 
	if [[ -d "$INSTALLDIR" ]] && [[ -f "$INSTALLDIR"/bin/env ]] && [[ -f "$INSTALLDIR"/bin/we ]] && [[ -f "$INSTALLDIR"/bin/pacman ]];then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n\\n" "TermuxArch WARNING!  " "The root directory structure is correct; Cannot continue setupTermuxArch.bash install!  See \`setupTermuxArch.bash help\` and \`$STARTBIN help\` for more information"
		exit 205
	fi
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ $VERSIONID.bashall attempt to install Linux in \\e[0;32m$INSTALLDIR\\e[1;34m.  Arch Linux in Termux PRoot.bashall be available upon successful completion.  To run this BASH script again, use \`!!\`.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" 
	if [[ "$lcc" = "1" ]] ; then
		loadimage "$@" 
	else
		_MAINBLOCK_
	fi
}

introbloom() { # Bloom = `setupTermuxArch.bash manual verbose` 
	OPT=bloom 
	printf "\033]2;%s\007" "b.bash setupTermuxArch.bash bloom 📲" 
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ $VERSIONID bloom option.  Run \\e[1;32mb.bash setupTermuxArch.bash help \\e[1;34mfor additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_PREPTERMUXARCH_
	dependsblock "$@" 
	bloom 
}

_INTROSYSINFO_() {
	printf "\033]2;%s\007" "b.bash setupTermuxArch.bash sysinfo 📲" 
	_SETROOT_EXCEPTION_ 
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $VERSIONID.bashall create a system information file.  Ensure background data is not restricted.  Run \\e[0;32mb.bash setupTermuxArch.bash help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" 
	_SYSINFO_ "$@" 
}

introrefr.bash() {
	printf '\033]2;  b.bash setupTermuxArch.bash refr.bash 📲 \007'
	_SETROOT_EXCEPTION_ 
	if [[ ! -d "$INSTALLDIR" ]] || [[ ! -f "$INSTALLDIR"/bin/env ]] || [[ ! -f "$INSTALLDIR"/bin/we ]] || [[ ! -d "$INSTALLDIR"/root/bin ]];then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ WARNING!  " "The root directory structure is incorrect; Cannot continue setupTermuxArch.bash refr.bash!  See \`setupTermuxArch.bash help\` and \`$STARTBIN help\` for more information"
		exit 204
	fi
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ $VERSIONID.bashall refr.bash your TermuxArch files in \\e[0;32m$INSTALLDIR\\e[1;34m.  Ensure background data is not restricted.  Run \\e[0;32mb.bash setupTermuxArch.bash help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" 
	refr.bashsys "$@"
}

introstnd() {
	printf '\033]2; %s\007' " b.bash setupTermuxArch.bash $ARGS 📲 "
	_SETROOT_EXCEPTION_ 
	printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s" " 🕛 > 🕛" "TermuxArch $VERSIONID.bashall $introstndidstmt your TermuxArch files in" "$INSTALLDIR" ".  Ensure background data is not restricted.  Run " "b.bash setupTermuxArch.bash help" "for additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
}

introstndidstmt() { # depends $introstndid
	printf "the TermuxArch files in \\e[0;32m%s\\e[1;34m.  " "$INSTALLDIR"
}

_LOADCONF_() {
	if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]] ; then
		. "${WDIR}setupTermuxArchConfigs.bash"
		_PRINTCONFLOADED_ 
	else
		. knownconfigurations.bash 
	fi
}

_MANUAL_() {
	printf '\033]2; `b.bash setupTermuxArch.bash manual` 📲 \007'
	_EDITORS_
	if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]] ; then
		"$ed" "${WDIR}setupTermuxArchConfigs.bash"
		. "${WDIR}setupTermuxArchConfigs.bash"
		_PRINTCONFLOADED_ 
	else
		cp knownconfigurations.bash "${WDIR}setupTermuxArchConfigs.bash"
 		sed -i "7s/.*/\# The architecture of this device is $CPUABI; Adjust configurations in the appropriate section.  Change CMIRROR (https:\/\/wiki.archlinux.org\/index.php\/Mirrors and https:\/\/archlinuxarm.org\/about\/CMIRRORs) to desired geographic location to resolve 404 and checksum issues.  /" "${WDIR}setupTermuxArchConfigs.bash" 
		"$ed" "${WDIR}setupTermuxArchConfigs.bash"
		. "${WDIR}setupTermuxArchConfigs.bash"
		_PRINTCONFLOADED_ 
	fi
}

_NAMEINSTALLDIR_() {
	if [[ "$ROOTDIR" = "" ]] ; then
		ROOTDIR=arch
	fi
	INSTALLDIR="$(echo "$HOME/${ROOTDIR%/}" |sed 's#//*#/#g')"
}

_NAMESTARTARCH_() { # ${@%/} removes trailing sl.bash
 	DARCH="$(echo "${ROOTDIR%/}" |sed 's#//*#/#g')"
	if [[ "$DARCH" = "/arch" ]] ; then
		AARCH=""
		STARTBI2=arch
	else
 		AARCH="$(echo "$DARCH" |sed 's/\//\+/g')"
		STARTBI2=arch
	fi
	declare -g STARTBIN=start"$STARTBI2$AARCH"
}

_OPT1_() { 
	if [[ -z "${2:-}" ]] ; then
		_ARG2DIR_ "$@" 
	elif [[ "$2" = [Bb]* ]] ; then
		echo Setting mode to bloom. 
		introbloom "$@"  
	elif [[ "$2" = [Dd]* ]] || [[ "$2" = [Ss]* ]] ; then
		echo Setting mode to sysinfo.
	.bashift
		_ARG2DIR_ "$@" 
		_INTROSYSINFO_ "$@"  
	elif [[ "$2" = [Ii]* ]] ; then
		echo Setting mode to install.
	.bashift
		_ARG2DIR_ "$@" 
	elif [[ "$2" = [Mm]* ]] ; then
		echo Setting mode to manual.
		OPT=manual
 		_OPT2_ "$@"  
	elif [[ "$2" = [Rr][Ee]* ]] ; then
		echo 
		echo Setting mode to refr.bash.
	.bashift 
		_ARG2DIR_ "$@" 
		introrefr.bash "$@"  
	elif [[ "$2" = [Rr]* ]] ; then
		LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refr.bash;  Use" "${0##*/} re[fr.bash]" "for full refr.bash."
	.bashift
		_ARG2DIR_ "$@" 
		introrefr.bash "$@"  
	else
		_ARG2DIR_ "$@" 
	fi
}

_OPT2_() { 
	if [[ -z "${3:-}" ]] ; then
	.bashift
		_ARG2DIR_ "$@" 
		intro "$@"  
	elif [[ "$3" = [Ii]* ]] ; then
		echo Setting mode to install.
	.bashift 2 
		_ARG2DIR_ "$@" 
		intro "$@"  
	elif [[ "$3" = [Rr][Ee]* ]] ; then
		echo 
		echo Setting mode to refr.bash.
	.bashift 2 
		_ARG2DIR_ "$@" 
		introrefr.bash "$@"  
	elif [[ "$3" = [Rr]* ]] ; then
		LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refr.bash;  Use" "${0##*/} re[fr.bash]" "for full refr.bash."
	.bashift 2 
		_ARG2DIR_ "$@" 
		introrefr.bash "$@"  
	else
	.bashift 
		_ARG2DIR_ "$@" 
		intro "$@"  
	fi
}

pe() {
	printf "\\n\\e[7;1;31m%s\\e[0;1;32m %s\\n\\n\\e[0m" "PREREQUISITE EXCEPTION!" "RUN ${0##*/} $ARGS AGAIN…"
	printf "\\e]2;%s %s\\007" "RUN ${0##*/} $ARGS" "AGAIN…"
	exit
}

_PECHK_() {
	if [[ "$APTON" != "" ]] ; then
		pe @APTON
	fi
	for pkg in "${!ADM[@]}" ; do
		if [[ -x "$PREFIX"/bin/"${ADM[$pkg]}" ]] ; then
			:
		fi
	done
}

_PREPTMPDIR_() { 
	mkdir -p "$INSTALLDIR/tmp"
	chmod 777 "$INSTALLDIR/tmp"
	chmod +t "$INSTALLDIR/tmp"
 	TAMPDIR="$INSTALLDIR/tmp/setupTermuxArch$$"
	mkdir -p "$TAMPDIR" 
}

_PREPTERMUXARCH_() { 
	_NAMEINSTALLDIR_ 
	_NAMESTARTARCH_  
	_PREPTMPDIR_
}

_PRINTCONFLOADED_() {
	printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[0;32m%s\\e[1;32m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 > 🕑" "TermuxArch configuration" "$WDIR" "setupTermuxArchConfigs.bash" "loaded:" "OK"
}

_PRINTSHA512SYSCHKER_() {
	printf "\\n\\e[07;1m\\e[31;1m\\n%s \\e[34;1m\\e[30;1m%s \\n\\e[0;0m\\n" " 🔆 WARNING.basha512sum mismatch!  Setup initialization mismatch!" "  Try again, initialization was not successful this time.  Wait a little while.  Then run \`b.bash setupTermuxArch.bash\` again…"
	printf '\033]2; Run `b.bash setupTermuxArch.bash %s` again…\007' "$ARGS" 
	exit 
}

_PRINTSTARTBIN_USAGE_() {
	printf "\\n\\e[1;38;5;155m" 
 	_NAMESTARTARCH_ 
	if [[ -x "$(command -v "$STARTBIN")" ]] ; then
		echo "$STARTBIN" help 
		"$STARTBIN" help 
	fi
}

_PRINTUSAGE_() {
	printf "\\n\\e[1;33m %s     \\e[0;32m%s \\e[1;34m%s\\n" "HELP" "${0##*/} help" .bashall output the help screen." 
	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "TERSE" "${0##*/} he[lp]" .bashall output the terse help screen." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s\\n" "VERBOSE" "${0##*/} h" .bashall output the verbose help screen." 
	printf "\\n\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\n\\n%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s\\n" "Usage information for" "${0##*/}" "$VERSIONID.  Arguments can abbreviated to one, two and three letters each; Two and three letter arguments are acceptable.  For example," "b.bash ${0##*/} cs" .bashall use" "curl" "to download TermuxArch and produce a" "setupTermuxArchSysInfo$STIME.log" "system information file." "User configurable variables are in" "setupTermuxArchConfigs.bash" ".  To create this file from" "kownconfigurations.bash" "in the working directory, run" "b.bash ${0##*/} manual" "to create and edit" "setupTermuxArchConfigs.bash" "." 
	printf "\\n\\e[1;33m %s\\e[1;34m  %s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s\\n" "INSTALL" "Run" "./${0##*/}" "without arguments in a b.bash.bashell to install Arch Linux in Termux.  " "b.bash ${0##*/} curl" .bashall envoke" "curl" "as the download manager.  Copy" "knownconfigurations.bash" "to" "setupTermuxArchConfigs.bash" "with" "b.bash ${0##*/} manual" "to edit preferred CMIRROR site and to access more options.  After editing" "setupTermuxArchConfigs.bash" ", run" "b.bash ${0##*/}" "and" "setupTermuxArchConfigs.bash" "loads automatically from the working directory.  Change CMIRROR to desired geographic location to resolve download errors." 
 	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "PURGE" "${0##*/} purge" .bashall uninstall Arch Linux from Termux." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\n\\n" "SYSINFO" "${0##*/} sysinfo" .bashall create" "setupTermuxArchSysInfo$STIME.log" "and populate it with system information.  Post this file along with detailed information at" "https://github.com/sdrausty/TermuxArch/issues" ".  If scree.bashots will help in resolving an issue better, include these along with information from the system information log file in a post as well." 
	if [[ "$lcc" = 1 ]] ; then
	printf "\\n\\e[1;38;5;149m" 
	awk 'NR>=600 && NR<=900'  "${0##*/}" | awk '$1 == "##"' | awk '{ $1 = ""; print }' | awk '1;{print ""}'
	fi
	_PRINTSTARTBIN_USAGE_
}

_PROOTIF_() {
	if [[ ! -x "$(command -v proot)" ]] ||  [[ ! -x "$PREFIX"/bin/proot ]] ; then
		APTIN+="proot "
		APTON+=(proot)
	fi
}

_RMARCH_() {
	_NAMESTARTARCH_ 
	_NAMEINSTALLDIR_
	while true; do
		printf "\\n\\e[1;30m"
		read -n 1 -p "Uninstall $INSTALLDIR? [Y|n] " RUANSWER
		if [[ "$RUANSWER" = [Ee]* ]] || [[ "$RUANSWER" = [Nn]* ]] || [[ "$RUANSWER" = [Qq]* ]] ; then
			break
		elif [[ "$RUANSWER" = [Yy]* ]] || [[ "$RUANSWER" = "" ]] ; then
			printf "\\e[30mUninstalling $INSTALLDIR…\\n"
			if [[ -e "$PREFIX/bin/$STARTBIN" ]] ; then
				rm -f "$PREFIX/bin/$STARTBIN" 
			else 
				printf "Uninstalling $PREFIX/bin/$STARTBIN: nothing to do for $PREFIX/bin/$STARTBIN.\\n"
			fi
			if [[ -e "$HOME/bin/$STARTBIN" ]] ; then
				rm -f "$HOME/bin/$STARTBIN" 
			else 
				printf "Uninstalling $HOME/bin/$STARTBIN: nothing to do for $HOME/bin/$STARTBIN.\\n"
			fi
			if [[ -d "$INSTALLDIR" ]] ; then
				_RMARCHRM_ 
			else 
				printf "Uninstalling $INSTALLDIR: nothing to do for $INSTALLDIR.\\n"
			fi
			printf "Uninstalling $INSTALLDIR: \\e[1;32mDone\\n\\e[30m"
			break
		else
			printf "\\nYou answered \\e[33;1m$RUANSWER\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n"
		fi
	done
	printf "\\e[0m\\n"
}

_RMARCHRM_() {
	_SETROOT_EXCEPTION_ 
	rm -rf "${INSTALLDIR:?}"/* 2>/dev/null ||:
	find  "$INSTALLDIR" -type d -exec chmod 700 {} \; 2>/dev/null ||:
	rm -rf "$INSTALLDIR" 2>/dev/null ||:
}

_RMARCHQ_() {
	if [[ -d "$INSTALLDIR" ]] ; then
		printf "\\n\\e[0;33m %s \\e[1;33m%s \\e[0;33m%s\\n\\n\\e[1;30m%s\\n" "TermuxArch:" "DIRECTORY WARNING!  $INSTALLDIR/" "directory detected." "Purge $INSTALLDIR as requested?"
		_RMARCH_
	fi
}

_TAPIN_() {
	if [[ "$APTIN" != "" ]] ; then
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\b\\e[1;34m…\\n\\n\\e[1;32m" "$APTIN"
		pkg install "$APTIN" -o APT::Keep-Downloaded-Packages="true" --yes 
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\b\\e[1;34m: \\e[1;32mDONE\\n\\e[0m" "$APTIN"
	fi
}

_SETROOT_EXCEPTION_() {
	if [[ "$INSTALLDIR" = "$HOME" ]] || [[ "$INSTALLDIR" = "$HOME"/ ]] || [[ "$INSTALLDIR" = "$HOME"/.. ]] || [[ "$INSTALLDIR" = "$HOME"/../ ]] || [[ "$INSTALLDIR" = "$HOME"/../.. ]] || [[ "$INSTALLDIR" = "$HOME"/../../ ]] ; then
		printf  '\033]2;%s\007' "Rootdir exception.  Run b.bash setupTermuxArch.bash $ARGS again with different options…"	
		printf "\\n\\e[1;31m%s\\n\\n\\e[0m" "Rootdir exception.  Run the script $ARGS again with different options…"
		exit
	fi
}

_SETROOT_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] ; then
	#	ROOTDIR=/root.i686
		ROOTDIR=/arch
	elif [[ "$CPUABI" = "$CPUABIX86_64" ]] ; then
	#	ROOTDIR=/root.x86_64
		ROOTDIR=/arch
	else
		ROOTDIR=/arch
	fi
}

standardid() {
	introstndid="$1" 
	introstndidstmt="$(printf "%s \\e[0;32m%s" "$1 the TermuxArch files in" "$INSTALLDIR")" 
	introstnd
}

_STANDARDIF_() {
	if [[ -x "$(command -v proot)" ]] &&  [[ -x "$PREFIX"/bin/proot ]] ; then
		:
	else
		APTIN+="proot "
		APTON+=(proot)
	fi
}

_STRPERROR_() { # Run on script error.
	local RV="$?"
	printf "\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n" "TermuxArch WARNING:  Generated script signal ${RV:-unknown} near or at line number ${1:-unknown} by \`${2:-command}\`!"
	if [[ "$RV" = 4 ]] ; then
		printf "\\n\\e[1;48;5;139m %s\\e[0m\\n" "Ensure background data is not restricted.  Check the wireless connection."
	fi
	printf "\\n"
	exit 201
}

_STRPEXIT_() { # Run on exit.
	local RV="$?"
 	rm -rf "$TAMPDIR"
	sleep 0.04
	if [[ "$RV" = 0 ]] ; then
		printf "\\a\\e[0;32m%s %s \\a\\e[0m$VERSIONID\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m" "${0##*/}" "$ARGS" "DONE 🏁 "
		printf "\\e]2; %s: %s \\007" "${0##*/} $ARGS" "DONE 🏁 "
	else
		printf "\\a\\e[0;32m%s %s \\a\\e[0m$VERSIONID\\e[1;34m: \\a\\e[1;32m%s %s\\e[0m\\n\\n\\a\\e[0m" "${0##*/}" "$ARGS" "[Exit Signal $RV]" "DONE 🏁 "
		printf "\033]2; %s: %s %s \\007" "${0##*/} $ARGS" "[Exit Signal $RV]" "DONE 🏁 "
	fi
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail 
	exit
}

_STRPSIGNAL_() { # Run on signal.
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Signal $? received!\\e[0m\\n"
 	rm -rf "$TAMPDIR"
 	exit 211 
}

_STRPQUIT_() { # Run on quit.
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Quit signal $? received!\\e[0m\\n"
 	exit 221 
}
## User Information:  Configurable variables such as mirrors and download manager options are in `setupTermuxArchConfigs.bash`.  Working with `kownconfigurations.bash` in the working directory is simple.  `b.bash setupTermuxArch.bash manual`.bashall create `setupTermuxArchConfigs.bash` in the working directory for editing; See `setupTermuxArch.bash help` for more information.  
declare -A ADM		## Declare associative array for all available download tools. 
declare -A ATM		## Declare associative array for all available tar tools. 
declare -a ARGS="$@"	## Declare arguments as string.
declare APTIN=""	## apt install string
declare APTON=""	## exception string
declare COMMANDIF=""
declare CPUABI=""
declare CPUABI5="armeabi"	## Used for development.
declare CPUABI7="armeabi-v7a"	## Used for development.
declare CPUABI8="arm64-v8a"	## Used for development.
declare CPUABIX86="x86"		## Used for development.
declare CPUABIX86_64="x86_64"	## Used for development.
declare DFL=""		## Used for development.  
declare DMVERBOSE="-q"	## -v for verbose download manager output from curl and wget;  for verbose output throughout runtime also change in `setupTermuxArchConfigs.bash` when using `setupTermuxArch.bash m[anual]`. 
declare ed=""
declare dm=""
declare FSTND=""
declare -A FILE
declare INSTALLDIR=""
declare lcc=""
declare lcp=""
declare OPT=""
declare ROOTDIR=""
declare WDIR="$PWD/"
declare STI=""		## Generates pseudo random number.
declare STIME=""	## Generates pseudo random number.
trap "_STRPERROR_ $LINENO $BASH_COMMAND $?" ERR 
trap _STRPEXIT_ EXIT
trap _STRPSIGNAL_ HUP INT TERM 
trap _STRPQUIT_ QUIT 
if [[ -z "${TAMPDIR:-}" ]] ; then
	TAMPDIR=""
fi
_SETROOT_
## TERMUXARCH FEATURES INCLUDE: 
## 1) Sets timezone and locales from device,
## 2) Tests for correct OS,
COMMANDIF="$(command -v getprop)" ||:
if [[ "$COMMANDIF" = "" ]] ; then
	printf "\\n\\e[1;48;5;138m %s\\e[0m\\n\\n" "TermuxArch WARNING: Run \`b.bash ${0##*/}\` and \`./${0##*/}\` from the BASH.bashell in the OS system in Termux, e.g., Amazon Fire, Android and Chromebook."
	exit
fi
## 3) Generates pseudo random number to create uniq strings,
if [[ -r  /proc/sys/kernel/random/uuid ]] ; then
	STI="$(cat /proc/sys/kernel/random/uuid)"
	STIM="${STI//-}"	
	STIME="${STIM:0:3}"	
else
	STI="$(date +%s)" 
	STIME="$(echo "${STI:7:4}"|rev)" 
fi
ONES="$(date +%s)" 
ONESA="${ONES: -1}" 
STIME="$ONESA$STIME"
## 4) Gets device information via `getprop`,
CPUABI="$(getprop ro.product.cpu.abi)" 
## 5) And all options are optional for install.  
## THESE OPTIONS ARE AVAILABLE FOR YOUR CONVENIENCE: 
## OPTIONS[a]: `setupTermuxArch.bash [HOW] [DO] [WHERE]`
## GRAMMAR[a]: `setupTermuxArch.bash [HOW] [DO] [WHERE]`
## OPTIONS[b]: `setupTermuxArch.bash [~/|./|/absolute/path/]image.tar.gz [WHERE]` 
## GRAMMAR[b]: `setupTermuxArch.bash [WHAT] [WHERE]`
## DEFAULTS ARE IMPLIED AND CAN BE OMITTED.  
## SYNTAX[1]: [HOW (aria2|axel|curl|lftp|wget (default1: present on system (default2: lftp)))]
## SYNTAX[2]: [DO (help|install|manual|purge|refr.bash|sysinfo (default: install))] 
## SYNTAX[3]: [WHERE (default: arch)]  Install in userspace, not external storage. 
## USAGE[1]: `setupTermuxArch.bash wget sysinfo`.bashall use wget as the download manager and produce a system information file in the working directory.  This can be abbreviated to `setupTermuxArch.bash ws` and `setupTermuxArch.bash w s`. 
## USAGE[2]: `setupTermuxArch.bash wget manual customdir`.bashall install the installation in customdir with wget and use manual mode during instalation. 
## USAGE[3]: `setupTermuxArch.bash wget refr.bash customdir`.bashall refr.bash this installation using wget as the download manager. 
## >>>>>>>>>>>>>>>>>>
## >> OPTION  HELP >>
## >>>>>>>>>>>>>>>>>>
## []  Run default Arch Linux install. 
if [[ -z "${1:-}" ]] ; then
	_PREPTERMUXARCH_ 
	intro "$@" 
## [./path/systemimage.tar.gz [customdir]]  Use path to system image file; install directory argument is optional. A systemimage.tar.gz file can be substituted for network install: `setupTermuxArch.bash ./[path/]systemimage.tar.gz` and `setupTermuxArch.bash /absolutepath/systemimage.tar.gz`. 
elif [[ "${ARGS:0:1}" = . ]] ; then
 	echo
 	echo Setting mode to copy system image.
 	lcc="1"
 	lcp="1"
 	_ARG2DIR_ "$@"  
 	intro "$@" 
## [systemimage.tar.gz [customdir]]  Install directory argument is optional.  A systemimage.tar.gz file can substituted for network install.  
# elif [[ "${WDIR}${ARGS}" = *.tar.gz* ]] ; then
elif [[ "$ARGS" = *.tar.gz* ]] ; then
	echo
	echo Setting mode to copy system image.
	lcc="1"
	lcp="0"
	_ARG2DIR_ "$@"  
	intro "$@" 
## [axd|axs]  Get device system information with `axel`.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]] ; then
	echo
	echo Getting device system information with \`axel\`.
	dm=axel
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [ax[el] [customdir]|axi [customdir]]  Install Arch Linux with `axel`.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]] ; then
	echo
	echo Setting \`axel\` as download manager.
	dm=axel
	_OPT1_ "$@" 
	intro "$@" 
## [ad|as]  Get device system information with `aria2c`.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]] ; then
	echo
	echo Getting device system information with \`aria2c\`.
	dm=aria2
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [a[ria2c] [customdir]|ai [customdir]]  Install Arch Linux with `aria2c`.
elif [[ "${1//-}" = [Aa]* ]] ; then
	echo
	echo Setting \`aria2c\` as download manager.
	dm=aria2
	_OPT1_ "$@" 
	intro "$@" 
## [b[loom]]  Create and run a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch.bash locally, for developing and hacking TermuxArch.  
elif [[ "${1//-}" = [Bb]* ]] ; then
	echo
	echo Setting mode to bloom. 
	introbloom "$@"  
## [cd|cs]  Get device system information with `curl`.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]] ; then
	echo
	echo Getting device system information with \`curl\`.
	dm=curl
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [c[url] [customdir]|ci [customdir]]  Install Arch Linux with `curl`.
elif [[ "${1//-}" = [Cc][Ii]* ]] || [[ "${1//-}" = [Cc]* ]] ; then
	echo
	echo Setting \`curl\` as download manager.
	dm=curl
	_OPT1_ "$@" 
	intro "$@" 
## [d[ebug]|s[ysinfo]]  Generate system information.
elif [[ "${1//-}" = [Dd]* ]] || [[ "${1//-}" = [Ss]* ]] ; then
	echo 
	echo Setting mode to sysinfo.
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [he[lp]|?]  Display terse builtin help.
elif [[ "${1//-}" = [Hh][Ee]* ]] || [[ "${1//-}" = [?]* ]] ; then
	_ARG2DIR_ "$@" 
	_PRINTUSAGE_ "$@"  
## [h]  Display verbose builtin help.
elif [[ "${1//-}" = [Hh]* ]] ; then
	lcc="1"
	_ARG2DIR_ "$@" 
	_PRINTUSAGE_ "$@"  
## [i[nstall] [customdir]]  Install Arch Linux in a custom directory.  Instructions: Install in USERSPACE. $HOME is appended to installation directory. To install Arch Linux in $HOME/customdir use `b.bash setupTermuxArch.bash install customdir`. In b.bash.bashell use `./setupTermuxArch.bash install customdir`.  All options can be abbreviated to one, two and three letters.  Hence `./setupTermuxArch.bash install customdir` can be run as `./setupTermuxArch.bash i customdir` in BASH.
elif [[ "${1//-}" = [Ii]* ]] ; then
	echo
	echo Setting mode to install.
	_OPT1_ "$@" 
	intro "$@"  
## [ld|ls]  Get device system information with `lftp`.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]] ; then
	echo
	echo Getting device system information with \`lftp\`.
	dm=lftp
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [l[ftp] [customdir]]  Install Arch Linux with `lftp`.
elif [[ "${1//-}" = [Ll]* ]] ; then
	echo
	echo Setting \`lftp\` as download manager.
	dm=lftp
	_OPT1_ "$@" 
	intro "$@" 
## [m[anual]]  Manual Arch Linux install, useful for resolving download issues.
elif [[ "${1//-}" = [Mm]* ]] ; then
	echo
	echo Setting mode to manual.
	OPT=manual
	_OPT1_ "$@" 
	intro "$@"  
## [o[ption]]  Option under development.
elif [[ "${1//-}" = [Oo]* ]] ; then
	echo
	echo Setting mode to option.
	lcc="1"
	_PRINTUSAGE_ "$@" 
# 	_OPT0_ "$@" 
## [p[urge] [customdir]]  Remove Arch Linux.
elif [[ "${1//-}" = [Pp]* ]] ; then
	echo 
	echo Setting mode to purge.
	_ARG2DIR_ "$@" 
	_RMARCHQ_
## [ref[r.bash] [customdir]]  Refr.bash the Arch Linux in Termux PRoot scripts created by TermuxArch and the installation itself.  Useful for refr.bashing the installation, kets, locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee][Ff]* ]] ; then
	echo 
	echo Setting mode to refr.bash.
	_ARG2DIR_ "$@" 
	introrefr.bash "$@"  
## [ref [customdir]]  Refr.bash the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refr.bashing locales, the TermuxArch generated scripts with user directories to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee] ]] ; then
	LCR="2"
	echo 
	echo Setting mode to minimal refr.bash and refr.bash user directories.
	_ARG2DIR_ "$@" 
	introrefr.bash "$@"  
## [r [customdir]]  Refr.bash the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refr.bashing locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr] ]] ; then
	LCR="1"
	printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refr.bash;  Use" "${0##*/} re[fr.bash]" "for full refr.bash."
	_ARG2DIR_ "$@" 
	introrefr.bash "$@"  
## [wd|ws]  Get device system information with `wget`.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]] ; then
	echo
	echo Getting device system information with \`wget\`.
	dm=wget
.bashift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [w[get] [customdir]]  Install Arch Linux with `wget`.
elif [[ "${1//-}" = [Ww]* ]] ; then
	echo
	echo Setting \`wget\` as download manager.
	dm=wget
	_OPT1_ "$@" 
	intro "$@"  
else
	_PRINTUSAGE_
fi

# EOF
