# 📦 Amazon Product Analytics & Pricing Strategy Dashboard

An end-to-end data analytics project exploring product pricing, discounts, customer ratings, and category performance across Amazon products using **Python**, **SQL**, and **Tableau**.

---

## 📌 Executive Summary
This project analyzes product listings from Amazon to understand how discount strategies influence customer engagement (rating counts) and overall ratings across various product categories. By building an end-to-end pipeline—from raw data extraction and ETL with Python to relational analysis via SQL and interactive visualization in Tableau—this project delivers actionable business insights for e-commerce catalog management and pricing strategy.

---

## 🛠️ Tech Stack & Tools

* **Python (Pandas, NumPy):** Data cleaning, string parsing, type casting, and feature engineering.
* **SQL (PostgreSQL / SQLite):** Relational data modeling, group aggregation, and business logic queries.
* **Tableau (Desktop / Public):** Interactive visual dashboard, Calculated Fields, Parameters, and KPI tracking.
* **Git/GitHub:** Version control and portfolio documentation.

---

## 📁 Repository Structure

```text
├── data/
│   ├── raw/amazon.csv             # Raw extracted Amazon product dataset
│   └── processed/amazon_clean.csv # Processed dataset ready for SQL/Tableau
├── scripts/
│   └── data_cleaning.py           # Python ETL pipeline script
├── sql/
│   └── analytical_queries.sql     # Business metrics & aggregation queries
├── dashboard/
│   └── amazon_analytics.twbx      # Tableau Packaged Workbook file
├── docs/
│   └── dashboard_preview.png      # Tableau Dashboard preview image
└── README.md                      # Project documentation
```

---

## 🔄 Data Lifecycle & Workflow

```text
[ Raw CSV Data ]
       │
       ▼ (Python ETL)
[ Data Cleaning & Feature Engineering ]
       │
       ▼ (CSV Load)
[ SQL Database Ingestion ] ──► [ SQL Business Analytics ]
       │
       ▼ (Extract / Live Connection)
[ Tableau Interactive Dashboard ]
```

---

## 🧹 Phase 1: Data Cleaning & Transformation (Python)

### Key Challenges & Cleaning Steps:
1. **Price Formatting:** Removed currency symbols (`₹`) and commas (`,`) from `discounted_price` and `actual_price`, converting them to numeric float fields.
2. **Rating Parsing:** Handled invalid values (e.g., non-numeric string characters like `"|"`) in `rating` and missing values in `rating_count`.
3. **Category Splitting:** Split pipe-delimited category strings (`Computers&Accessories|Accessories&Peripherals|...`) into primary `main_category` and granular `sub_category` attributes.
4. **Derived Metrics Engineered:**
   * `discount_amount`: Calculated as $\text{actual\_price} - \text{discounted\_price}$.
   * `discount_percentage`: Verified and standard-scaled for analytical consistency.

---

## 🗄️ Phase 2: Relational Analytics (SQL)

### Core Business Questions Answered:

#### 1. Top Categories by Total Revenue & Catalog Size
```sql
SELECT 
    main_category,
    COUNT(product_id) AS product_count,
    ROUND(SUM(discounted_price), 2) AS total_revenue_inr,
    ROUND(AVG(discounted_price), 2) AS avg_selling_price
FROM amazon_products
GROUP BY main_category
ORDER BY total_revenue_inr DESC;
```

#### 2. Discount Efficiency & Rating Correlation
```sql
SELECT 
    main_category,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG((actual_price - discounted_price) / actual_price * 100), 2) AS avg_discount_pct,
    SUM(rating_count) AS total_reviews
FROM amazon_products
GROUP BY main_category
HAVING COUNT(product_id) >= 10
ORDER BY total_reviews DESC;
```

#### 3. Best-Selling High-Performing Products
```sql
SELECT 
    product_name,
    main_category,
    discounted_price,
    rating,
    rating_count
FROM amazon_products
WHERE rating >= 4.2 AND rating_count > 10000
ORDER BY rating_count DESC
LIMIT 10;
```

---

## 📊 Phase 3: Interactive Dashboard (Tableau)

The Tableau dashboard provides an executive-level overview and deep-dive capabilities across product hierarchies:

### Key Metrics & Visuals
* **Executive KPI Scorecards:** Total Catalog Products, Average Rating, Total Sales Value (INR), and Average Discount %.
* **Category Revenue Breakdown:** Horizontal bar chart showing revenue distribution across primary categories.
* **Discount vs. Engagement Analysis:** Scatter plot evaluating how discount percentage correlates with customer review volume.
* **Top Product Leaderboard:** Dynamic filterable table displaying top-performing products by customer satisfaction and volume.
* **Interactive Actions:** Filter action across worksheets driven by `Main Category` selection.

---

## 💡 Key Business Insights

1. **Category Dominance:** Electronics and Accessories account for the highest volume of listings and total revenue potential within the catalog.
2. **Discount vs. Rating:** High discounts (>50%) drive higher review volumes (`rating_count`), indicating increased sales volume, but do not negatively impact average product ratings.
3. **Rating Thresholds:** Products with ratings above 4.2 generate over 80% of all customer review activity, emphasizing the role of post-purchase feedback in e-commerce traction.

---

## 🚀 How to Run This Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/amazon-analytics-portfolio.git
   cd amazon-analytics-portfolio
   ```

2. **Run Python ETL Script:**
   ```bash
   python scripts/data_cleaning.py
   ```

3. **Execute SQL Queries:**
   Load `data/processed/amazon_clean.csv` into your preferred database (PostgreSQL, SQLite, MySQL) and run `sql/analytical_queries.sql`.

4. **Explore Tableau Dashboard:**
   Open `dashboard/amazon_analytics.twbx` in Tableau Desktop / Tableau Public to interact with the dashboard.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
