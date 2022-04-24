import os

from extract_ass import *
from create_srt import *

#Create a list of dir of all .txt files in the current directory
dirs = [f for f in os.listdir('temp') if f.endswith('.txt')]

for video in dirs:
    data_original = read_file('temp/video1_clean_sub.txt')
    data = data_original.copy()
    data = clean_data(data)

    sub = delete_garbage(data)
    sub = clean_data(sub)
    format = format_ass(sub)
    sub = ass_to_dict(sub, format)
    sub = delete_identical_lines(sub)
    sub = make_srt_from_ass(sub)

    print(sub)
