#!/bin/bash
rsync -z --delete-after --quiet /tmp/report.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/security/
rsync -z --delete-after --quiet /tmp/report.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
