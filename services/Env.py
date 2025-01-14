import os       # pega a var de amb do SO
from dotenv import load_dotenv

load_dotenv()

API_URL = os.getenv('API_URL')
