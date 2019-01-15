#!/usr/bin/sh
OPT=/opt/evelauncher/
export LD_PRELOAD=$OPT/libprotobuf.so.16:$OPT/libgrpc++.so.1:$OPT/libgpr.so.6:$OPT/libgrpc.so.6:$OPT/libsteam_api.so
$OPT/evelauncher "$@"
