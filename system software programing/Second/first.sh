#! /bin/ksh

#if ls "$1" > /dev/null
#then
        gfind -L . -maxdepth 1 -samefile "$1" -xtype l | xargs ls -ct
#fi


