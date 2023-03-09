import json

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