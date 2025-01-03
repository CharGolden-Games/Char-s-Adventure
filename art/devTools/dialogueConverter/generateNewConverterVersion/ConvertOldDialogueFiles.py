import json as pyjson
import os
import time

print("Dialogue Format Converter V3.1 [Build 6] | (C) CharGolden 2024")
print('')
print('')
print('')
time.sleep(0.5)

path = input('Please enter the path of the folder for the file: ')

fileName = input('Please enter the filename: ')

newFileName = input('Please input the name of the new file (Default is "newJson"): ')
if newFileName.rstrip().lstrip() == '': newFileName = 'newJson'
newFileName += '.json'
if fileName == newFileName:
    newFileName = f'new_{newFileName}'

char = input('Please input a character name for the "name" variable in game: ')
if char.rstrip().lstrip() == '': char = 'Old Dialogue JSON Converter (REPLACE THIS.)'

curDir = os.getcwd()

try:
    os.chdir(path)
except OSError as e:
    m = f'HAD AN ERROR NAVIGATINGG TO THAT PATH {str(e)}'
    print(m) 
    file = open('lastError.log', 'w'); file.write(m); file.close()
    exit()
rawJson = ''
try:
    rawJson = open(fileName, 'r').read()
except OSError as e:
    os.chdir(curDir)
    m = f'HAD AN ERROR OPENING FILE {str(e)}'
    print(m) 
    file = open('lastError.log', 'w'); file.write(m); file.close()
    exit()
    
json:list[list[str]] = []

try:
    json = pyjson.loads(rawJson)['dialogue']
except Exception as e:
    os.chdir(curDir)
    m = f'HAD AN ERROR OPENING FILE {str(e)}'
    print(m) 
    file = open('lastError.log', 'w'); file.write(m); file.close()
    exit()

newJson:str = ''

newArray:list[str] = []

id = -1
try:
    import string
    for array in json:
        dialogue:str
        id += 1
        image:str
        postfix:str

        dialogue = array[0]; image = array[1]; postfix = array[2]

        if postfix.rstrip().lstrip() != '': postfix = f'\n            "imagePostFix": "{postfix}",'
        finalStr = '''        {
            "dialogue": "''' + dialogue +'''",
            "name": "''' + string.capwords(image) + '''",
            "image": "dialoguePortraits/''' + image + '''",'''+ postfix +'''
            "id": ''' + str(id) + '''
        },\n'''
        newArray.append(finalStr)

except Exception as e:
    m = f'SHIT THERE WAS AN ERROR {str(e)}'
    print(m) 
    file = open('lastError.log', 'w'); file.write(m); file.close()
    exit()

newArray.append('''        {
            "dialogue": "This dialogue file converted via python script",
            "image": "null",
            "id": ''' + str(id + 1) + '''
        }''')

finalString = ''

for string in newArray:
    finalString += string

newJson = '''{
    "char": "''' + char + '''",
    "dialogue": [
''' + finalString + '''
    ]
}'''

os.chdir(curDir)

file = open(newFileName, 'w'); file.write(newJson); file.close()

print('DONE')