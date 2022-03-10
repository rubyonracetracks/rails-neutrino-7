#!/bin/bash
set -e

# This chapter creates scripts for testing just a portion of the test suite.
# These portions include the helpers/mailers, the model tests, and the
# controller tests.

# AGENDA
# * Add testh.sh, testhl.sh, testm.sh, testml.sh, testc.sh, and testcl.sh.

echo '#######################################'
echo 'Unit 5 Chapter 2: Quick Testing Scripts'
echo '#######################################'

# WICHTIG/LEGACY/bash: add testh.sh, testm.sh, and testc.sh

mv mod-05-02-docker_testh docker/testh
chmod +x docker/testh
mv mod-05-02-docker_testhl docker/testhl
chmod +x docker/testhl
mv mod-05-02-docker_testm docker/testm
chmod +x docker/testm
mv mod-05-02-docker_testml docker/testml
chmod +x docker/testml
mv mod-05-02-docker_testc docker/testc
chmod +x docker/testc
mv mod-05-02-docker_testcl docker/testcl
chmod +x docker/testcl

git add .
git commit -m "Added quick testing scripts"
