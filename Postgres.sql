SELECT
	COUNT(e.id) as EmployeeCount,
	SUM(e.salary) as Salary,
	cd.department_name
FROM
	data_sci.employees e
JOIN
	data_sci.company_departments cd
ON
	e.department_id = cd.id
GROUP BY 
	cd.department_name
HAVING
	SUM(e.salary) > 5000000
ORDER BY 
	Salary desc
	