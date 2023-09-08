import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    logging.info(event)
