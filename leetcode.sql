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