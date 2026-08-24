# 📚 Library Management & Borrowing Analysis

## SQL Data Analyst Portfolio Project

A SQL-based data analysis project that analyzes library members, books, borrowing transactions, customer behavior, category performance, and revenue generation using **MySQL**.

---

## 📌 Project Overview

This project analyzes a library management dataset containing information about members, books, and borrowing transactions.

The objective is to transform raw transactional data into meaningful business insights using SQL.

The analysis focuses on:

* Member borrowing behavior
* Book popularity
* Category performance
* Revenue generation
* Customer spending
* City-wise revenue
* Borrowing patterns
* Advanced SQL analysis
* Data quality and validation

The project demonstrates practical SQL skills required for a **Data Analyst** role.

---

# 🎯 Business Problem

The library has transactional data related to its members, books, and borrowing activities. However, raw data alone does not provide clear insights into customer behavior, book demand, or revenue performance.

The objective of this analysis is to answer important business questions such as:

* How many members are registered?
* How many books are available?
* How many borrowing transactions have occurred?
* What is the total revenue generated?
* What is the average spending per transaction?
* Which members are the highest spenders?
* Which members borrow the most books?
* Which books are most popular?
* Which books have never been borrowed?
* Which categories generate the highest revenue?
* Which cities generate the highest revenue?
* Which books generate the most revenue?
* How does a member's latest spending compare with their average spending?
* What is the revenue contribution of individual transactions within each category?

---

# 📊 Dataset Description

The project uses three CSV datasets.

## 1. Members Dataset

Contains information about library members.

| Column        | Description                             |
| ------------- | --------------------------------------- |
| `member_id`   | Unique identifier for each member       |
| `member_name` | Name of the member                      |
| `city`        | City of the member                      |
| `join_date`   | Date when the member joined the library |

**Total Records:** 15 members

---

## 2. Books Dataset

Contains information about books available in the library.

| Column      | Description                     |
| ----------- | ------------------------------- |
| `book_id`   | Unique identifier for each book |
| `book_name` | Name of the book                |
| `category`  | Category of the book            |
| `price`     | Price of the book               |

**Total Records:** 20 books

---

## 3. Borrow Dataset

Contains library borrowing transaction records.

| Column        | Description                            |
| ------------- | -------------------------------------- |
| `borrow_id`   | Unique identifier for each transaction |
| `member_id`   | Member who borrowed the book           |
| `book_id`     | Book that was borrowed                 |
| `borrow_date` | Date of borrowing                      |
| `quantity`    | Number of books borrowed               |

**Total Records:** 25 transactions

---

# 🔗 Database Schema

The three tables are connected through primary and foreign keys.

```text
Members
   |
   | member_id
   |
   ↓
Borrow
   ↑
   |
   | book_id
   |
Books
```

### Relationships

```text
members.member_id → borrow.member_id

books.book_id → borrow.book_id
```

The `borrow` table acts as the transaction table connecting members and books.

---

# 🛠️ Tools & Technologies

* MySQL
* SQL
* MySQL Workbench
* CSV
* GitHub

---

# 🔍 SQL Analysis

The project is divided into seven major analytical sections.

## 1. Data Validation

Data quality was checked before performing analysis.

Validation included:

* Duplicate member IDs
* Duplicate book IDs
* NULL values
* Invalid member foreign keys
* Invalid book foreign keys
* Invalid book prices
* Invalid borrowing quantities

The validation queries ensure that the dataset is reliable before analysis.

---

# 📈 2. KPI Analysis

Key performance indicators were calculated to understand the overall performance of the library.

| KPI                              |   Value |
| -------------------------------- | ------: |
| Total Members                    |      15 |
| Total Books                      |      20 |
| Total Transactions               |      25 |
| Total Revenue                    | ₹21,100 |
| Average Spending per Transaction |    ₹844 |

### Revenue Formula

```text
Revenue = Quantity × Book Price
```

---

# 👥 3. Customer Analysis

Customer-level analysis was performed to understand member behavior and spending patterns.

The analysis includes:

* Borrowing transactions by member
* Total books borrowed by member
* Total spending by member
* Members spending above average
* Top 3 members by spending
* Member borrowing behavior

### Top Spending Members

| Rank | Member       | Total Spending |
| ---: | ------------ | -------------: |
|    1 | Rahul Sharma |         ₹3,050 |
|    2 | Neha Verma   |         ₹3,000 |
|    3 | Amit Kumar   |         ₹2,900 |

Rahul Sharma is the highest-spending member with total spending of **₹3,050**.

---

# 📚 4. Book & Category Analysis

