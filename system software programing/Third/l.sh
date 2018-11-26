#!/bin/ksh
[[ "$#" -ne 1 ]] && echo "Input must be in the format: $0 USERNAME">&2 && exit 1
[[ $(getent passwd "$1" | wc -l) -ne 1 ]] && exit 1
UID=$(getent passwd "$1" | cut -d':' -f3)
GROUPS=$(groups "$1")
RES=""
for FILE in ./*  ./*/* 
do
        set -o noglob
        [[ -d "$FILE" ]] && continue
        LS=$(ls -bdn -- "$FILE")
        CUR_UID=$(echo "$LS" | awk '{print $3}')
        CUR_GID=$(echo "$LS" | awk '{print $4}')
        C=0
        LS2=$(ls -1bd -- "$FILE")
        if [[ $UID = $CUR_UID ]]
        then
                echo "$LS" | grep -q '^.r' && echo "$LS2"
        continue
        fi
        for GROUP in $GROUPS
        do
                GID=$(getent group "$GROUP" | cut -d':' -f3)
                if [[ $GID = $CUR_GID ]]
                then
                        echo "$LS" | grep -q '^....r' && echo "$LS2"
                continue 2
                fi
        done
        echo "$LS" | grep -q '^.......r' && echo "$LS2"
done

