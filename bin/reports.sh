#!/bin/bash
rsync -qrz --delete-after /tmp/security.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
rsync -qrz --delete-after /tmp/rubocop.html darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
rsync -qrz --delete-after public/coverage darkspeed@aaronjsutton.com:/var/www/darkspeed-dev/reports/
