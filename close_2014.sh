#!/bin/bash

FILE='CNX-NIFTY01-01-2014-06-09-2014.csv'

cat $FILE | cut -d"," -f1,5 | sed 's/,/  **  /' | sed 's/\-14/\-2014/'
