import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    if ("ERROR" in event):
        logging.error("malfunction detected...")
    else:
        logging.info(event)
