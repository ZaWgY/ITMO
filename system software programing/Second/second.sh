#!/bin/ksh

getent passwd | cut -f 1 -d ':' | xargs groups | egrep " $1( |$)" | cut -f 1 -d ':' | sort

