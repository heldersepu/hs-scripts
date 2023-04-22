import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    if (event == "ERROR"):
        logging.error("malfunction detected...")
    else:
        logging.info(event)
