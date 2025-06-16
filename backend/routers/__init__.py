# heymachi_backend/routers/__init__.py

from .users import router as users
from .role import router as roles
from .auth import router as auth
from .category import router as category
from .subcategory import router as subcategory
from .product import router as product
from .tax import router as tax
from .customer import router as customer
from .vendor import router as vendor
from .unit import router as unit
from .billing import router as billing
from .payment_type import router as payment_type
from .transaction import router as transaction
from .email import router as email
from .business_profile import router as business_profile
from .promotion import router as promotion

from .industry import router as industry_router
from .business_account import router as business_account
from .branch import router as branch
from .role import router as role 

# Add other routers here as needed
