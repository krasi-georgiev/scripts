#!/bin/bash

to=web-f9viOT@mail-tester.com
from=info@wentworthclinic.co.uk

CURDATE=`date`
sendmail -oi $to << EOF
From: Your User <$from>
To: $to
Subject: SERVER INFO: Email test on $CURDATE

SERVER INFO: Email test on $CURDATE

EOF
