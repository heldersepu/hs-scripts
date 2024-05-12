import logging
import layer

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    print(layer.foo(1, 2))
    if ("ERROR" in event):
        logging.error("malfunction detected...")
    else:
        logging.info(event)
