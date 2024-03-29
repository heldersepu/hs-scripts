import sys
import logging

class Data:
    foo = 123
    bar = {}
    arr_num = [123] * 500

def get_size(obj, seen=None):
    """Recursively finds size of objects"""
    size = sys.getsizeof(obj)
    if seen is None:
        seen = set()
    obj_id = id(obj)
    if obj_id in seen:
        return 0
    # Important mark as seen *before* entering recursion to gracefully handle
    # self-referential objects
    seen.add(obj_id)
    if isinstance(obj, dict):
        size += sum([get_size(v, seen) for v in obj.values()])
        size += sum([get_size(k, seen) for k in obj.keys()])
    elif hasattr(obj, '__dict__'):
        size += get_size(obj.__dict__, seen)
    elif hasattr(obj, '__iter__') and not isinstance(obj, (str, bytes, bytearray)):
        size += sum([get_size(i, seen) for i in obj])
    return size

data = Data()

logger = logging.getLogger()
logger.setLevel(logging.INFO)

print("MEM_USAGE", filter(lambda x: x[0][:1] != "_", ((n, sys.getsizeof(v)) for n, v in globals().items())))
print("data", get_size(data))
print("logger", get_size(logger))

