#!/bin/bash
HOST=darkspeed@aaronjsutton.com
ROOT=/var/www/darkspeed-dev/
REPORTS=$ROOT/report
COVERAGE=$ROOT/$REPORT/coverage

rsync -qrz --delete-after docs/ darkspeed@aaronjsutton.com:$ROOT
rsync -qrz --delete-after /tmp/security.html darkspeed@aaronjsutton.com:$REPORTS
rsync -qrz --delete-after /tmp/rubocop.html darkspeed@aaronjsutton.com:$REPORTS
rsync -qrz --delete-after public/coverage darkspeed@aaronjsutton.com:$COVERAGE
