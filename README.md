# NVIDIA GPU Sales & Market Dynamics Analysis

An end-to-end data analytics portfolio project analyzing synthetic NVIDIA GPU sales data using **Python, SQL, and Power BI**.

The project explores sales performance, product mix, regional revenue, pricing premiums, customer satisfaction, market availability, customer segments, sales channels, bundle add-ons, and temporal trends.

> **Disclaimer:** This project uses synthetic data generated for portfolio and analytical practice. The results describe patterns within the simulated dataset and do not represent actual NVIDIA sales performance.

---

## Dashboard Preview

![NVIDIA GPU Sales Dashboard](images/dashboard_overview.png)

The Power BI dashboard provides an interactive overview of sales performance with filters for **Year** and **Month**, along with cross-filtering across selected visualizations.

---

## Project Overview

The dataset contains **7,000 simulated GPU sales transactions** covering Consumer Gaming and Data Center AI products.

The analytical workflow follows an end-to-end process:

**Synthetic Data Generation → Data Quality Assessment → Data Cleaning → Feature Engineering → Exploratory Data Analysis → SQL Analysis → Power BI Dashboard**

The project was designed to demonstrate practical data analytics skills, from preparing raw data to communicating business insights through an interactive dashboard.

---

## Tools & Technologies

| Area | Tools |
|---|---|
| Data Generation | Python |
| Data Cleaning & EDA | Python, Pandas, NumPy |
| Visualization | Matplotlib, Power BI |
| SQL Analysis | MySQL, MySQL Workbench |
| Notebook Environment | Google Colab |
| Version Control | Git, GitHub |

---

## Repository Structure

```text
Nvidia-GPU-Sales-Market-Dynamics-Analysis/
│
├── README.md
├── .gitignore
├── requirements.txt
│
├── dashboard/
│   └── nvidia_gpu_sales_dashboard.pbix
│
├── data/
│   ├── raw/
│   │   └── nvidia_gpu_sales_synthetic_2026_RAW.csv
│   │
│   └── processed/
│       ├── nvidia_gpu_sales_analysis_ready.csv
│       └── nvidia_gpu_sales_sql_ready.csv
│
├── images/
│   └── dashboard_overview.png
│
├── notebooks/
│   └── nvidia_gpu_sales_analysis.ipynb
│
├── scripts/
│   └── generate_synthetic_data.py
│
└── sql/
    └── nvidia_gpu_sales_analysis.sql
```

### Folder Description

| Folder | Purpose |
|---|---|
| `data/raw/` | Original synthetic dataset generated for the project |
| `data/processed/` | Cleaned and analysis-ready datasets |
| `notebooks/` | Python data cleaning, feature engineering, EDA, and business analysis |
| `scripts/` | Synthetic dataset generation script |
| `sql/` | MySQL business analysis queries |
| `dashboard/` | Interactive Power BI dashboard |
| `images/` | Dashboard screenshots used in project documentation |

---

## Dataset Overview

The raw dataset contains **7,000 transactions** and **17 original columns**.

Main variables include:

| Variable | Description |
|---|---|
| `sale_id` | Unique transaction identifier |
| `sale_date` | Transaction date |
| `gpu_model` | GPU product model |
| `gpu_family` | Consumer Gaming or Data Center AI |
| `launch_year` | Product launch year |
| `region` | Geographic sales region |
| `sales_channel` | Sales distribution channel |
| `customer_segment` | Customer category |
| `units_sold` | Units sold per transaction |
| `msrp_usd` | Manufacturer suggested retail price |
| `avg_street_price_usd` | Average observed market price |
| `price_premium_pct` | Percentage premium above MSRP |
| `stock_status` | Product availability status |
| `customer_satisfaction_score` | Customer satisfaction score |
| `warranty_months` | Warranty duration |
| `bundle_addon` | Additional bundle or service |
| `revenue_usd` | Transaction revenue |

---

## Data Preparation

The Python notebook performs data quality assessment before analysis.

The workflow includes:

1. Dataset structure inspection
2. Missing value analysis
3. Duplicate row validation
4. Duplicate transaction ID validation
5. Descriptive statistics
6. Missing bundle handling
7. Date conversion
8. Categorical text standardization
9. Feature engineering
10. Post-cleaning validation

The original `bundle_addon` field contained **3,841 missing values**, representing approximately **54.87%** of the dataset.

These records were interpreted as transactions without additional bundles and categorized as:

```text
Standalone
```

After cleaning:

| Validation | Result |
|---|---:|
| Remaining Missing Values | 0 |
| Duplicate Rows | 0 |
| Duplicate Sale IDs | 0 |
| Final Rows | 7,000 |

---

## Feature Engineering

Additional analytical variables were created to support deeper analysis.

