#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail
  
CHAPTER=$1

echo '**************'
echo "BEGIN $CHAPTER"
echo '**************'

DATE1=$(date +%s)

cp mod/mod-$CHAPTER/* $PWD
SCRIPT="mod-$CHAPTER.sh"
bash $SCRIPT
rm mod-$CHAPTER*

DATE2=$(date +%s)

echo '*********************************************'
echo "FINISHED $CHAPTER in $((DATE2-DATE1)) seconds"
echo '*********************************************'
