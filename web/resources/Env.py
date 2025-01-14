import os       # pega a var de amb do SO
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv('BASE_URL')
BROWSER = os.getenv('BROWSER')
HEADLESS = os.getenv('HEADLESS')