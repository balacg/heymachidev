# heymachi_backend/utils/gst_resolver.py

def resolve_gst(product_gst_id, subcategory_gst_id, category_gst_id):
    return product_gst_id or subcategory_gst_id or category_gst_id
