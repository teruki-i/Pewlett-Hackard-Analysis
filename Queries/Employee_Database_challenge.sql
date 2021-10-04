-- DELIVERABLE #1
-- create table of retiring employees with title and dates
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM titles AS t
INNER JOIN employees AS e
ON (e.emp_no = t.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Get count of retiring employees by their most recent title
SELECT COUNT(title) as "count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "count" DESC;


-------------------------------------------------------------------------------------------
-- DELIVERABLE #2

-- Create table showing employees eligible for mentorship program
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM titles as t
INNER JOIN employees AS e
ON (e.emp_no = t.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-------------------------------------------------------------------------------------------
-- DELIVERABLE #3

-- Create table of all current employees
SELECT de.emp_no,
	e.first_name,
	e.last_name,
	de.to_date
INTO all_current
FROM dept_emp AS de
INNER JOIN employees AS e
ON (de.emp_no = e.emp_no)
WHERE de.to_date = '9999-01-01'
ORDER BY de.emp_no;

-- Count of total current employees
SELECT COUNT(emp_no) 
FROM all_current

-- Count retirement-eligible employees
SELECT COUNT(emp_no)
FROM unique_titles;

-- Count mentorship-eligible employees
SELECT COUNT(emp_no)
FROM mentorship_eligibility;

-- Count mentorship-eligible employees by title
SELECT COUNT(title) AS "count", title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY "count" DESC;

SELECT * FROM mentorship_titles;
