import os
import sys

from extract_ass import *
from create_srt import *

#Variable globale (I don't have choices)
style_allows, style_deny = {}, []

#Create a list of dir of all .txt files in the current directory
def main(argv: list) -> None:
    dirs = [f for f in os.listdir(argv[1]) if f.endswith('.ass')]

    for video in dirs:
        data = read_file(argv[1]+'\\'+video)
        
        data = clean_data(data)

        sub = delete_garbage(data)
        sub = clean_data(sub)
        format = format_ass(sub)
        sub = ass_to_dict(sub, format)
        sub = delete_identical_lines(sub)
        sub = make_srt_from_ass(sub, style_allows, style_deny)

        #Create a file with the name of the video and the extension .srt
        save_srt(sub, f'{argv[1]}/{video[:-4]}' + '.srt')

if __name__ == '__main__':
    main(sys.argv)