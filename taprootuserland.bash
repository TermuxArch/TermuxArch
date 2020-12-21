#!/usr/bin/env bash
## copyright 2020 (c) by SDRausty, all rights reserved, see LICENSE
## hosting termuxarch.github.io/TermuxArch courtesy pages.github.com
## contributors:  github.com/WMCB-Tech github.com/JanuszChmiel thank you for helping
################################################################################
set -eu
_AU_() {
if command -v au
then
au "$@"
else
printf "%s\\n" "Installing 'au'" && curl -OL "https://raw.githubusercontent.com/WAE/au/master/au" -o "$PREFIX/bin/au" && chmod 744 "$PREFIX/bin/au" 
au "$@"
fi
}
_GITCLONED1TERMUXPROOTSB_() {
printf "%s\\n" "Cloning 'https://github.com/termux/proot'" && git clone --depth 1 "https://github.com/termux/proot" --single-branch
}
_MAKEV1_() {
if [ -f "$HOME/termux/proot/src/builttaprootuserland.lock" ]
then
printf "%s\\n" "Found file '$HOME/termux/proot/src/builttaprootuserland.lock' in directory '$(pwd)';  Please remove file '$HOME/termux/proot/src/builttaprootuserland.lock' to attempt to rebuild Termux PRoot with USERLAND support:  Continuing..."
else
sed -ir 's/^CPPFLAGS.*/CPPFLAGS += -DUSERLAND -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -I. -I$(VPATH)/g' GNUmakefile
printf "%s\\n" "Running 'make clean && make V=1' in directory $(pwd)..." && make clean && make V=1
fi
}
_DOTAPROOTUSERLAND_() {
if [ ! -e "$HOME/termux/proot/src" ]
then
mkdir -p "$HOME/termux" && cd "$HOME/termux"
_GITCLONED1TERMUXPROOTSB_ || (_AU_ git && _GITCLONED1TERMUXPROOTSB_)
fi
printf "%s\\n" "'cd $HOME/termux/proot/src'..." && cd "$HOME/termux/proot/src"
_MAKEV1_ || ( _AU_ clang talloc make && _MAKEV1_ )
command -v "$HOME/termux/proot/src/proot" && touch "$HOME/termux/proot/src/builttaprootuserland.lock" && mkdir -p "$HOME/termux/proot/tmp"
if [ -f "$PREFIX/bin/proot" ]
then
if [ ! -f "$HOME/termux/proot/tmp/proot.bkp" ]
then
cp "$PREFIX/bin/proot" "$HOME/termux/proot/tmp/proot.bkp" && printf "%s\\n" "Copied file '$PREFIX/bin/proot' to '$HOME/termux/proot/tmp/proot.bkp'."
fi
fi
cp "$HOME/termux/proot/src/proot" "$PREFIX/bin/proot" && printf "%s\\n" "Copied file '$HOME/termux/proot/src/proot' to '$PREFIX/bin/proot'."
}
if [[ -z "${1:-}" ]]
then
_DOTAPROOTUSERLAND_
elif [[ "${1//-}" = [Rr]* ]]
then
if [ ! -f "$HOME/termux/proot/tmp/proot.bkp" ]
then
cp "$HOME/termux/proot/tmp/proot.bkp" "$PREFIX/bin/proot" && printf "%s\\n" "Copied file '$HOME/termux/proot/tmp/proot.bkp' to '$PREFIX/bin/proot'."
fi
fi
## taprootuserland.bash EOF
