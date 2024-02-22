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