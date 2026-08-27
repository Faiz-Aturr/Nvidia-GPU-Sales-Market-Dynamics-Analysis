import numpy as np
import pandas as pd
from datetime import date, timedelta

rng = np.random.default_rng(42)
N = 7000

# GPU catalog: model -> (family, msrp_usd, launch_year, base_monthly_units_weight)
catalog = {
    "RTX 5090":        ("Consumer Gaming", 1999,  2025, 1.0),
    "RTX 5080":        ("Consumer Gaming", 999,   2025, 1.6),
    "RTX 5070 Ti":     ("Consumer Gaming", 749,   2025, 2.0),
    "RTX 5070":        ("Consumer Gaming", 549,   2025, 2.4),
    "RTX 4090":        ("Consumer Gaming", 1599,  2022, 1.1),
    "RTX 4080 Super":  ("Consumer Gaming", 999,   2024, 1.3),
    "RTX 4070 Ti Super":("Consumer Gaming", 799,  2024, 1.7),
    "H100 SXM":        ("Data Center AI",  27000, 2022, 0.35),
    "H200":            ("Data Center AI",  35000, 2024, 0.5),
    "B200":            ("Data Center AI",  42000, 2025, 0.55),
    "A100 80GB":       ("Data Center AI",  15000, 2020, 0.2),
    "L40S":            ("Data Center AI",  9000,  2023, 0.4),
}
models = list(catalog.keys())
model_weights = np.array([catalog[m][3] for m in models])
model_weights = model_weights / model_weights.sum()

regions = ["North America", "Europe", "China", "Asia-Pacific (ex-China)", "Rest of World"]
region_weights = [0.32, 0.24, 0.16, 0.20, 0.08]

channels = ["Retail/Etail", "System Integrator/OEM", "Cloud Provider", "Direct Enterprise"]
segments_gaming = ["Gaming", "Content Creation"]
segments_dc = ["AI Research/Startup", "Hyperscale Datacenter", "Crypto Mining"]

stock_statuses = ["In Stock", "Low Stock", "Backordered", "Sold Out"]

start_date = date(2024, 1, 1)
end_date = date(2026, 6, 30)
date_range_days = (end_date - start_date).days

rows = []
for i in range(N):
    model = rng.choice(models, p=model_weights)
    family, msrp, launch_year, _ = catalog[model]

    # sale date: weighted toward more recent months (AI/GPU demand ramp), can't sell before launch
    launch_offset_days = max(0, (date(launch_year, 1, 1) - start_date).days)
    t = rng.beta(2.2, 1.3)  # skew toward later dates
    day_offset = int(launch_offset_days + t * (date_range_days - launch_offset_days))
    day_offset = min(day_offset, date_range_days)
    sale_date = start_date + timedelta(days=day_offset)

    region = rng.choice(regions, p=region_weights)

    if family == "Consumer Gaming":
        channel = rng.choice(["Retail/Etail", "System Integrator/OEM"], p=[0.75, 0.25])
        segment = rng.choice(segments_gaming, p=[0.8, 0.2])
        units_sold = int(rng.gamma(4.0, 6.0)) + 1  # many small-ish retail batches
    else:
        channel = rng.choice(["Cloud Provider", "Direct Enterprise", "System Integrator/OEM"], p=[0.5, 0.35, 0.15])
        segment = rng.choice(segments_dc, p=[0.3, 0.55, 0.15])
        units_sold = int(rng.gamma(2.0, 3.0)) + 1  # fewer, bulkier line items

    # China export-control friction on Data Center AI parts: lower stock, higher premium
    china_dc_friction = 1.0
    if region == "China" and family == "Data Center AI":
        china_dc_friction = rng.uniform(1.15, 1.6)

    # crypto mining spikes drive extra premium/scalping on consumer cards
    crypto_bump = 1.0
    if segment == "Crypto Mining":
        crypto_bump = rng.uniform(1.1, 1.4)

    stock_roll = rng.random()
    if stock_roll < 0.45:
        stock_status = "In Stock"
        premium_base = rng.uniform(0.0, 0.08)
    elif stock_roll < 0.72:
        stock_status = "Low Stock"
        premium_base = rng.uniform(0.05, 0.22)
    elif stock_roll < 0.9:
        stock_status = "Backordered"
        premium_base = rng.uniform(0.15, 0.40)
    else:
        stock_status = "Sold Out"
        premium_base = rng.uniform(0.25, 0.65)

    premium_pct = premium_base * china_dc_friction * crypto_bump
    premium_pct = float(np.clip(premium_pct, 0, 1.2))
    street_price = msrp * (1 + premium_pct)

    revenue = units_sold * street_price

    # satisfaction: inversely related to premium, with noise; datacenter buyers a bit less price-sensitive
    sensitivity = 3.5 if family == "Consumer Gaming" else 2.0
    satisfaction = 5.0 - sensitivity * premium_pct + rng.normal(0, 0.5)
    satisfaction = float(np.clip(round(satisfaction * 2) / 2, 1.0, 5.0))

    warranty_months = int(rng.choice([12, 24, 36], p=[0.5, 0.35, 0.15]))

    if family == "Consumer Gaming":
        addon = rng.choice(["None", "Extended Warranty", "Software Bundle", "Cooling Kit"], p=[0.55, 0.2, 0.15, 0.10])
    else:
        addon = rng.choice(["None", "Support Contract", "NVLink Cluster Install"], p=[0.5, 0.35, 0.15])

    rows.append({
        "sale_id": i + 1,
        "sale_date": sale_date.isoformat(),
        "gpu_model": model,
        "gpu_family": family,
        "launch_year": launch_year,
        "region": region,
        "sales_channel": channel,
        "customer_segment": segment,
        "units_sold": units_sold,
        "msrp_usd": msrp,
        "avg_street_price_usd": round(street_price, 2),
        "price_premium_pct": round(premium_pct * 100, 2),
        "stock_status": stock_status,
        "customer_satisfaction_score": satisfaction,
        "warranty_months": warranty_months,
        "bundle_addon": addon,
        "revenue_usd": round(revenue, 2),
    })

df = pd.DataFrame(rows).sort_values("sale_date").reset_index(drop=True)
df["sale_id"] = range(1, len(df) + 1)
df.to_csv("nvidia_gpu_sales_synthetic_2026_RAW.csv", index=False)
print(df.shape)
print(df.head(3).to_string())
print(df["gpu_family"].value_counts())
print(df.isnull().sum().sum(), "nulls")
