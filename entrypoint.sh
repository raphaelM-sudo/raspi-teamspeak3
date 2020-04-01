#!/bin/bash
set -e

exec gosu ts3server exagear -- /opt/ts3server/start.sh "$@"

