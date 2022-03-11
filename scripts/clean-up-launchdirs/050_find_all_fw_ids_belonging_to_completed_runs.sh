#!/bin/bash
./100_get_fw_ids_oneliner_from_current_launchdirs.sh > fw_ids_in_launchdirs_on_one_line.txt
NFWS=$(cat fw_ids_only.txt | wc -l)
echo "Total number of fireworks: $NFWS"
NWFLOWS=$(lpad get_wflows -i $(cat fw_ids_in_launchdirs_on_one_line.txt) -d count)
echo "Total number of workflows: $NWFLOWS"
lpad get_wflows -i $(cat fw_ids_in_launchdirs_on_one_line.txt) -d ids > wf_ids_in_launchdirs.json

cat wf_ids_in_launchdirs.json | xargs | tr -d '[ ]' > wf_ids_in_launchdirs_on_one_line.txt

# works to determine overlap
NCOMPLETED_WFLOWS=$(lpad get_wflows -q '{"state":"COMPLETED", "nodes":{"$in":['$(cat wf_ids_in_launchdirs_on_one_line.txt)']}}' -d count)
echo "Number of COMPLETED workflows: $NCOMPLETED_WFLOWS"

lpad get_wflows -q '{"state":"COMPLETED", "nodes":{"$in":['$(cat wf_ids_in_launchdirs_on_one_line.txt)']}}' -d ids > completed_wf_ids_in_launchdirs.json
cat completed_wf_ids_in_launchdirs.json | xargs | tr -d '[ ]' > completed_wf_ids_in_launchdirs_on_one_line.txt

NFWS_IN_COMPLETED_WFLOWS=$(lpad get_fws_in_wflows -wfi $(cat completed_wf_ids_in_launchdirs_on_one_line.txt) -d count)
echo "Number of fws in COMPLETED workflows: ${NFWS_IN_COMPLETED_WFLOWS}"

lpad get_fws_in_wflows -wfi $(cat completed_wf_ids_in_launchdirs_on_one_line.txt) -d ids > fw_ids_in_completed_wflows.json

cat fw_ids_in_completed_wflows.json | tr -d '[ ,]' | awk 'NF' | sort -n > fw_ids_in_completed_wflows.txt

