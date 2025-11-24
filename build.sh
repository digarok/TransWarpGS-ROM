#!/bin/bash

# set merlin32 exe/path if different
MERLIN=merlin32
SRCDIR=src/twgs_1.8s/
ROMDIR=rom/twgs_1.8s/

$MERLIN -V $SRCDIR $SRCDIR/twgs.s
diff $SRCDIR/twgs  $ROMDIR/twgs-rom.bin
if [ "$?" -eq 0 ]
then
  echo "Binary is v1.8s compatible"
else
  echo "Not binary compatible with v1.8s"
fi 
