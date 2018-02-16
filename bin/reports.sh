#!/bin/bash
rsync -rz --delete-after --quiet /tmp/security.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
rsync -rz --delete-after --quiet /tmp/rubocop.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
