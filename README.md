📊 Sales Analytics Dashboard
📌 Project Overview

This project focuses on analyzing sales, orders, employees, shipping, products, and suppliers data using SQL, Excel, and Power BI. The goal was to transform raw data into meaningful insights by building an interactive dashboard that supports data-driven decision-making.

🎯 Problem Statement

Businesses often face challenges in understanding sales performance, employee distribution, product demand, and shipping efficiency. Without structured insights, it becomes difficult to:

Track key sales and order trends

Monitor employee and supplier performance

Identify inefficiencies in shipping and freight costs

Analyze customer purchasing behavior

This project addresses these problems by creating a centralized analytical dashboard.

🗂️ Dataset & Tables Used

The project uses multiple related tables with 15+ entity relationships. Key tables include:

Orders – Order details, dates, freight costs, shipping info

Customers – Customer profiles and regions

Employees – Employee details, hire dates, distribution

Products – Product categories, demand, and pricing

Suppliers – Supplier information and performance

Shippers – Shipping companies and delivery timelines

⚙️ Steps Followed
1. Data Cleaning & Preparation

Used SQL to clean raw sales data, remove duplicates, and fix inconsistencies

Integrated multiple tables with joins and relationships

Applied transformations in Excel (lookup functions, formatting, missing value handling)

2. Data Modeling

Built star schema in Power BI by connecting fact (Orders, Sales) and dimension (Products, Customers, Employees) tables

Created relationships for accurate aggregation across entities

3. Dashboard Development

Designed KPIs: Total Sales, Total Orders, Avg Shipping Days, Freight per Order, Employee Distribution

Built interactive visuals:

Sales Trends (monthly/seasonal distribution)

Employee Tenure Analysis

Product & Category Performance

Regional and Supplier Contribution

Shipping Efficiency (avg days & cost per order)

4. DAX Implementation

Custom measures for:

Freight cost per order

Average shipping time

Employee tenure

Profit margins & product performance

📊 Key Insights

Sales Trend: Clear seasonal variations with peak demand in specific months

Products: Certain categories drive the majority of sales, highlighting opportunities for inventory focus

Employees: Workforce distribution shows high concentration in a few regions → need balanced hiring

Shipping: Avg shipping time varies significantly by supplier, affecting customer satisfaction

Freight Costs: High freight per order in specific routes indicates inefficiency

✅ Conclusion

This dashboard empowers management to:

Identify top-performing products, suppliers, and employees

Optimize shipping strategy by reducing freight costs and improving timelines

Understand customer demand trends for better forecasting

Support strategic decisions with data-backed insights

🚀 Tools & Technologies

SQL (MySQL) → Data cleaning & integration

Excel → Data preprocessing & initial analysis

Power BI → Data modeling, dashboard design, DAX calculations

📸 Dashboard Preview



📂 How to Use

Clone the repo

Open the Power BI file (.pbix)

Explore interactive dashboards & filters

🙌 Author

👩‍💻 Surbhi Jain – Data Analyst | Passionate about turning raw data into actionable insights