### Scalping Status

Transactions were grouped based on their price premium above MSRP.

| Category | Premium Range |
|---|---:|
| Normal MSRP | 0% – 5% |
| Slight Premium | >5% – 20% |
| Heavy Scalping | >20% |

The resulting distribution was:

| Scalping Status | Transactions |
|---|---:|
| Normal MSRP | 1,921 |
| Slight Premium | 3,113 |
| Heavy Scalping | 1,966 |

### Sale Month

A monthly time variable was derived from `sale_date` to analyze changes in transaction volume and revenue over time.

### High Premium Flag

Transactions with:

```text
price_premium_pct > 50
```

were classified as high-premium transactions for additional market analysis.

---

## Overall Business Metrics

| Metric | Result |
|---|---:|
| Total Transactions | 7,000 |
| Total Units Sold | 151,719 |
| Total Revenue | $396.06M |
| Average Revenue per Transaction | $56.58K |
| Average Price Premium | 15.01% |
| Average Customer Satisfaction | 4.43 / 5 |

---

## Key Findings

### Consumer Gaming Drives Volume, Data Center AI Drives Revenue

Consumer Gaming accounted for approximately **144K units sold**, significantly higher than Data Center AI.

However, Data Center AI generated approximately **$233.11M in total revenue**, compared with approximately **$162.95M from Consumer Gaming**.

This reflects the much higher transaction values associated with enterprise-oriented GPU products.

---

### North America Generated the Highest Regional Revenue

North America was the largest regional revenue contributor.

| Region | Revenue |
|---|---:|
| North America | $121.37M |
| Europe | $91.11M |
| Asia-Pacific (ex-China) | $88.67M |
| China | $64.61M |
| Rest of World | $30.31M |

North America accounted for approximately **30.6% of total simulated revenue**.

---

### RTX 5070 Recorded the Highest Unit Sales

The highest-selling GPU models by total units sold were:

| GPU Model | Units Sold |
|---|---:|
| RTX 5070 | 30,454 |
| RTX 5070 Ti | 26,361 |
| RTX 4070 Ti Super | 22,944 |
| RTX 5080 | 20,419 |
| RTX 4080 Super | 16,672 |

High sales volume did not necessarily translate into the highest revenue because GPU prices differ substantially across product families.

---

### Revenue Leadership Differs From Unit-Sales Leadership

Enterprise GPU models generated significantly more revenue despite much lower unit volumes.

The highest-revenue GPU models included products such as **B200, H200, and H100 SXM**, demonstrating the impact of high-value Data Center AI products on overall revenue.

---

### Higher Price Premiums Are Associated With Lower Customer Satisfaction

The correlation between price premium and customer satisfaction was approximately:

```text
r = -0.67
```

Average customer satisfaction declined across higher premium categories.

| Scalping Status | Avg Premium | Avg CSAT |
|---|---:|---:|
| Normal MSRP | 2.48% | 4.76 |
| Slight Premium | 10.66% | 4.57 |
| Heavy Scalping | 34.14% | 3.88 |

This represents a strong negative association within the synthetic dataset.

The result should be interpreted as an **association rather than evidence of causality**.

---

### Enterprise Segments Generate Higher Transaction Values

Enterprise-oriented customer segments recorded substantially higher average revenue per transaction.

| Customer Segment | Avg Revenue / Transaction |
|---|---:|
| Crypto Mining | $245.71K |
| Hyperscale Datacenter | $218.51K |
| AI Research/Startup | $195.91K |
| Content Creation | $28.11K |
| Gaming | $27.37K |

This difference is strongly influenced by the higher-priced Data Center AI product mix.

---

### Sales Channels Follow Different Revenue Models

Retail/Etail generated the largest number of transactions, while enterprise-oriented channels generated much larger transaction values.

Average revenue per transaction was approximately:

| Sales Channel | Avg Revenue / Transaction |
|---|---:|
| Direct Enterprise | $226.89K |
| Cloud Provider | $212.08K |
| System Integrator/OEM | $47.60K |
| Retail/Etail | $27.27K |

This illustrates why channel performance should be evaluated using both transaction volume and transaction value.

---

### Bundle Performance Is Heavily Influenced by Product Mix

Support Contract and NVLink Cluster Install transactions recorded the highest average revenue per transaction.

| Bundle Add-on | Avg Revenue / Transaction |
|---|---:|
| Support Contract | $210.06K |
| NVLink Cluster Install | $199.41K |
| Standalone | $55.52K |
| Cooling Kit | $29.19K |
| Extended Warranty | $27.08K |
| Software Bundle | $26.75K |

However, Support Contract and NVLink Cluster Install are primarily associated with Data Center AI products.

