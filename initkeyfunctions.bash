#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_ADDkeys_() {
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then	# set customized commands for Arch Linux 32 architecture
X86INT="_CURLDWND_() { { [ \"\${CURLDWNDVAR_:-}\" = 0 ] && curl -C - --insecure --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" ; } || { curl -C - --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" || { CURLDWNDVAR_=0 && printf '%s\\n' \"Running command 'curl --insecure';  Continuing...\" && curl -C - --insecure --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" ; } ; } ; }

UPGDPKGS=(\"a/archlinux-keyring/archlinux-keyring-20191219-1.0-any.pkg.tar.xz\" \"a/archlinux32-keyring/archlinux32-keyring-20191230-1.0-any.pkg.tar.xz\" \"g/glibc/glibc-2.28-1.1-i686.pkg.tar.xz\" \"l/linux-api-headers/linux-api-headers-5.3.1-2.0-any.pkg.tar.xz\" \"l/libarchive/libarchive-3.3.3-1.0-i686.pkg.tar.xz\" \"o/openssl/openssl-1.1.1.d-2.0-i686.pkg.tar.xz\" \"p/pacman/pacman-5.2.1-1.4-i686.pkg.tar.xz\" \"z/zstd/zstd-1.4.4-1.0-i686.pkg.tar.xz\" \"/c/coreutils/coreutils-8.31-3.0-i686.pkg.tar.xz\" \"w/which/which-2.21-5.0-i686.pkg.tar.xz\" \"g/grep/grep-3.3-3.0-i686.pkg.tar.xz\" \"g/gzip/gzip-1.10-3.0-i686.pkg.tar.xz\" \"l/less/less-551-3.0-i686.pkg.tar.xz\" \"s/sed/sed-4.7-3.0-i686.pkg.tar.xz\" \"u/unzip/unzip-6.0-13.1-i686.pkg.tar.xz\")

cp -f /usr/lib/{libcrypto.so.1.0.0,libssl.so.1.0.0} \"\$TMPDIR\"
cd /var/cache/pacman/pkg/ || exit 196
_DWLDFILE_() { { printf \"%s\\n\\n\" \"Downloading signature file and file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" && _CURLDWND_ && printf \"%s\\n\\n\" \"Finished downloading signature file and file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" ; } || _PRTERROR_ ; }
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock ]
then
printf \"\\n%s\\n\" \"Downloading transition package and signature files from https://archive.archlinux32.org;  DONE  \"
else
printf \"%s\\n\" \"Downloading files: '\$(printf \"%s \" \"\${UPGDPKGS[@]##*/}\")' from https://archive.archlinux32.org.\"
for UPGDPAKG in \${UPGDPKGS[@]}
do
if [[ -f /var/cache/pacman/pkg/\"\${UPGDPAKG##*/}\" ]]
then
printf \"%s\\n\" \"File '\${UPGDPAKG##*/}' is already downloaded.\"
else
_DWLDFILE_ || _DWLDFILE_
fi
done
fi

_PMUEOEP1_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\" \"[\$2/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$2/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock
fi
}

_PMUEOEP2_() { # depreciated
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\" \"[\$3/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$3/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock
fi
}

_PMUEOEP3_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$4/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$4/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock
fi
}

_PMUEOEP4_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$5/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$5/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$4]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock
fi
}

