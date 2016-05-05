#!/bin/bash

to=web-2AMsq5@mail-tester.com
from=web@fullertreacymoney.com

CURDATE=`date`
sendmail -oi $to << EOF
From: Your User <$from>
To: $to
Subject: SERVER INFO: Email test on $CURDATE

SERVER INFO: Email test on $CURDATE

EOF