The project analyzes book demand and category performance.

Analysis includes:

* Number of books in each category
* Average price by category
* Total quantity borrowed by category
* Most borrowed book
* Books that have never been borrowed
* Top expensive books from each category

### Most Borrowed Book

**Atomic Habits** was the most borrowed book with a total borrowing quantity of **4**.

### Books Never Borrowed

The analysis also identifies books that have never appeared in the borrowing transactions.

This can help the library identify books with low demand.

---

# 💰 5. Revenue Analysis

Revenue analysis focuses on understanding where the library's revenue comes from.

The analysis includes:

* Category-wise revenue
* Highest revenue-generating category
* City-wise revenue
* Top 3 books by revenue
* Revenue contribution by category
* Transaction-level revenue contribution

### Category Revenue

| Category   | Revenue |
| ---------- | ------: |
| Education  |  ₹6,150 |
| Finance    |  ₹4,600 |
| Self Help  |  ₹4,350 |
| Technology |  ₹4,200 |
| Fiction    |  ₹1,800 |

### Key Finding

**Education** generated the highest revenue at **₹6,150**.

It was followed by:

* Finance — ₹4,600
* Self Help — ₹4,350
* Technology — ₹4,200
* Fiction — ₹1,800

---

# 🏙️ City-wise Revenue

Revenue was also analyzed based on member cities.

| City    | Revenue |
| ------- | ------: |
| Delhi   |  ₹8,700 |
| Patna   |  ₹5,000 |
| Mumbai  |  ₹3,500 |
| Lucknow |  ₹2,600 |
| Jaipur  |  ₹1,300 |

### Key Finding

**Delhi generated the highest revenue at ₹8,700**, making it the strongest city in terms of revenue contribution.

---

# 📖 Top 3 Books by Revenue

| Book                      | Category  | Revenue |
| ------------------------- | --------- | ------: |
| Atomic Habits             | Self Help |  ₹2,800 |
| The Psychology of Money   | Finance   |  ₹2,400 |
| Data Analytics with Excel | Education |  ₹1,950 |

### Key Finding

**Atomic Habits** generated the highest revenue among individual books with **₹2,800**.

---

# 🚀 6. Advanced SQL Analysis

Advanced SQL techniques were used to perform deeper analysis.

The project includes:

### Window Functions

* `ROW_NUMBER()`
* `RANK()`
* `LAG()`
* `AVG() OVER()`
* `SUM() OVER()`
* `PARTITION BY`

### CTEs

Common Table Expressions were used to simplify complex analytical queries.

### Subqueries

Subqueries were used for:

* Average spending comparisons
* Most expensive book analysis
* Member spending comparisons
* Category-level comparisons

### Other SQL Techniques

* `CASE WHEN`
* `NOT EXISTS`
* `LEFT JOIN`
* `DATEDIFF()`
* Aggregate functions
* Filtering with `HAVING`

---

## 🔬 Advanced Analysis Examples

### Top 2 Expensive Books from Each Category

Used:

```sql
ROW_NUMBER() OVER(
    PARTITION BY category
    ORDER BY price DESC
)
```

This identifies the most expensive books within every category.

---

### Previous Borrowing Analysis

Used:

```sql
LAG()
```

to compare a member's current borrowing date with their previous borrowing date.

This helps identify borrowing frequency and gaps between transactions.

---

### Latest Spending vs Average Spending

A combination of:

```sql
AVG() OVER()
ROW_NUMBER()
PARTITION BY
```

was used to identify members whose latest transaction spending was higher than their historical average spending.

---

### Running Category Revenue

Used:

```sql
SUM() OVER(
    PARTITION BY category
    ORDER BY borrow_date
)
```

to calculate cumulative revenue for each category over time.

---

### Transaction Revenue Contribution

Each transaction's contribution to its category's total revenue was calculated using window functions.

```text
Transaction Revenue
---------------------------- × 100
Category Total Revenue
```

---

# 💡 7. Business Insights

The SQL analysis produced several important business insights.

### 1. High-value customers

Rahul Sharma is the highest-spending member with **₹3,050** in total spending.

Neha Verma and Amit Kumar are the next highest-spending members.

These customers represent high-value members and could be targeted for loyalty programs or personalized recommendations.

---

### 2. Education is the strongest revenue category

Education generated **₹6,150**, the highest revenue among all categories.

This indicates strong demand for educational books.

The library could consider:

* Expanding the Education collection
* Adding more popular educational titles
* Promoting educational books to relevant members

---

### 3. Delhi is the strongest revenue-generating city

Delhi generated **₹8,700**, which is the highest revenue among all cities.

