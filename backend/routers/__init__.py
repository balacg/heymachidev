# heymachi_backend/routers/__init__.py

from .users import router as users
from .roles import router as roles
from .auth import router as auth
from .category import router as category
from .subcategory import router as subcategory
from .product import router as product
from .tax import router as tax
from .customer import router as customer
from .vendor import router as vendor
from .unit import router as unit
from .billing import router as billing

# Add other routers here as needed
