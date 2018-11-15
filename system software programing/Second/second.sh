#!/bin/ksh
getent passwd | nawk -F: '{print $1}' | xargs groups | egrep "\<$1\>" | nawk -F: '{print $1}' | sort | egrep 's[0-9]{6}'