This suggests that members from Delhi have significantly higher borrowing/spending activity.

---

### 4. Atomic Habits is the strongest individual book

Atomic Habits:

* Most borrowed book — **4 units**
* Highest individual book revenue — **₹2,800**

This makes it one of the strongest-performing books in the dataset.

The library should consider maintaining sufficient availability of this title.

---

### 5. Fiction has relatively low revenue

Fiction generated only **₹1,800**, the lowest category revenue.

This may indicate lower demand compared with Education, Finance, Self Help, and Technology.

The library could investigate whether:

* The current Fiction collection is relevant
* Popular Fiction titles are missing
* Members prefer other categories

---

### 6. Some books have zero borrowing activity

The analysis identified books that have never been borrowed.

These books may represent underutilized inventory.

The library could consider:

* Promotional campaigns
* Member recommendations
* Bundling less popular books with popular titles
* Reviewing whether these books should remain in the collection

---

# 🎯 Business Recommendations

Based on the analysis, the following recommendations can be made:

### Recommendation 1 — Focus on high-performing categories

Increase the availability of books in high-performing categories such as:

* Education
* Finance
* Self Help
* Technology

---

### Recommendation 2 — Promote high-demand books

Books such as **Atomic Habits** should be kept sufficiently available due to their high borrowing and revenue performance.

---

### Recommendation 3 — Target high-value members

High-spending members can be targeted with:

* Loyalty programs
* Personalized recommendations
* Early access to new books
* Member-specific offers

---

### Recommendation 4 — Improve underperforming inventory

Books with zero borrowing activity should be reviewed and promoted before making decisions about removing them from the collection.

---

### Recommendation 5 — Focus on high-performing cities

Since Delhi generates the highest revenue, marketing and member engagement strategies could prioritize this market.

---

# 🧠 Key SQL Skills Demonstrated

This project demonstrates practical knowledge of:

```text
SELECT
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
DISTINCT
Aggregate Functions
INNER JOIN
LEFT JOIN
Subqueries
Correlated Subqueries
CTEs
CASE WHEN
NOT EXISTS
RANK()
ROW_NUMBER()
LAG()
AVG() OVER()
SUM() OVER()
PARTITION BY
DATEDIFF()
```

---

# 📂 Project Structure

```text
library-management-borrowing-analysis/
│
├── data/
│   ├── members.csv
│   ├── books.csv
│   └── borrow.csv
│
├── sql/
│   └── library_analysis.sql
│
└── README.md
```

---

# ▶️ How to Run the Project

### Step 1 — Create the Database

Create a MySQL database:

```sql
CREATE DATABASE library_management;
USE library_management;
```

### Step 2 — Create Tables

Create the following tables:

```text
members
books
borrow
```

### Step 3 — Load the CSV Data

Import:

```text
members.csv
books.csv
borrow.csv
```

into the respective MySQL tables.

### Step 4 — Run the SQL Analysis

Open:

```text
sql/library_analysis.sql
```

and execute the queries section by section.

---

# 📌 Project Outcome

This project demonstrates how SQL can be used to move from raw transactional data to actionable business insights.

The analysis covers the complete workflow:

```text
Raw Data
   ↓
Data Validation
   ↓
KPI Analysis
   ↓
Customer Analysis
   ↓
Book & Category Analysis
   ↓
Revenue Analysis
   ↓
Advanced SQL Analysis
   ↓
Business Insights
   ↓
Recommendations
```

---

# 🏁 Conclusion

The Library Management & Borrowing Analysis project demonstrates a practical approach to analyzing transactional data using MySQL.

The analysis identified key performance indicators, high-value members, popular books, high-performing categories, and revenue-generating cities.

The project also demonstrates advanced SQL techniques such as CTEs, subqueries, window functions, ranking, previous transaction analysis, running totals, and revenue contribution analysis.

Overall, the project provides a complete example of how a Data Analyst can use SQL to transform raw data into meaningful business insights and recommendations.

---

## 👨‍💻 Author

**Vivek Rai**

### Skills Demonstrated

`SQL` • `MySQL` • `Data Analysis` • `Data Validation` • `Business Analysis` • `Window Functions` • `CTEs` • `Joins` • `Subqueries`

---

## ⭐ Project Highlights

* 15 library members analyzed
* 20 books analyzed
* 25 borrowing transactions analyzed
* ₹21,100 total revenue analyzed
* ₹844 average spending per transaction
* Customer spending analysis
* Book popularity analysis
* Category revenue analysis
* City-wise revenue analysis
* Advanced SQL window function analysis
* Business recommendations based on data
