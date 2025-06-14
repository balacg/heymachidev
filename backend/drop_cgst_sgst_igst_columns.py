# alembic/versions/drop_cgst_sgst_igst_columns.py
"""Drop CGST/SGST/IGST columns from taxes"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision = 'drop_tax_split_cols'
down_revision = 'your_previous_revision_id'  # Replace with actual
branch_labels = None
depends_on = None

def upgrade():
    with op.batch_alter_table("taxes") as batch_op:
        batch_op.drop_column('cgst_percent')
        batch_op.drop_column('sgst_percent')
        batch_op.drop_column('igst_percent')

def downgrade():
    with op.batch_alter_table("taxes") as batch_op:
        batch_op.add_column(sa.Column('cgst_percent', sa.Float(), nullable=True))
        batch_op.add_column(sa.Column('sgst_percent', sa.Float(), nullable=True))
        batch_op.add_column(sa.Column('igst_percent', sa.Float(), nullable=True))
