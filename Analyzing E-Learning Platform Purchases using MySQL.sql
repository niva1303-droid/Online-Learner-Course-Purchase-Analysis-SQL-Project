-- Analyzing E-Learning Platform Purchases using MySQL

create database onlinelearner_db;

use onlinelearner_db;

create table learners(
	learner_id int primary key,
    full_name varchar(50),
	country varchar(50)
);

create table courses(
	course_id int primary key,
    course_name varchar(50),
    category varchar(30),
    unit_price int
);

create table purchases(
	purchase_id int primary key,
    learner_id int,
    course_id int,
    quantity int,
    purchase_date date,

Foreign Key(learner_id) References learners(learner_id),
Foreign Key(course_id) References courses(course_id)
);

Insert into learners (learner_id, full_name, country) values
('1001', 'Gayathri', 'India'),
('1002', 'Jing', 'China'),
('1003', 'Himari', 'Japan'),
('1004', 'Maria', 'Russia'),
('1005', 'Amara', 'Africa');

Insert into courses (course_id, course_name, category, unit_price) values
('101', 'Chartered Accountant', 'Finance', '10000.00'),
('102', 'Chinese for Beginners', 'Language', '4000.00'),
('103', 'Global Health Policy', 'Medicine', '15000.00'),
('104', 'Master of Data Science', 'Computer Science', '20000.00'),
('105', 'Beauty Therapy', 'Cosmetology', '8000.00');

Insert into purchases (purchase_id, learner_id, course_id, quantity, purchase_date) values
('201', '1001', '101', 1, '2026-08-01'),
('202', '1002', '102', 2, '2026-08-03'),
('203', '1003', '103', 1, '2026-08-05'),
('204', '1004', '104', 1, '2026-08-07'),
('205', '1005', '105', 3, '2026-08-10'),
('206', '1001', '104', 1, '2026-08-12'),
('207', '1002', '103', 2, '2026-08-15'),
('208', '1003', '102', 1, '2026-08-18');

Select * from courses;
Select * from learners;
Select * from purchases;

-- Data Exploration Using Joins (Use INNER, LEFT, and RIGHT JOIN)

Alter table purchases
Add column Total_amount decimal(10,2);    
    
Update purchases as p
Inner Join courses as c
	on p.course_id = c.course_id
Set p.total_amount = p.quantity * c.unit_price;

Select l.full_name as "Learner Name", 
	   c.course_name as "Course Name", 
       c.category as "Category",
       p.quantity as "Quantity", 
       p.purchase_date as "Purchase Date", 
       p.total_amount as "Total Amount"
From purchases p
Inner Join learners l
	on p.learner_id = l.learner_id
Inner Join courses c
	on p.course_id = c.course_id
Order by p.total_amount desc;

Select l.full_name as "Learner Name", 
	   c.course_name as "Course Name", 
       c.category as "Category",
       p.quantity as "Quantity", 
       p.purchase_date as "Purchase Date", 
       p.total_amount as "Total Amount"
From learners l
Left Join purchases p
	on l.learner_id = p.learner_id
Left Join courses c
	on p.course_id = c.course_id
Order by p.total_amount desc;

Select l.full_name as "Learner Name", 
	   c.course_name as "Course Name", 
       c.category as "Category",
       p.quantity as "Quantity", 
       p.purchase_date as "Purchase Date", 
       p.total_amount as "Total Amount"
From purchases p
Right Join courses c
	on p.course_id = c.course_id
Left Join learners l
	on l.learner_id = p.learner_id	
Order by p.total_amount desc;

-- Q1. Display each learner’s total spending with their country. 

Select l.full_name as "Learner Name", 
	   l.country as "Country", 
       sum(p.Total_amount) as "Total Amount"
From learners l
Left Join purchases p
	on l.learner_id = p.learner_id
Group by l.learner_id,
		 l.full_name,
         l.country
Order by sum(p.Total_amount) desc;

-- Q2. Find the top 3 most purchased courses by quantity. 

Select c.course_name as "Course Name",
	   Sum(p.quantity) as "Total Quantity Purchased"
from Courses c
Inner Join purchases p
	on c.course_id = p.course_id
Group by c.course_id,
		 c.course_name
Order by Sum(p.quantity) desc
Limit 3;

-- Q3. Total revenue and Number of unique learners 

Select c.category as "Category",
	   sum(p.total_amount) as "Total Revenue",
       count(distinct p.learner_id) as "Unique Learners"
From courses c
Left Join purchases p
	on c.course_id = p.course_id
Group By c.category
Order by sum(p.total_amount) desc;

-- Q4. List learners who purchased from more than one category. 

