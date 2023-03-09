import json
import os

file_path = 'user.json'

if os.path.exists(file_path):
  print('El fichero existe')
else:
  print('El fichero no existe')
  
  datos = {
  'name': 'John',
  'age': 50,
  'is_married': False,
  'profession': None,
  'hobbies': ['travelling', 'photography']
}

with open('user.json', 'w') as archivo:
    json.dump(datos, archivo)

with open('user.json') as user_file:
  file_contents = user_file.read()
  
print(file_contents)

parsed_json = json.loads(file_contents)
# {
#   'name': 'John',
#   'age': 50,
#   'is_married': False,
#   'profession': None,
#   'hobbies': ['travelling', 'photography']
# }