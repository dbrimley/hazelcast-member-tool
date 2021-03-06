#!/usr/bin/env bash

# display help for this command
function helper() {
    echo "Usage:  $CMD status [ID_PREFIX ...]"
    echo
    echo "Display process status for started Hazelcast members."
    help_ID_PREFIX
}

# echo available options
function optionlist() {
    :
}

# echo available commands; ID for Hazelcast member IDs
function commandlist() {
    echo ID
}

#
source $(dirname "$0")/utils.sh

#
PRG="$0"
find_HID_LIST "$@"

printf "%-24s%-8s%-8s\n" "ID" "PID" "STATUS"
for hid in "${HID_LIST[@]}"
do
    if read_PID $hid; then
       ps -p "${PID}" > /dev/null
       STATUS=$?
       if [[ STATUS -eq 0 ]]; then
           printf "%-24s%-8s%s\n" "$hid" "$PID" "Running"
       else
           printf "%-24s%-8s%s\n" "$hid" "$PID" "Not running. Run '$CMD stop $hid' to remove stale PID file."
       fi
    fi
done

