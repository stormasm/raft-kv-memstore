#!/bin/sh

set -o errexit

kill() {
    if [ "$(uname)" = "Darwin" ]; then
        SERVICE='raft-key-value'
        if pgrep -xq -- "${SERVICE}"; then
            pkill -f "${SERVICE}"
        fi
    else
        set +e # killall will error if finds no process to kill
        killall raft-key-value
        set -e
    fi
}

export RUST_LOG=trace

echo "Killing all running raft-key-value"

kill

sleep 1

rm n1.log
rm n2.log
rm n3.log
