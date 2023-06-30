#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

{  # shellcheck disable=SC2317
[[ -v __COMMONS_BASH ]] && { return 0 2>/dev/null || exit 0; }
export __COMMONS_BASH; }


_PRNT_() {
    # print message with one trialing newline
    printf '%s\n' "$@"
}

_PRT_() {
    # print message with no trialing newline
    printf '%s' "$@"
}

_FIND_LS_() {
    find "$1" -mindepth 1 -maxdepth 1 -printf '%P\n'
}
# commons.bash FE
