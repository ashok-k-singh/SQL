
-- delete departments table, if needed
DROP TABLE departments; 

-- create schema for departments table and import the corresponding data 
CREATE TABLE departments (
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

-- show 5 entries of departments table after importing the  data
SELECT * FROM departments
LIMIT 5; 


-- delete employees table, if needed
DROP TABLE employees; 

-- create schema for employees table and import the corresponding data 
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,	
	first_name VARCHAR(30) NOT NULL,	
	last_name VARCHAR(30) NOT NULL,
	gender CHAR(1) NOT NULL, 
	hire_date DATE NOT NULL 
);

-- show 5 entries of departments table after importing the  data
SELECT * FROM employees
LIMIT 5; 


-- delete dept_emp table, if needed
DROP TABLE dept_emp; 

-- create schema for dept_emp table and import the corresponding data 
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),	
	dept_no VARCHAR(10) NOT NULL,	
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

-- show 5 entries of dept_emp table after importing the  data
SELECT * FROM dept_emp
LIMIT 5; 


-- delete dept_manager table, if needed
DROP TABLE dept_manager; 

-- create schema for dept_manager table and import the corresponding data 
CREATE TABLE dept_manager (
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),	
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

-- show 5 entries of dept_manager table after importing the  data
SELECT * FROM dept_manager
LIMIT 5; 


-- delete salaries table, if needed
DROP TABLE salaries; 

-- create schema for salaries table and import the corresponding data 
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),		
	salary INT NOT NULL,
	from_date DATE NOT NULL,	
	to_date DATE NOT NULL
);

-- show 5 entries of salaries table after importing the  data
SELECT * FROM salaries
LIMIT 5; 

-- delete titles table, if needed
DROP TABLE titles; 

-- create schema for titles table and import the corresponding data 
CREATE TABLE titles (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),		
	title VARCHAR(30) NOT NULL,
	from_date DATE NOT NULL,	
	to_date DATE NOT NULL
);

-- show 5 entries of titles table after importing the  data
SELECT * FROM titles
LIMIT 5; 

-- Answer to Question-1
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;

-- Answer to Question-2
SELECT * FROM employees
WHERE EXTRACT(YEAR FROM employees.hire_date) = 1986;

-- Answer to Question-3
SELECT m.dept_no, d.dept_name, m.emp_no AS "mgr_emp_no", e.last_name, e.first_name, m.from_date AS "employment start date", m.to_date AS "employment end date"   
FROM dept_manager AS m
INNER JOIN departments AS d ON m.dept_no = d.dept_no
INNER JOIN employees AS e ON e.emp_no = m.emp_no
ORDER BY e.last_name ASC; 

-- Answer to Question-4
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name   
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
ORDER BY e.last_name ASC; 

-- Answer to Question-5
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- Answer to Question-6
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name  
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name ASC; 

-- Answer to Question-7
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name  
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name DESC; 

-- Answer to Question-8
SELECT last_name as "Employees Last Name", COUNT(last_name) AS "Frequency Count" 
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count" DESC;

