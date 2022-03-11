#!/bin/bash

./050_find_all_fw_ids_belonging_to_completed_runs.sh

comm -12 <(sort fw_ids_only.txt) <(sort fw_ids_in_completed_wflows.txt) | sort -n > fw_ids_in_launchpad_belonging_to_completed_wflows.txt

NFWS_IN_COMPLETED_WFLOWS_IN_LAUNCHPAD=$(cat fw_ids_in_launchpad_belonging_to_completed_wflows.txt | wc -l)
echo "Number of fws in COMPLETED workflows present in launchpad: ${NFWS_IN_COMPLETED_WFLOWS_IN_LAUNCHPAD}"


