import pandas as pd

unique_leads = (
    daily_sales
    .groupby(['date_id', 'make_name'])['lead_id']
    .nunique()
    .reset_index(name='unique_leads')
)

unique_partners = (
    daily_sales
    .groupby(['date_id', 'make_name'])['partner_id']
    .nunique()
    .reset_index(name='unique_partners')
)

ans = pd.merge(unique_leads, unique_partners, on=['date_id', 'make_name'])

def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    merged_tables = pd.merge(product, sales, how='inner', on='product_id')
    return merged_tables [['product_name','year','price']]