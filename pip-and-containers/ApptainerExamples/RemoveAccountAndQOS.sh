#!/bin/bash
find .  -iname '*slurm.sh' -print0 | xargs -0  sed -i 's/--qos=.*/--qos=<qos>/g'
find .  -iname '*slurm.sh' -print0 | xargs -0  sed -i 's/--account=.*/--account=<account name>/g'
