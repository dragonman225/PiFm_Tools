#!/bin/bash
echo "Welcome ! Your Bash version ${BASH_VERSION}..."
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in *
        do
                echo "Playing $i"
                ffmpeg -i $i -f s16le -acodec pcm_s16le -ac 2 -ar 44100 - | sudo pifm - 87.6 44100 stereo
        done
IFS=$SAVEIFS
