"""
SRT FORMAT: 
subtitle number
Start time --> end time
Subtitle text (up to two lines)
[empty line]

example:
1
00:02:16,612 --> 00:02:19,376
Senator, we're making
our final approach into Coruscant.

2
00:02:19,482 --> 00:02:21,609
Very good, Lieutenant.

3
00:03:13,336 --> 00:03:15,167
We made it.

4
00:03:18,608 --> 00:03:20,371
I guess I was wrong.

5
00:03:20,476 --> 00:03:22,671
There was no danger at all.
"""

#Function make a SRT
#arg 1 : list of dictionary with Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text (random order)
def make_srt_from_ass(data):
    srt = ''
    for i in range(len(data)):
        srt += str(i+1) + '\n'
        srt += data[i]['Start'] + ' --> ' + data[i]['End'] + '\n'
        srt += data[i]['Text'] + '\n\n'
    return srt
