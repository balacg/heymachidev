# hm_industries/restaurant/backend/main.py

# ❌ TEMPORARY FILE — NOT NEEDED IF HEYMACHI IS MAIN APP
# ✅ Use only for isolated tests (not recommended in production)

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
#from restaurant.backend.routers import open_order_router
from ..bootstrap import *

app = FastAPI(title="HeyMachi Restaurant API")

# CORS (keep permissive only for dev)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register open order router
#app.include_router(open_order_router.router, prefix="/restaurant/open-orders", tags=["Restaurant Orders"])

@app.get("/")
def ping():
    return {"status": "alive"}
