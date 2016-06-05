#!/bin/bash

if [ -e $APACHE_PID_FILE ];
then
  rm -f $APACHE_PID_FILE
fi

/usr/sbin/apache2 -D FOREGROUND
