import tkinter
from tkinter import colorchooser

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

def choose_color():
    root = tkinter.Tk()
    root.config(width=1, height=1)
    root.wm_attributes("-topmost", 1)
    root.after(100, root.focus_force())
    color = colorchooser.askcolor()[1]
    root.destroy()
    return color

#Function make a SRT
#arg 1 : list of dictionary with Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text (random order)
def make_srt_from_ass(data):
    #style_allows are 2 dict, the first is the style allowed, the second is the color (default is <font #ffffff)
    #Ex : {'Op french': "#ffffff"; 'Op romanji' : '#d86fe8'}
    srt, style_allows, style_deny, nb_sub = '', {}, [], 0
    for i in range(len(data)):
        
        #If style of data is in style_allows, then add the line to the SRT
        if data[i]['Style'] in style_allows:
            srt += str(nb_sub+1) + '\n'
            nb_sub += 1
            srt += data[i]['Start'] + ' --> ' + data[i]['End'] + '\n'
            #Put f"<font color {style_allows[data[i]['Style']]}>" before the text and '</font>' after
            srt += f"<font color='{style_allows[data[i]['Style']]}'>" + data[i]['Text'] + '</font>' + '\n\n'
        
        #If style of data is in style_deny, continue
        elif data[i]['Style'] in style_deny:
            continue
        
        #If style of data is not in style_allows or style_deny, ask the user if he wants to add the style to style_allows or style_deny
        else:
            print('\n' + data[i]['Style'] + ' is not in the list of allowed styles.\nDo you want to add it to the list of allowed styles? (y/+c/n) (+c = color)')
            answer = input()
            if answer == 'y':
                srt += str(nb_sub+1) + '\n'
                nb_sub += 1
                style_allows[data[i]['Style']] = '#ffffff'
                srt += data[i]['Start'] + ' --> ' + data[i]['End'] + '\n'
                srt += f"<font color='{style_allows[data[i]['Style']]}'>" + data[i]['Text'] + '</font>' + '\n\n'
        
            elif answer == 'n':
                style_deny.append(data[i]['Style'])
                continue
        
            #If answer is +color, ask what color (in hexadecimal) 
            elif answer[0] == '+color' or answer[0] == '+c' or answer[0] == '+':
                print('\nWhat color do you want to add to the list of allowed styles?')
                color = choose_color()
                style_allows[data[i]['Style']] = color
                srt += str(nb_sub+1) + '\n'
                nb_sub += 1
                srt += data[i]['Start'] + ' --> ' + data[i]['End'] + '\n'
                srt += f"<font color='{style_allows[data[i]['Style']]}'>" + data[i]['Text'] + '</font>' + '\n\n'
                
            else:
                print('\nPlease answer with y or n or +.\n')
                continue
    return srt