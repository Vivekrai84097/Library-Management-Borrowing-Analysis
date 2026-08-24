-- =====================================================
-- LIBRARY MANAGEMENT & BORROWING ANALYSIS
-- =====================================================

-- Database: Library Management System
-- Tool: MySQL
-- Analysis: Member, Book, Borrowing & Revenue Analysis


-- =====================================================
-- 1. DATA VALIDATION
-- =====================================================

-- duplicate members
select member_id,
	count(*) as count
from members
group by member_id
having count > 1;

-- duplicate books
select book_id,
	count(*) as count
from books 
group by book_id
having count > 1;

-- null values check
select 
	count(*) as total_rows,
    
    sum(case
		when member_id is null then 1
        else 0
	end) as member_id_nulls,
    
    sum(case
		when member_name is null then 1
        else 0
	end) as member_name_nulls,
    
    sum(case
		when city is null then 1
        else 0
	end) as city_nulls,
    
    sum(case
		when join_date is null then 1
        else 0
	end) as join_date_nulls
    
from members;

-- invalid foreign keys
select distinct br.member_id
from borrow br
where not exists (
	select 1
    from members m
    where m.member_id = br.member_id
);

-- invalid book IDs
select distinct br.book_id
from borrow br
left join books b
	on br.book_id = b.book_id
where b.book_id is null;

-- =====================================================
-- 2. KPI ANALYSIS
-- =====================================================

-- total_members
select count(*) as total_members
from members;

-- total_books
select count(*) as total_books
from books;

-- total borrow transactions
select count(*) as total_borrow
from borrow;

-- total revenue
select 
	sum(br.quantity * b.price) as total_revenue
from borrow br
join books b
	on br.book_id = b.book_id;
    
-- average spending per transaction
select 
	sum(br.quantity * b.price) / count(br.borrow_id) as avg_spending_per_transaction
from borrow br
join books b 
	on br.book_id = b.book_id;

-- =====================================================
-- 3. CUSTOMER ANALYSIS
-- =====================================================

-- Borrowing transactions by each member
select m.member_name,
	count(br.borrow_id) as borrow_count
from members m 
join borrow br
	on m.member_id = br.member_id
group by m.member_id, m.member_name
order by borrow_count desc;

-- total books borrowed by members
select m.member_name,
	sum(br.quantity) as total_books
from members m 
join borrow br
	on m.member_id = br.member_id
group by m.member_id, m.member_name
order by total_books desc;

-- total spending of each member
select m.member_name,
	sum(br.quantity * b.price) as total_spent
from members m 
join borrow br
	on m.member_id = br.member_id
join books b
	on br.book_id = b.book_id
group by m.member_id, m.member_name
order by total_spent desc;

-- members above average spending
select m.member_name,
	sum(br.quantity * b.price) as total_spent
from members m 
join borrow br
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
group by m.member_id, m.member_name
having total_spent > (
	select avg(member_spent)
    from (
		select br2.member_id,
			sum(br2.quantity * b2.price) as member_spent
		from borrow br2
        join books b2
			on br2.book_id = b2.book_id
		group by br2.member_id
	) spending
);

-- top 3 members by spending
with top_member_spending as (
select m.member_name,
	sum(br.quantity * b.price) as total_spent
from members m 
join borrow br
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
group by m.member_id, m.member_name
)
select member_name,
	total_spent,
    rank() over(order by total_spent desc) as spending_rank
from top_member_spending
order by total_spent desc limit 3;

-- =====================================================
-- 4. BOOK & CATEGORY ANALYSIS
-- =====================================================

-- books in each category
select category,
	count(book_id) as book_count
from books 
group by category
order by book_count desc;

-- average book price by category
select category,
	round(avg(price), 2) as avg_price
from books
group by category
order by avg_price desc;

-- total books borrowed from each category
select b.category,
	sum(br.quantity) as total_quantity
from books b
join borrow br
	on b.book_id = br.book_id
group by b.category
order by total_quantity desc;

-- most borrowed book
select b.book_name,
	sum(br.quantity) as total_borrowed
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.book_id, b.book_name
order by total_borrowed desc limit 1;

-- books that have never borrowed with price
select b.book_name,
	b.category,
    b.price
from books b 
left join borrow br
	on b.book_id = br.book_id
where br.book_id is null;

-- =====================================================
-- 5. REVENUE ANALYSIS
-- =====================================================

