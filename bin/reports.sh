#!/bin/bash
rsync -rz --delete-after --quiet /tmp/report.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/security/
rsync -rz --delete-after --quiet /tmp/rubocop.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
