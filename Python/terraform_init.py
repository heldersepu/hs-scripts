import os
import logging
import subprocess

def initialize_terraform():
    logging.info("Initializing terraform")
    os.environ["TF_LOG"] = "TRACE"
    subprocess.run(['terraform', 'init'])
    logging.info("completed the terraform initialization")

initialize_terraform()