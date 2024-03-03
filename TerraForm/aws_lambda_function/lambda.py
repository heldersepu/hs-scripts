import logging
import numpy as np

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    if ("ERROR" in event):
        logging.error("malfunction detected...")
    else:
        a = np.array([[1, 2], [3, 4]])
        logging.info(np.add(a, a))
