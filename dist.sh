#!/usr/bin/env bash


# print gray to stderr without commands
_dbg() ( set +x;  echo -n $'\e[90m';  "$@";  echo -n $'\e[0m'; ) >&2


# self-knowledge
SELF="${BASH_SOURCE[0]}"
REALSELF="$(realpath -s "$SELF")"


# script is sourced?
if [[ "$0" != "$SELF" ]]; then
    # debug
    set -x
else
    # change directory (must exists) without following symlinks
    cd "$(dirname "$REALSELF")" || exit
    _dbg echo "WorkDir: $PWD"
fi


# dependencies
DEPS=(sha512sum)
if ! command -V "${DEPS[@]}" &>/dev/null; then  # no output if successful
    command -V "${DEPS[@]}"                     # output if failure
    exit 1
fi


gen_checksum() {
    # must stage changes first
    local path
    while read -r path; do
        [[ -d "$path" ]] && continue
        sha512sum "$path"
    done < <(git ls-files -- . ':!*.sum' "$@")
} > sha512.sum


main() {
    local distdir="dist"
    local srcdir="src"
    
    gen_checksum ":!$srcdir/*"
    (
        cd "$srcdir" || exit;
        gen_checksum
    )
    
    (
        mkdir -p "$distdir"
        local gz="$distdir/setupTermuxArch.tar.gz"
        # exclude hidden paths that are not current dir ("./my_file")
        tar --anchored --exclude='.[^/]*' --exclude='*/.*' -czvf "$gz"  -C "$srcdir" .  ../LICENSE
    )
}


main "$@"
