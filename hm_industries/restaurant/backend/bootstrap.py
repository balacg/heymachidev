# hm_industries/restaurant/backend/bootstrap.py

import os
import sys

# Dynamically resolve the core backend path
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../../../heymachi/backend"))

if ROOT not in sys.path:
    sys.path.insert(0, ROOT)
