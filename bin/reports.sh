#!/bin/bash
HOST=darkspeed@aaronjsutton.com
ROOT=/var/www/darkspeed-dev

ssh $HOST "mkdir -p $ROOT/report/coverage"
rsync -qrz --delete-after docs/ darkspeed@aaronjsutton.com:$ROOT/
rsync -qrz --delete-after /tmp/security.html darkspeed@aaronjsutton.com:$ROOT/report
rsync -qrz --delete-after /tmp/rubocop.html darkspeed@aaronjsutton.com:$ROOT/report
rsync -qrz --delete-after public/coverage darkspeed@aaronjsutton.com:$ROOT/report/coverage