_PMUEOEP5_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$6/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[0m...\\n\" \"Running \${0##*/} [\$6/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --needed --noconfirm\" ; pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" \"\${UPGDPKGS[\$4]##*/}\" \"\${UPGDPKGS[\$5]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock
fi
}
{ [ -x /system/bin/sed ] && /system/bin/sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf ; } || sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf
_PMUEOEP1_ 1 1
_KEYSGENMSG_
printf \"\\e[1;32m==> \\e[1;37mRunning %s \\e[1;32mpacman -Ss keyring --color=always\\e[1;37m...\\n\" \"\${0##*/}\"
pacman -Ss keyring --color=always || _PRTERROR_
_PMUEOEP5_ 9 10 11 12 13 2
_PMUEOEP4_ 2 3 7 8 3
_PMUEOEP3_ 4 5 6 4
mv -f \"\$TMPDIR\"/{libcrypto.so.1.0.0,libssl.so.1.0.0} /usr/lib/
sed -i '/^Architecture/s/.*/Architecture = i686/' /etc/pacman.conf
sed -i '/^SigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf
sed -i 's/^HoldPkg/\#HoldPkg/g' /etc/pacman.conf
if [ ! -f /var/run/lock/"${INSTALLDIR##*/}"/keyring.lock ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [5/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm\"
_KEYSGENMSG_
{ pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm && sed -i '/^SigLevel/s/.*/SigLevel    = Required DatabaseOptional/' /etc/pacman.conf && PACMANQ_=\"\$(pacman -Qo /usr/lib/libblkid.so)\" && { [[ \"\$(printf $\{PACMANQ_/libsutil-linux})\" == *libsutil-linux* ]] || pacman -Rdd libutil-linux --noconfirm || _PRTERROR_ ; } && :>/var/run/lock/"${INSTALLDIR##*/}"/keyring.lock ; }
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[5/7]  The command \" \"pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm\" \" has already been successfully run; Continuing...\"
fi
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [6/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -S curl glibc gpgme libarchive pacman --needed --noconfirm\"
pacman -S curl glibc gpgme libarchive pacman --needed --noconfirm || _PRTERROR_
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [7/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -Su --needed --noconfirm ; Starting full system upgrade\"
rm -f /etc/ssl/certs/ca-certificates.crt
sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Optional/' /etc/pacman.conf
sed -i '/^SigLevel/s/.*/SigLevel    = Optional/' /etc/pacman.conf
pacman -Sy || pacman -Sy || sudo pacman -Sy
pacman -Su --needed --noconfirm || pacman -Su --needed --noconfirm || sudo pacman -Su --needed --noconfirm"
X86IPT=" "
X86INK=":"
else	# Arch Linux architectures armv5, armv7, aarch64 and x86-64 use these options
X86INT=":"
X86IPT="(1/2)"
X86INK="printf \"\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -S %s --needed --noconfirm --color=always\\\\e[1;37m...\\\\n\" \"\$ARGS\"
pacman -S \"\${KEYRINGS[@]}\" --needed --noconfirm --color=always || pacman -S \"\${KEYRINGS[@]}\" --needed --noconfirm --color=always
printf \"\\\\n\\\\e[1;32m(2/2) \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \\\\e[1;32mbash ~%s/bin/we \\\\e[0;34min a new Termux session to watch entropy on device.\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n\" \"$DARCH\"
{ [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpp.lock ] && printf '\\e[1;32m==> \\e[1;37mAlready populated with command \\e[1;32mpacman-key --populate\\e[1;37m...\\n' ; } || { printf '\\e[1;32m==> \\e[1;37mRunning \\e[1;32mpacman-key --populate\\e[1;37m...\\n' && { $ECHOEXEC pacman-key --populate && :>/var/run/lock/"${INSTALLDIR##*/}"/kpp.lock ; } || _PRTERROR_ ; }
printf \"\\\\e[1;32m==>\\\\e[1;37m Running \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n\"
pacman -Ss keyring --color=always"
fi
_CFLHDR_ usr/local/bin/keys
cat >> usr/local/bin/keys <<- EOM
declare -a KEYRINGS

_KEYSGENMSG_() {
printf "\\\\n\\\\e[1;32m%s \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  You can use \\\\e[1;32mbash ~%s/bin/we \\\\e[0;34min a new Termux session to watch entropy on device.\\\\e[0m\\\\n" "$X86IPT" "$DARCH"
}

_GENEN_() {
printf "\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0m\\\\n\\\\e[0m" "Generating entropy on device;  " "Please wait...  "
GENENN=16
for INT in \$(seq 1 \$GENENN); do
nice -n 20 ls -alR /usr >/dev/null &
nice -n 20 find /usr >/dev/null &
nice -n 20 cat /dev/urandom >/dev/null &
done
}

_PRINTTAIL_() {
printf "\\\\n\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\$ARGS" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s: DONE 📱 \007'  "'\${0##*/} \$ARGS'"
}

_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) and run '\${0##*/} \$ARGS' again."
}

_TRPET_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${KEYRINGS[@]}"
}
trap _TRPET_ EXIT

## keys begin ##################################################################
[ -f /etc/pacman.conf.bkp ] || cp /etc/pacman.conf /etc/pacman.conf.bkp
[ -z "\${USER:-}" ] && USER=root
KEYSUNAM_="\$(uname -m)"
if [ -x /system/bin/toybox ] && [ ! -f /var/run/lock/"${INSTALLDIR##*/}"/toyboxln."\$USER".lock ]
then
cd "\$USER"/bin 2>/dev/null || cd bin || exit 196
{
printf 'Creating symlinks in '%s' to '/system/bin/toybox';  Please wait a moment...  \n' "\$PWD"
for TOYBOXTOOL in \$(/system/bin/toybox)
do
if [ "\$TOYBOXTOOL" != cat ] || [ "\$TOYBOXTOOL" != uname ]
then
ln -fs /system/bin/toybox "\$TOYBOXTOOL" || _PRTERROR_
fi
done && :>/var/run/lock/"${INSTALLDIR##*/}"/toyboxln."\$USER".lock && printf 'Creating symlinks in '%s' to '/system/bin/toybox';  DONE  \n' "\$PWD" ; } || _PRTERROR_
cd "$INSTALLDIR" || exit 196
fi
if [[ -z "\${1:-}" ]] || [[ "\$KEYSUNAM_" = aarch64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinuxarm-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinux32-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86-64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="ca-certificates-utils"
else
KEYRINGS=""
fi
if [[ "\$KEYSUNAM_" = x86 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinux32-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$KEYSUNAM_" = x86-64 ]] || [[ "\$KEYSUNAM_" = x86_64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="ca-certificates-utils"
fi
ARGS="\${KEYRINGS[@]}"
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "'\${0##*/} \$ARGS'"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \$ARGS" "version \$VERSIONID"
_GENEN_ ; kill \$! &
_KEYSGENMSG_
_DOPSY_() {
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -Sy\\\\e[1;37m...\\\\n"
$ECHOEXEC $ECHOSYNC pacman -Sy || $ECHOEXEC $ECHOSYNC pacman -Sy || sudo $ECHOEXEC $ECHOSYNC pacman -Sy
}
_DOPSY_ || _DOPSY_ || _PRTERROR_
_DOKPI_() {
if [ ! -f "/run/lock/${INSTALLDIR##*/}/kpi.lock" ]
then
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
{ $ECHOEXEC pacman-key --init && :>"/run/lock/${INSTALLDIR##*/}/kpi.lock" ; } || _PRTERROR_
else
printf "\\\\e[1;32m==> \\\\e[1;37mAlready initialized with command \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
fi
}
_DOKPI_ || _DOKPI_
umask 000
chmod 4777 /usr/bin/newuidmap
chmod 755 /etc/pacman.d/gnupg
umask 022
_DOPP_() {
{ [ -f "/var/run/lock/${INSTALLDIR##*/}/kpp.lock" ] && printf "\\\\e[1;32m==> \\\\e[1;37mAlready populated with command \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n" ; } || { printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n" && { $ECHOEXEC pacman-key --populate && :>"/var/run/lock/${INSTALLDIR##*/}/kpp.lock"; } || _PRTERROR_ ; }
}
_DOPP_ || _DOPP_
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n"
pacman -Ss keyring --color=always || pacman -Ss keyring --color=always || _PRTERROR_
$X86INT
$X86INK
## ~/${INSTALLDIR##*/}/usr/local/bin/keys FE
EOM
chmod 755 usr/local/bin/keys
}
_MAKESTARTBIN_() {
_CFLHDR_ "$STARTBIN"
printf "%s\\n" "${FLHDRP[@]}" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
_CHCKUSER_() { [ -d "$INSTALLDIR/home/\$2" ] || _PRNTUSGE_ "\$@" ; }
_COMMANDGNE_() { printf "\\n\\e[1;48;5;138mScript %s\\e[0m\\n\\n" "\${0##*/} WARNING:  Please run '\${0##*/}' and 'bash \${0##*/}' from the BASH shell in native Termux:  EXITING..." && exit 202 ; }
if [ -w /root ]
then
_COMMANDGNE_
fi
_PRINTUSAGE_() {
printf "\\n\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN" "  starts Arch Linux in $TXPRQUON with PRoot root login.  This account is reserved for system administration.  Please use any system administrator account with care."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN c[ommand] command" "  runs Arch Linux commands from Termux as PRoot root login.  Quoting multiple commands can assit when passing multiple arguments; i.e. " "$STARTBIN c 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please pass commands through the system administrator account with caution."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN e[login|user] user" "  login as user.  Uses alternate elogin and euser option to login as user.  This option is preferred for working with programs that have already been installed, and for working with the 'cp' and 'git' commands.  Please use " "$STARTBIN c 'addauser user'" " first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN l[ogin]|u[ser] user" "  login as user.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeauryay'.  Please use 'addauser user' first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN r[aw]" "  construct the " "$STARTBIN " "proot statement from exec.../bin/.  For example " "$STARTBIN r su " "will exec 'su' in Arch Linux.  After installing the appropriate packages in Arch Linux, easy PRoot root shell access is possible with option raw:

~ $ startarch r bash
~ $ startarch r dash
~ $ startarch+x86 r csh
~ $ startarch+x86 r ksh
~ $ startarch+x864 r sh
~ $ startarch+x864 r zsh

Variable PROOTSTMNT has more information about PRoot init statement options 'grep -h PROOTSTMNT ~/TermuxArchBloom/* | grep \=' if you wish to modify the PRoot init statement extensively.  The PRoot init statement can also be modified on-the-fly simply by using the /var/binds/ directory once logged into the Arch Linux in Termux PRoot environment."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[0m" "$STARTBIN s[u] user command" "  executes commands as Arch Linux user from the Termux shell.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeauryay'.  Quoting multiple commands can assit when passing multiple arguments:  " "$STARTBIN s user 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please use " "$STARTBIN c 'addauser user'" " first to create a login and the login's home directory."
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN $@ 📲; DONE 🏁"
}
_PRNTUSGE_() { _PRINTUSAGE_ && printf "\\e[0;33m%s\\e[1;30m%s\\e[1;32m%s\\e[1;30m%s\\e[1;31m%s\\e[1;30m%s\\e[0m" "It appears that user '\$2' does not exist in the Arch Linux in Termux PRoot system!  " "You can create user '\$2' with the command " "\${0##*/} command 'addauser \$2'" " then rerun this comnand to login with user '\$2';" "  Exiting" "...  " ; exit 169 ; }
## [] Default Arch Linux in Termux PRoot root login.
if [[ -z "\${1:-}" ]]
then
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN 📲"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/bash -l ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN 📲; DONE 🏁"
set -Eeuo pipefail
## [? | help] Displays usage information.
elif [[ "\${1//-}" = [?]* ]] || [[ "\${1//-}" = [Hh]* ]]
then
_PRINTUSAGE_
elif [[ -z "\${2:-}" ]]
then
_PRINTUSAGE_
printf "\\e[0;33m%s\\e[1;30m%s\\e[0;31m%s\\e[1;30m%s\\e[0m" "Please use at least one more argument to continue.  The command '\${0##*/} help' has more information" ";" "  Exiting" "...  "
## [command ARGS] Execute a command in BASH as root.
elif [[ "\${1//-}" = [Cc]* ]]
then
printf '\033]2; TermuxArch $STARTBIN command %s 📲\007' "\${@:2}"
:>"$INSTALLDIR/root/.chushlogin"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/bash -lc \"\${@:2}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN command %s 📲;DONE 🏁 \007' "\${@:2}"
set -Eeuo pipefail
rm -f "$INSTALLDIR/root/.chushlogin"
## [e[login|user] user] Login as user.
elif [[ "\${1//-}" = e* ]]
then
_CHCKUSER_ "\$@"
printf '\033]2; TermuxArch $STARTBIN elogin %s 📲\007' "\$2"
set +Eeuo pipefail
:>"$INSTALLDIR/var/lock/${INSTALLDIR##*/}/\$\$elock"
if [ -f "$INSTALLDIR/var/lib/pacman/db.lck" ]
then
printf "%s" "File ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck exists;  You can use the TermuxArch 'pacmandblock' command to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in Arch Linux in Termux PRoot: "
else
printf "%s" "Creating file ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck;  You can use the TermuxArch 'pacmandblock' command to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in the Arch Linux in Termux PRoot environment:  "
:>"$INSTALLDIR/var/lib/pacman/db.lck"
printf "%s\\n" "Continuing..."
fi
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*/}/\$\$elock\" ]" "then" "if [ -f \"$INSTALLDIR/var/lib/pacman/db.lck\" ]" "then" "printf \"%s\" \"Deleting file '~/${INSTALLDIR##*/}/var/lib/pacman/db.lck';  You can use the TermuxArch 'pacmandblock' command to alter this lock state.  Please use 'startarch' and 'startarch l[ogin] username' to install software in the Arch Linux in Termux PRoot environment:  \"" "rm -f \"$INSTALLDIR/var/lib/pacman/db.lck\"" "printf \"%s\\\\n\" \"DONE\"" "fi" "rm -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*}\$\$elock\"" "fi" "[ ! -f "$INSTALLDIR/home/\$2/.hushlogout" ] && [ ! -f "$INSTALLDIR/home/\$2/.chushlogout" ] && . /etc/moto" "h # write session history to file HOME/.historyfile" "## .bash_logout FE" > "$INSTALLDIR/home/\$2/.bash_logout"
EOM
printf "%s\\n" "$PROOTSTMNTEU /bin/su - \"\$2\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN elogin %s 📲;DONE 🏁 \007' "\$2"
set -Eeuo pipefail
rm -f "$INSTALLDIR/home/\$2/.chushlogin"
## [l[ogin]|u[ser] user] Login as user.
elif [[ "\${1//-}" = [Ll]* ]] || [[ "\${1//-}" = [Uu]* ]]
then
_CHCKUSER_ "\$@"
printf '\033]2; TermuxArch $STARTBIN login %s 📲\007' "\$2"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNTU /bin/su - \"\$2\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN login %s 📲;DONE 🏁 \007' "\$2"
set -Eeuo pipefail
## [raw ARGS] Construct the 'startarch' proot statement.
elif [[ "\${1//-}" = [Rr]* ]]
then
printf '\033]2; TermuxArch $STARTBIN raw %s 📲\007' "\$@"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/\"\${@:2}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN raw %s 📲;DONE 🏁 \007' "\$@"
set -Eeuo pipefail
## [su user command] Login as user and execute command.
elif [[ "\${1//-}" = [Ss]* ]]
then
_CHCKUSER_ "\$@"
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN su \$2 \${@:3} 📲"
if [[ "\$2" = root ]]
then
printf "%s\\n" "Please use this command \"$STARTBIN c '\${@:3}'\" for the Arch Linux in Termux PRoot \$2 user account;  Exiting..."
exit
fi
:>"$INSTALLDIR/home/\$2/.chushlogin"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNTU /bin/su - \"\$2\" -c \"\${@:3}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN su \$2 \${@:3} 📲; DONE 🏁"
set -Eeuo pipefail
rm -f "$INSTALLDIR/home/\$2/.chushlogin"
else
_PRINTUSAGE_
fi
## $STARTBIN FE
EOM
chmod 700 "$STARTBIN"
}
# initkeyfunctions.bash FE