Therefore, their higher transaction values should not be interpreted as evidence that the add-ons themselves cause higher spending.

---

### High-Premium Transactions Are Rare but Economically Significant

Transactions with price premiums above 50% represented:

| Metric | Result |
|---|---:|
| High-Premium Transactions | 259 |
| Transaction Share | 3.70% |
| Revenue | $27.51M |
| Revenue Share | 6.94% |
| Avg Revenue / Transaction | $106.20K |
| Avg Premium | 58.68% |
| Avg Customer Satisfaction | 3.13 |

Approximately **96.91%** of high-premium transactions occurred when products were classified as **Sold Out**.

This suggests that extreme premiums were heavily concentrated in constrained-availability conditions within the simulated market.

---

### Monthly Revenue Increased Substantially Over Time

The dataset covers approximately **30 months**, from early 2024 through mid-2026.

Monthly revenue increased substantially throughout the observed period and reached approximately **$28.3M at its highest point**.

Average revenue per transaction did not show a comparable sustained increase during much of 2025–2026.

This indicates that growth in total revenue was primarily associated with increased transaction volume rather than continuously increasing transaction value.

---

## Power BI Dashboard

The interactive Power BI dashboard summarizes the main findings of the project.

### KPI Cards

The dashboard displays:

- Total Revenue
- Total Units Sold
- Total Transactions
- Average Price Premium
- Average Customer Satisfaction

### Main Visualizations

The dashboard includes:

- Revenue by Region
- Monthly Revenue Trend
- Top 5 GPU Models by Units Sold
- Revenue by GPU Family
- Average Customer Satisfaction by Scalping Status

### Interactive Filters

Users can filter the dashboard by:

- Year
- Month

Selected charts also support cross-filtering to explore specific subsets of the simulated market.

---

## SQL Analysis

The SQL analysis complements the Python EDA by answering structured business questions directly from the processed dataset.

Topics include:

1. Overall GPU family performance
2. GPU model performance
3. Regional revenue
4. Scalping behavior
5. Stock availability
6. Customer segmentation
7. Sales channels
8. Bundle add-ons
9. Customer satisfaction
10. High-premium transactions

The SQL queries are available in:

```text
sql/nvidia_gpu_sales_analysis.sql
```

---

## Data Files

### Raw Dataset

```text
data/raw/nvidia_gpu_sales_synthetic_2026_RAW.csv
```

Contains the original synthetic dataset generated for the project.

### Analysis-Ready Dataset

```text
data/processed/nvidia_gpu_sales_analysis_ready.csv
```

Contains the cleaned dataset and engineered analytical features used for further exploration.

### SQL-Ready Dataset

```text
data/processed/nvidia_gpu_sales_sql_ready.csv
```

Contains the processed version prepared for import and analysis in MySQL.

---

## Reproducibility

### Generate the Synthetic Dataset

Run:

```bash
python scripts/generate_synthetic_data.py
```

### Run the Python Analysis

Open:

```text
notebooks/nvidia_gpu_sales_analysis.ipynb
```

The notebook was developed using **Google Colab**.

### Run the SQL Analysis

Import the SQL-ready dataset into MySQL and execute:

```text
sql/nvidia_gpu_sales_analysis.sql
```

### Open the Dashboard

Open the following file using Power BI Desktop:

```text
dashboard/nvidia_gpu_sales_dashboard.pbix
```

---

## Analytical Considerations

This project uses synthetic data and is intended to demonstrate analytical methodology rather than evaluate NVIDIA's real-world business performance.

Several findings describe relationships between variables, including pricing premiums, stock availability, bundle categories, and customer satisfaction.

These relationships should be interpreted as **associations within the simulated dataset and not causal conclusions**.

---

## Skills Demonstrated

- Data cleaning and validation
- Exploratory data analysis
- Feature engineering
- Data aggregation
- Business-oriented SQL querying
- Time-series analysis
- Customer segmentation analysis
- Pricing analysis
- Data visualization
- Power BI dashboard development
- Interactive filtering
- Business insight communication
- Git and repository organization

---

## Project Files

| Component | File |
|---|---|
| Data Generator | `scripts/generate_synthetic_data.py` |
| Python Analysis | `notebooks/nvidia_gpu_sales_analysis.ipynb` |
| SQL Analysis | `sql/nvidia_gpu_sales_analysis.sql` |
| Power BI Dashboard | `dashboard/nvidia_gpu_sales_dashboard.pbix` |
| Dashboard Preview | `images/dashboard_overview.png` |

---

## Author

Created as an end-to-end data analytics portfolio project using **Python, SQL, and Power BI**.
---
*Created by [Faiz-Aturr] - Let's connect on [LinkedIn](https://www.linkedin.com/in/m-faiz-aturahman-696476421)!*
