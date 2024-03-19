SELECT PERSON.firstName, PERSON.lastName, ADDRESS.city, ADDRESS.state FROM ADDRESS
RIGHT JOIN PERSON ON ADDRESS.personId = PERSON.personId;

SELECT tweet_id
FROM Tweets
WHERE length(content) > 15;

SELECT employee.name, bonus.bonus
From Employee
Left Join Bonus On Employee.empId = Bonus.empId
Where bonus.bonus < 1000 or bonus.bonus is Null

SELECT
    contest_id,
    ROUND(
        (COUNT(DISTINCT user_id) / (SELECT COUNT(user_id) FROM users)) * 100,
        2
    ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC;

SELECT sell_date, COUNT(distinct product) as num_sold, GROUP_CONCAT(distinct product ORDER BY product ASC SEPARATOR ',') as products
FROM 
Activities
GROUP BY sell_date

Select stock_name, Sum(
    Case
    when operation = 'Buy' then -price
    when operation = 'Sell' then price
    End
) as capital_gain_loss
From Stocks
Group By stock_name

SELECT product.product_name, sales.year, sales.price FROM Sales
Inner Join Product on product.product_id = sales.product_id
Order BY sales.year DESC

Select user_id, max(time_stamp) as last_stamp
From Logins
Where time_stamp between '2020-01-01 00:00:00' and '2020-12-31 23:59:59'
Group By user_id

SELECT s.machine_id, ROUND(AVG(e.timestamp - s.timestamp),3) as processing_time
FROM Activity s
INNER JOIN activity e ON s.machine_id = e.machine_id
AND s.process_id = e.process_id 
WHERE s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id

SELECT date_id, make_name, count(distinct lead_id) as unique_leads, count(distinct partner_id) as unique_partners 
From DailySales
GROUP BY date_id, make_name
ORDER BY date_id ASC, make_name;

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) desc
LIMIT 1

SELECT 
  user_id, CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name FROM 2))) AS name
FROM 
  Users;

SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = "Y"
UNION
SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(employee_id) = 1

SELECT *, 
CASE
    WHEN x + y > z and x + z > y and y + z > x THEN 'Yes'
    ELSE 'No'
END as triangle
FROM triangle

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >=3

SELECT employee_id, 
CASE
    WHEN employee_id % 2 <> 0 and name not like 'M%' THEN salary
    ELSE 0
    END as bonus
FROM Employees
ORDER BY Employee_id

SELECT p.product_id, 
    CASE
        WHEN SUM(u.units) > 0 THEN ROUND(SUM(p.price * u.units) / SUM(u.units), 2)
        ELSE 0
    END AS average_price
FROM Prices p
LEFT JOIN
    UnitsSold u ON u.product_id = p.product_id
            AND u.purchase_date >= p.start_date
            AND u.purchase_date <= p.end_date
GROUP BY p.product_id

SELECT name 
FROM (
    SELECT name, COUNT(managerId) AS emp
    FROM Employee 
    GROUP BY name
    HAVING COUNT(managerId) >= 5
) AS employees

SELECT customer_id, COUNT(customer_id) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT v.visit_id
    FROM Visits v
    JOIN Transactions t ON v.visit_id = t.visit_id
    GROUP BY v.visit_id)
GROUP BY customer_id

-- I learned that the WHERE clause acts before the SELECT clause, therefore I had to use a subquery to make sure that the Id column would be recognized in the WHERE clause. So when using a CASE statement you must use a subquery to filter because it will not be recognized.

SELECT *
FROM (
    SELECT CASE
            WHEN LAG(temperature, 1) OVER (ORDER BY recordDate) < temperature THEN id
            ELSE 0
        END AS Id
    FROM Weather
) AS WeatherWithId
WHERE Id > 0;

-- I learned that when using a SELECT * statement with JOIN you have to explicitly name each column or it will throw an error. Also when checking for null do not us the = sign. The proper way to check is with IS NULL

SELECT name, bonus
FROM (
    SELECT e.name, b.bonus
    FROM Employee e
    LEFT JOIN Bonus b ON e.empId = b.empId
) AS bonus_table
WHERE bonus < 1000 OR bonus IS NULL

