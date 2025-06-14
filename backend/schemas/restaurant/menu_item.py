# backend/schemas/restaurant/menu_item.py

from pydantic import BaseModel
from typing import Optional

class MenuItemBase(BaseModel):
    name: str
    description: Optional[str]
    price: float
    category: Optional[str]

class MenuItemCreate(MenuItemBase):
    pass

class MenuItemUpdate(MenuItemBase):
    pass

class MenuItemOut(MenuItemBase):
    id: str

    class Config:
        orm_mode = True
