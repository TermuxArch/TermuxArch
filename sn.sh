#!/usr/bin/env sh
# Copyright 2017-2022 by SDRausty. All rights reserved.
# SDRausty https://sdrausty.github.io
# Used for creating the commit message in conjunction with `gr.sh`.
#####################################################################
set -e
ntime=`date +%N`
ndate=`date +%Y%m%d`
printf "%s\\n" "commit $ntime on $ndate"
# sn.sh EOF