-- I learned that putting an else statement at the end of a case statement helps fill the table

SELECT s.user_id, ROUND(AVG(CASE
        WHEN c.action = 'timeout' THEN 0
        WHEN c.action = 'confirmed' THEN 1
        ELSE 0
    END),2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY user_id

-- I learned to read the problem more thoroughly

WITH odd_id AS (
    SELECT * 
    FROM Cinema
    WHERE id%2 != 0
)
SELECT * 
FROM odd_id
WHERE description != 'boring'
ORDER BY rating DESC

-- Always make sure you column names are correct

SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY project_id

-- I learned that you could do a desc and asc in the order by clause

SELECT r.contest_id, ROUND(COUNT(r.contest_id)/(
    SELECT COUNT(*)
    FROM Users
) * 100,2) AS percentage
FROM Users u
JOIN Register r ON u.user_id = r.user_id
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

-- I learned two lesson in this challenge. First that you need to use the SUM function with Case studies when grouping columns together. Second, that you need to use the DATE_FORMAT with group by or when changing the format of a date to get the month or day.

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(trans_date) AS trans_count, SUM(CASE
    WHEN state = 'approved' THEN 1
    ELSE 0
    END) AS approved_count, SUM(amount) AS trans_total_amount, SUM(CASE
    WHEN state = 'approved' THEN amount
    ELSE 0
    END) AS approved_total_amount
FROM Transactions
GROUP BY month, country

-- Do not forget distinct when searching for unique values

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- I learned that it is sometimes useful to take away what is not needed instead of keeping what is needed.

SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date IN (
    SELECT activity_date
    FROM Activity
    WHERE activity_type = 'scroll_down' OR activity_type = 'send_message'
)
GROUP BY day

WITH five_plus AS (
    SELECT COUNT(class) AS num_class, class
    FROM Courses
    GROUP BY class
)
SELECT class
FROM five_plus
WHERE num_class >= 5;

-- Remember to read the question and do not forget to order the values if asked in the question

SELECT user_id, COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC

-- Do not use aggregate functions in the WHERE clause. Also, keep the column names in order

WITH single_cnt AS (
    SELECT COUNT(num) AS cnt_num, num
    FROM MyNumbers
    GROUP BY num
    HAVING cnt_num = 1
)
SELECT MAX(num) AS num
FROM single_cnt;

-- I learned that to match columns it is best to do a NOT IN clause and subquery the column you want to match with

SELECT employee_id
FROM Employees
WHERE salary < 30000 AND manager_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id

-- I learned that directly adding + 1 in a THEN statement works. Doing id = id + 1 does not work because it is treated as a boolean statement.

SELECT CASE
    WHEN id = (SELECT MAX(id) FROM seat) AND id % 2 = 1 THEN id 
    WHEN id % 2 = 1 THEN id + 1
    ELSE id - 1
    END AS id, student
FROM Seat
ORDER BY id ASC

-- I learned that using Union is key when you need to combined two totally different values

SELECT name AS results
FROM (
    SELECT u.name
    FROM MovieRating mr
    JOIN users u ON mr.user_id = u.user_id
    GROUP BY name
    ORDER BY COUNT(name) DESC, name ASC
    LIMIT 1
) as most_name
UNION ALL
SELECT title AS results
FROM (
    SELECT m.title
    FROM MovieRating mr
    JOIN Movies m ON mr.movie_id = m.movie_id
    WHERE created_at BETWEEN '2020-01-31' AND '2020-03-01'
    GROUP BY title
    ORDER BY AVG(rating) DESC, title ASC
    LIMIT 1
) AS most_movie;

-- Use union all when trying to count the total items in two different columns. Also do not forget to GROUP BY when trying to count certain items

WITH cte AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL 
    SELECT accepter_id AS id
    FROM RequestAccepted
)
SELECT id, COUNT(*) AS num
FROM cte
GROUP BY id
ORDER BY num DESC
LIMIT 1