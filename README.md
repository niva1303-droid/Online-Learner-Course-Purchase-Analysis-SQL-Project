# 📚 Learner-Course-Purchase-Analysis-SQL-Project

## 📌 Project Overview

This project analyzes learner course purchases using MySQL to understand learner spending, course performance, category revenue, and purchasing behavior.

The project demonstrates practical SQL skills including Joins, Aggregations, Subqueries, Correlated Subqueries, CTEs, CASE expressions, NULL handling, and Views.

The analysis is based on three relational tables:

Learners — learner information such as name and country

Courses — course details, categories, and prices

Purchases — learner transactions, quantities, dates, and total amounts

## 🎯 Project Objectives

The main objectives of this project is to:

✔️ Analyze learner spending patterns

✔️ Identify the most purchased courses

✔️ Measure revenue by course category

✔️ Identify high-value learners

✔️ Analyze learners purchasing across multiple categories

✔️ Find courses that have never been purchased

✔️ Compare learner spending against average spending

✔️ Handle NULL values appropriately

✔️ Create reusable SQL views for performance analysis

## 🗂️ Database Structure

**1. Learners**

| Column | Description |
| --- | --- |
| learner_id | Unique learner ID |
| full_name |	Learner name |
| country	| Learner's country |

**2. Courses**

| Column | Description |
| --- | --- |
| course_id	| Unique course ID |
| course_name	| Name of the course |
| category | Course category |
| unit_price | Price of the course |
| level | Course Level |

**3. Purchases**

| Column | Description |
| --- | --- |
| purchase_id	| Unique purchase ID |
| learner_id | Learner who made the purchase |
| course_id	| Purchased course |
| quantity | Number of units purchased |
| purchase_date |	Date of purchase |
| total_amount | Total purchase value |

## 🔗 SQL Relationships

The tables are connected using primary and foreign-key relationships:
```text
Learners
   │
   │ learner_id
   ▼
Purchases
   │
   │ course_id
   ▼
Courses
```
The main relationships are:

learners.learner_id → purchases.learner_id

courses.course_id → purchases.course_id

## 🧹 Data Preparation

The project includes:

Creating database tables ➡️ Inserting learner data ➡️ Inserting course data ➡️ Inserting purchase transactions ➡️ Adding the total_amount column ➡️
Calculating total purchase amount using: (quantity × unit_price)

## 📊 SQL Analysis Performed

**Core Analytical Queries**

The project answers questions such as:

Q1. What is each learner's total spending?

Q2. What are the top 3 most purchased courses?

Q3. What is the total revenue and number of unique learners in each category?

Q4. Which learners purchased courses from more than one category?

Q5. Which courses were never purchased?

## 🔍 Advanced SQL Analysis

**Subqueries**

Used subqueries to identify:

Learners spending above the average learner spending

Courses with prices higher than courses in the Beginner level

Learners spending above the average spending within their country

**CTE — Common Table Expression**

Used a CTE to calculate total spending per learner and identify learners whose spending exceeded ₹10,000.

**🏷️ CASE Expression**

Learners were classified based on their total spending:

| Spending | Classification |
| --- | --- |
| Above ₹15,000	| High Value |
| ₹8,000 – ₹15,000 | Medium Value |
| Below ₹8,000 | Low Value |

**🚫 NULL Handling**

Used LEFT JOIN together with IFNULL() to display all courses, including courses without purchases.

**👁️ SQL View**

Created a reusable view called: category_performance_view

The view provides:

🌸 Category

🌸 Total Revenue

🌸 Number of Purchases

🌸 Average Revenue Per Purchase

## 💡 Key Business Insights

**💰 Revenue**

The project generated approximately ₹1.31 lakh in total revenue from 8 purchase transactions.

**👤 Highest-Spending Learner**

Jing was the highest-spending learner with approximately ₹38,000 in purchases.

**📚 Top Revenue-Generating Course**

Global Health Policy generated the highest revenue at approximately ₹45,000.

**🏆 Best-Performing Category**

Medicine was the highest-revenue category, generating approximately ₹45,000.

**💻 Strong Performance from Data Science**

Master of Data Science generated approximately ₹40,000 from two purchases, demonstrating the impact of higher course pricing on revenue.

**🔄 Cross-Category Purchasing**

Several learners purchased courses from multiple categories, indicating opportunities for cross-selling and course recommendations.

## 🛠️ Technologies Used

MySQL | SQL | MySQL Workbench

## 📁 Project Structure

```text
Learner-Course-Purchase-Analysis/
│
├── README.md
│
├── Analyzing E-Learning Platform Purchases using MySQL.sql
│
├── screenshots.pdf
```

## 🎓 Learning Outcomes

Through this project, I strengthened my ability to:

🎇 Design and work with relational databases

🎇 Connect multiple tables using SQL joins

🎇 Perform business-oriented aggregations

🎇 Write nested and correlated subqueries

🎇 Use CTEs for structured analysis

🎇 Apply conditional logic using CASE

🎇 Handle missing values using IFNULL() and COALESCE()

🎇 Create reusable SQL views

🎇 Translate business questions into SQL queries

🎇 Extract actionable insights from transactional data

## 👩‍💻 Author

Kalaivani Baskar

Aspiring Data Analyst | SQL | Excel | Power BI | Python

📍 Chennai, India

## ⭐ Project Highlights

This project demonstrates a practical SQL workflow from:

Database Creation → Data Insertion → Data Preparation → Joins → Aggregation → Advanced Queries → Business Insights









