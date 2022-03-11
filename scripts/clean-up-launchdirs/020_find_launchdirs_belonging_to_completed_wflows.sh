#!/bin/bash
./030_find_fw_ids_in_launchpad_belonging_to_completed_wflows.sh

grep -f <(cat fw_ids_in_launchpad_belonging_to_completed_wflows.txt | sed 's/^/^/g') fw_id_launchdir_mapping.txt \
  | tee completed_fw_id_launchdir_mapping.txt | awk '{print $2}' | sed 's/FW\.json$//g' > completed_wf_launchdirs.txt

NLAUNCHDIRS_OF_COMPLETED_WFLOWS=$(cat completed_wf_launchdirs.txt | wc -l)
echo "Number of launchdirs belonging to completed workflows: ${NLAUNCHDIRS_OF_COMPLETED_WFLOWS}"
cat completed_wf_launchdirs.txt | xargs du -hs | sort -h > folder_size_lixt.txt
echo "Deletion will free up:"
cat completed_wf_launchdirs.txt | xargs du -hc | tail -1

echo "Run the following command to delete all reported launchdirs:"
echo 'xargs -I{} rm -rf {} < completed_wf_launchdirs.txt'
