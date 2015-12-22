#!/bin/bash

to=strestus@gmail.com
from=team@vip-consult.co.uk

CURDATE=`date`
sendmail -oi $to << EOF
From: Your User <$from>
To: $to
Subject: SERVER INFO: Email test on $CURDATE

SERVER INFO: Email test on $CURDATE

EOF
