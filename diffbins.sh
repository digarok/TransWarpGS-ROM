#!/bin/bash
if ! command -v vimdiff &> /dev/null
then
  echo "Sorry this requires vimdiff."
  exit
fi

HEXDUMP=hihex
if ! command -v $HEXDUMP &> /dev/null
then
    echo "$HEXDUMP could not be found. "
    echo "It is recommended you download this and put it in your path."
    echo " https://github.com/digarok/hihex/releases/"
    echo "" 
    sleep 2
    echo "We will revert to hexdump, which does not show high-bit ascii appropriately."
    echo ""
    sleep 3
    $HEXDUMP=hexdump
fi



vimdiff <($HEXDUMP -offset 0xbc8000 src/twgs_1.8s/twgs) <($HEXDUMP -offset 0xbc8000 rom/twgs_1.8s/twgs-rom.bin)