-- category-wise revenue
with category_wise_revenue as (
select b.category,
	sum(br.quantity * b.price) as total_revenue
from books b
join borrow br
	on b.book_id = br.book_id
group by b.category
)
select * from category_wise_revenue;

-- highest revenue-generating category
select b.category,
	sum(br.quantity * b.price) as total_revenue
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.category
order by total_revenue desc limit 1;

-- city-wise revenue
select m.city,
	sum(br.quantity * b.price) as total_revenue
from members m 
join borrow br 
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
group by m.city
order by total_revenue desc;

-- top 3 books by revenue
select b.book_name,
	b.category,
    sum(br.quantity * b.price) as total_revenue
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.book_id, b.book_name
order by total_revenue desc limit 3;

-- revenue contribution by category
with category_revenue as (
    select
        b.category,
        sum(br.quantity * b.price) as total_revenue
    from books b
    join borrow br
        on b.book_id = br.book_id
    group by b.category
)
select
    category,
    total_revenue,
    round(
        total_revenue * 100.0 /
        sum(total_revenue) over (),
        2
    ) as revenue_percentage
from category_revenue
order by total_revenue desc;

-- =====================================================
-- 6. ADVANCED SQL ANALYSIS
-- =====================================================

-- top 2 expensive books from each category
with expensive_books as (
select book_name,
	category,
    price,
    row_number() over(partition by category order by price desc) as category_wise_rank
from books 
)
select book_name,
	category,
    price,
    category_wise_rank
from expensive_books
where category_wise_rank <= 2;

-- previous borrowing analysis
select m.member_name,
	br.borrow_date,
	lag(borrow_date) over(partition by m.member_id order by borrow_date) as prev_borrow_date,
    datediff(br.borrow_date, lag(borrow_date) over(partition by m.member_id order by borrow_date)) as days_gap
from members m
join borrow br
	on m.member_id = br.member_id;
    
-- latest borrow spending vs average spending
with borrow_spending as (
select m.member_id,
	m.member_name,
	br.borrow_date,
    br.borrow_id,
    br.quantity * b.price as spending
from members m 
join borrow br
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
),

member_analysis as (
select member_id,
	member_name,
    spending,
    avg(spending) over(partition by member_id) as average_spending,
    row_number() over(partition by member_id order by borrow_date desc, borrow_id desc) as rn
from borrow_spending
)

select member_name,
	spending as latest_spending,
    average_spending
from member_analysis
where rn = 1
and spending > average_spending;

-- running revenue of each category
select b.category,
	br.borrow_date,
    br.quantity * b.price as revenue,
    sum(br.quantity * price) over(partition by b.category order by borrow_date) as running_revenue
from books b 
join borrow br
	on b.book_id = br.book_id;
    
-- Transaction revenue contribution within each category
select
    b.category,
    br.borrow_date,
    br.quantity * b.price as revenue,

    sum(br.quantity * b.price) over(
        partition by b.category
    ) as category_total_revenue,

    round(
        (br.quantity * b.price) * 100.0
        / sum(br.quantity * b.price) over(
            partition by b.category
        ),
        2
    ) as revenue_percentage

from books b
join borrow br
    on b.book_id = br.book_id

order by b.category, br.borrow_date;

-- =====================================================
-- 7. BUSINESS INSIGHTS
-- =====================================================

-- most borrowed book
select b.book_name,
	sum(br.quantity) as total_borrowed
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.book_id, b.book_name
order by total_borrowed desc limit 1;

-- highest revenue-generating category
select b.category,
	sum(br.quantity * b.price) as total_revenue
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.category
order by total_revenue desc limit 1;

-- highest spending member
select m.member_name,
	sum(br.quantity * b.price) as total_spent
from members m 
join borrow br 
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
group by m.member_id, m.member_name
order by total_spent desc limit 1;

-- city-wise revenue
select m.city,
	sum(br.quantity * b.price) as total_revenue
from members m 
join borrow br 
	on m.member_id = br.member_id
join books b 
	on br.book_id = b.book_id
group by m.city
order by total_revenue desc;

-- top 3 books by revenue
select b.book_name,
	b.category,
    sum(br.quantity * b.price) as total_revenue
from books b 
join borrow br
	on b.book_id = br.book_id
group by b.book_id, b.book_name
order by total_revenue desc limit 3;