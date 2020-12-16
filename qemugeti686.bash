#!/usr/bin/env bash
# copyright 2020 (c) by SDRausty, all rights reserved, see LICENSE
################################################################################
set -eu
declare LATESTI686
_INST_() { # checks for neccessary commands
COMMS="$1"
COMMANDR="$(command -v au)" || (printf "%s\\n\\n" "$STRING1")
COMMANDIF="${COMMANDR##*/}"
STRING1="COMMAND \`au\` enables rollback, available at https://wae.github.io/au/ IS NOT FOUND: Continuing... "
STRING2="Cannot update ~/${0##*/} prerequisite: Continuing..."
PKG="$2"
_INPKGS_() {
printf "%s\\n" "Beginning qemu 'qemu-system-i386' setup:"
if [ "$COMMANDIF" = au ]
then
au "$PKG" || printf "%s\\n" "$STRING2"
else
apt install "$PKG" || printf "%s\\n" "$STRING2"
fi
}
if ! command -v "$COMMS"
then
_INPKGS_
fi
}
_BOOTISO_() {
qemu-system-i386 -m 512M -nographic -cdrom "$1"
}
_PSGI1ESTRING_() {	# print signal generated in arg 1 format
printf "\\e[1;33mSIGNAL GENERATED in %s\\e[1;34m : \\e[1;32mCONTINUING...  \\e[0;34mExecuting \\e[0;32m%s\\e[0;34m in the native shell once the installation and configuration process completes will attempt to finish the autoconfiguration and installation if the installation and configuration processes were not completely successful.  Should better solutions for \\e[0;32m%s\\e[0;34m be found, please open an issue and accompanying pull request if possible.\\nThe entire script can be reviewed by creating a \\e[0;32m%s\\e[0;34m directory with the command \\e[0;32m%s\\e[0;34m which can be used to access the entire installation script.  This option does NOT configure and install the root file system.  This command transfers the entire script into the home directory for hacking, modification and review.  The command \\e[0;32m%s\\e[0;34m has more information about how to use use \\e[0;32m%s\\e[0;34m in an effective way.\\e[0;32m%s\\e[0m\\n" "'$1'" "'bash ${0##*/} refresh'" "'${0##*/}'" "'~/TermuxArchBloom/'" "'setupTermuxArch b'" "'setupTermuxArch help'" "'${0##*/}'"
}
if ! command -v qemu-system-i386
then
_INST_ qemu-system-i386 qemu-system-i386-headless "${0##*/}" || _PSGI1ESTRING_ "_INST_ qemu-system-i386 ${0##*/}"
fi
[ -f sha512sums ] && printf "%s\\n\\n" "Found sha512sums file." || curl -OL https://mirror.math.princeton.edu/pub/archlinux32/archisos/sha512sums
LATESTI686="$(grep i686 sha512sums |tail -n 1)"
printf "%s\\n\\n" "Found filename '${LATESTI686##* }' with sha512sum ${LATESTI686%% *}."
[ -f "${LATESTI686##* }" ] && printf "%s\\n\\n" "Found filename '${LATESTI686##* }'." || curl -OL "https://mirror.math.princeton.edu/pub/archlinux32/archisos/${LATESTI686##* }"
printf "%s\\n\\n" "Checking file '${LATESTI686##* }' with sha512sum."
LATESTI686ISO="$(sha512sum "${LATESTI686##* }")"
if [[ "$LATESTI686ISO" == "$LATESTI686" ]]
then
_BOOTISO_ "${LATESTI686##* }"
else
printf "%s\\n\\n" "Checking file '${LATESTI686##* }' with sha512sum failed;  Removing files '${LATESTI686##* }' and sha512sums."
rm -f "${LATESTI686##* }" sha512sums
fi
## qemugeti686.bash EOF
