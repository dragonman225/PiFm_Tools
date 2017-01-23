#!/bin/bash
curl -o page.txt https://www.youtube.com/playlist?list=[PLAYLISTID]
grep -E '<a class="pl-video-title-link.*[PLAYLISTID]' page.txt | cut -d '"' -f 6 > list-init.txt
sed 's/amp;//g' list-init.txt > list.txt
rm page.txt
rm list-init.txt
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Playing from https://www.youtube.com$line"
    < /dev/null ffmpeg -i "http://www.youtubeinmp3.com/fetch/?video=https://www.youtube.com$line" -f s16le -acodec pcm_s16le -ac 2 -ar 44100 - | sudo pifm - 87.6 44100 stereo
done < "list.txt"
rm list.txt
echo "GoodBye!"
