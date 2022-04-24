#Function open a file and store the data in a list of lists in utf-8
def read_file(file_name):
    with open(file_name, 'r', encoding='utf-8') as f:
        data = f.readlines()
    return data

#Function to clean the data (remove the \n and \ufeff and empty lines)
def clean_data(data):
    clean_data = []
    for line in data:
        line = line.strip("\n")
        line = line.strip("\ufeff")
        if line != '':
            clean_data.append(line)
    return clean_data
 
#Function to detect [Aegisub Project Garbage] and delete all the lines between while [Events]
def delete_garbage(data):
    garbage = False
    for i in range(len(data)):
        if data[i] == '[Script Info]':
            garbage = True
        elif data[i] == '[Events]':
            garbage = False
            
        if garbage == True:
            data[i] = ''
    return data

#Function that detects the first word in the line "Format:" and stores all words in a list 
def format_ass(data):
    format_list = []
    for i in range(len(data)):
        if data[i].startswith('Format:'):
            format_list = data[i].split(',')
            format_list.pop(0)
            format_list = [x.strip() for x in format_list]
    return format_list

#Function that receives a line and removes every character between { and }.
def remove_brackets(line):
    #transform line in a list
    line = list(line)
    garbage = False

    for i in range(len(line)):
        if line[i] == '{':
            garbage = True
        elif line[i] == '}':
            line[i] = ' '
            garbage = False
            
        if garbage == True:
            line[i] = ' '
    #retransform line in a str
    line = ''.join(line)
    
    return line

#Function that stores each segment (segments are separated by a ',') in a dictionary (each name is defined in the format argument) and puts each line in a list.*
def ass_to_dict(data, format):
    dict_data = []
    for i in range(len(data)):
        if data[i].startswith('Dialogue:'):
            #send the line to the function remove_brackets
            data[i] = remove_brackets(data[i])
            line = data[i].split(',')
            line.pop(0)
            line = [x.strip() for x in line]
            dict_data.append(dict(zip(format, line)))
    return dict_data

#Function to pop a line if the next line is identical to the previous line
def delete_identical_lines(data):
    for i in range(len(data)-1):
        if data[i]['Text'] == data[i+1]['Text']:
            data[i] = ''

    #delete all line that are empty
    data = [x for x in data if x != '']
    return data