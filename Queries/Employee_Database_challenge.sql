-- creating retirement titles table
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_data BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- # of retiring employees by job title
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- creating mentorship eligibility table
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_data, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_data BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY emp_no;
	
SELECT COUNT(ut.emp_no) AS retiring_emp,
	COUNT(me.emp_no) AS mentor_emp,
	COUNT(ut.emp_no) - COUNT(me.emp_no) AS difference
FROM unique_titles AS ut
	FULL OUTER JOIN mentorship_eligibility AS me
	ON (me.emp_no = ut.emp_no)

SELECT SUM(count)
FROM retiring_titles

-- # of retiring employees by job title
SELECT COUNT (title), title
--INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC