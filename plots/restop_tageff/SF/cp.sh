#!/bin/bash

# Remote login info
REMOTE_USER="sitong"
REMOTE_HOST="lxplus9.cern.ch"
REMOTE_BASE_DIR="/afs/cern.ch/work/s/sitong/combine_fw/CMSSW_10_2_13/src/TagProbeSF"

# Temp file to hold list of directories
TMPFILE=$(mktemp)

# Fetch list of matching remote directories
ssh ${REMOTE_USER}@${REMOTE_HOST} "find ${REMOTE_BASE_DIR} -maxdepth 1 -type d -name 'T_eff_*'" > $TMPFILE

# Loop over each directory
while read remote_dir; do
    remote_plot_dir="${remote_dir}/plots_datamc"
    echo "Copying PNGs from ${remote_plot_dir} ..."
    
    # scp png files
    scp ${REMOTE_USER}@${REMOTE_HOST}:${remote_plot_dir}/*.png .
done < $TMPFILE

# Clean up
rm $TMPFILE

echo "All PNGs copied successfully."

