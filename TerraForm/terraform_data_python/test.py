import sys
import json
print('{"foobar":"data"}')

data = json.loads(sys.argv[1])
for element in data:
    print(element + " = " + str(data[element]))

