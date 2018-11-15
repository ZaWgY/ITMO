#! /bin/ksh

find -L . -maxdepth 0 -samefile "$1" -type l | xargs ls -clt | | nawk '{print "status modification time = ",$8 , "    name = ",$9}'