Select l.full_name as "Learners",
	   count(distinct c.category) as "Number of Category"
From learners l
Inner join purchases p
	on l.learner_id = p.learner_id
Inner Join courses c
	on p.course_id = c.course_id
Group by l.learner_id,
		 l.full_name
Having Count(distinct c.category) > 1;

-- Q5. Identify courses never purchased.

Select c.course_id as "Course ID", 
	   c.course_name as "Course Name",
       c.category as "Category"
From courses c
Left join purchases p
	on c.course_id = p.course_id
where p.course_id is null;

-- Q6. Find learners whose total spending is above the average learner spending. 

Select l.full_name as "Learners",
	   l.country as "Country",
	   sum(p.Total_amount) as "Total Spend"
From learners l       
Left Join purchases p
	on l.learner_id = p.learner_id
Group By l.full_name,
		 l.country
Having sum(p.Total_amount) > 
	(Select avg(learner_total)
		from (Select learner_id,
					 Sum(Total_amount) as learner_total
					 from purchases 
                     Group By learner_id
			 ) as spending
	 )
Order by sum(p.Total_amount) desc;

-- Adding column 'Level' to categorize the courses

Alter table courses
Add column level varchar(20);

Update courses
set level = "Intermediate"
where course_id = "101";
       
Update courses
set level = "Beginner"
where course_id = "102";

Update courses
set level = "Intermediate"
where course_id = "103";

Update courses
set level = "Advanced"
where course_id = "104";

Update courses
set level = "Intermediate"
where course_id = "105";

Select * from Courses;

-- Q7. Display courses whose price is higher than any course in the ‘Beginner’ category. 

Select course_id as "Course ID",
	   course_name as "Course Name",
       unit_price as "Price",
       level as "Course Level"
from courses 
where unit_price > Any
(Select unit_price 
	from courses 
    where level = "Beginner"
)
Order by unit_price desc;

-- Q8. Find learners who spent more than the average spending in their country

Select l.full_name as "Learners",
	   l.country as "Country",
	   sum(p.Total_amount) as "Total Spend"
From learners l       
Inner Join purchases p
	on l.learner_id = p.learner_id
Group By l.learner_id,
		 l.full_name,
		 l.country
Having sum(p.Total_amount) > 
	(Select avg(learner_total)
		from (Select l2.learner_id,
					 l2.country,
					 Sum(p2.Total_amount) as learner_total
			  from learners l2
              Inner Join purchases p2
              on l2.learner_id = p2.learner_id
              where l2.country = l.country
			  Group By l2.learner_id,
					   l2.country
			 ) as country_spending
	 )
Order by l.country, sum(p.Total_amount) desc;

-- Q9. Use a CTE to calculate total spending per learner, then Display learners with spending above 10,000. 

With learner_spending as 
(Select l.learner_id,
		l.full_name,
        l.country,
		sum(p.Total_amount) as "Total_Spend"
from Learners l
Inner Join Purchases p
	on l.learner_id = p.learner_id
Group by l.learner_id,
		 l.full_name,
         l.country
)
Select learner_id as "Learner ID",
	   full_name as "Learner Name",
       country as "Country",
       Total_spend as "Total_spending"
from learner_spending
where Total_spend > 10000
Order by Total_spend desc;

-- Q10. CASE Expression: Classify learners based on spending

Select l.full_name as "Learners Name",
	   l.country as "Country",
	   sum(p.Total_amount) as "Total Spend",
Case 
	when sum(p.Total_amount) > 15000
		then "High Value"
	when sum(p.Total_amount) between 8000 and 15000
		then "Medium Value"
	Else "Low Value"
End as "Learner Category"
from Learners l
Inner Join Purchases p
	on l.learner_id = p.learner_id
Group by l.learner_id,
		 l.full_name,
         l.country
Order by sum(p.Total_amount) desc;

-- Q11 . NULL Handling (Display all courses and replace NULL purchase counts with 0)

Select c.course_id as "Course ID",
	   c.course_name as "Course Name",
       c.category as "Category",
       Ifnull(count(p.purchase_id),0) as "Purchase Count"
from courses c
Left Join purchases p
on c.course_id = p.course_id
Group by c.course_id,
	   c.course_name,
       c.category
Order by "Purchase Count" desc;

-- Q12 Create a view: category_performance_view 

Create view category_performance_view as 
Select c.category as "Category",
	   sum(p.Total_amount) as "Total Revenue",
       count(p.purchase_id) as "Number of Purchases",
       Round(sum(p.Total_amount)/count(p.purchase_id),2
       ) as "Average Revenue per Purchase"
from Courses c
Inner join purchases p
	on c.course_id = p.course_id
Group by c.category;
    