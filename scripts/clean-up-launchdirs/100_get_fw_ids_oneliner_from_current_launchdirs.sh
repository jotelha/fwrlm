#!/bin/bash

./110_build_launchdir_fw_id_mapping.sh | ./120_invert_mapping.sh | sort -n | tee fw_id_launchdir_mapping.txt | ./130_fw_ids_only.sh | tee fw_ids_only.txt | ./140_fw_ids_on_one_line.sh
