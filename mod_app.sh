#!/bin/bash

# NOTE: This script is executed from the new app's root directory
  
CHAPTER=$1
TOGGLE_OUTLINE=$2

echo '**************'
echo "BEGIN $CHAPTER"
echo '**************'

DATE1=$(date +%s)

cp mod/mod-$CHAPTER/* $PWD
SCRIPT="mod-$CHAPTER.sh"
bash $SCRIPT $TOGGLE_OUTLINE
rm mod-$CHAPTER*

DATE2=$(date +%s)

echo '*********************************************'
echo "FINISHED $CHAPTER in $((DATE2-DATE1)) seconds"
echo '*********************************************'
