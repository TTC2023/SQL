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