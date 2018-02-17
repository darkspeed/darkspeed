#!/bin/bash
HOST=darkspeed@aaronjsutton.com
ROOT=/var/www/darkspeed-dev/

rsync -qrz --delete-after docs/ darkspeed@aaronjsutton.com:$ROOT
ssh $HOST mkdir -p $ROOT/report/coverage
rsync -qrz --delete-after /tmp/security.html darkspeed@aaronjsutton.com:$ROOT/reports/
rsync -qrz --delete-after /tmp/rubocop.html darkspeed@aaronjsutton.com:$ROOT/reports/
rsync -qrz --delete-after public/coverage darkspeed@aaronjsutton.com:$ROOT/reports/
