#!/bin/bash
LAUNCHPAD_LOC=${LAUNCHPAD_LOC:-${SCRATCH}/hoermann/fireworks/launchpad}

# too slow
# python -c "import sys, json; print(json.load(sys.stdin)['fw_id'])"
# find ${LAUNCHPAD_LOC} -mindepth 2 -maxdepth 2 -name FW.json -type f -exec bash -c "cat  {} | python -c \"import sys, json; print(json.load(sys.stdin)['fw_id'])\"" \;
# fast
# find ${LAUNCHPAD_LOC} -mindepth 2 -maxdepth 2 -name FW.json -type f -exec grep '^    "fw_id"' {} +
find ${LAUNCHPAD_LOC} -mindepth 2 -maxdepth 2 -name FW.json -type f -exec grep '^    "fw_id"' {} + | sed 's/"fw_id"//g' | tr -d ':,'
# second level
find ${LAUNCHPAD_LOC} -mindepth 3 -maxdepth 3 -name FW.json -type f -path "${LAUNCHPAD_LOC}/block*" -exec grep '^    "fw_id"' {} + | sed 's/"fw_id"//g' | tr -d ':,'

