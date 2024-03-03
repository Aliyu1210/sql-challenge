CREATE TABLE titles (
    title_id varchar   NOT NULL,
    title varchar   NOT NULL,
    PRIMARY KEY (title_id)
);
Drop table employees
CREATE TABLE employees (
    emp_no int   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar  NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
    FOREIGN KEY(emp_title_id) REFERENCES titles (title_id),
	
    PRIMARY KEY (emp_no)
);
CREATE TABLE departments (
    dept_no VARCHAR(4)  NOT NULL,
    dept_name VARCHAR(20)   NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);
CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar(4)  NOT NULL,
	FOREIGN KEY (emp_no)references employees(emp_no),
	FOREIGN KEY (dept_no)references departments(dept_no),
	PRIMARY KEY (emp_no,dept_no)
      
     
);
CREATE TABLE dept_manager (
        dept_no VARCHAR NOT NULL,
        emp_no int  NOT NULL,
	    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
        FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	    PRIMARY KEY (dept_no,emp_no)
    );



CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
     PRIMARY KEY (emp_no)     
);
Select * from titles
select * from departments
select * from dept_emp
select * from dept_manager
select * from employees
select * from salaries

__ Analysis part
__List the employee number, last name, first name, sex, and salary of each employee.

Select employees.emp_no,employees.last_name,employees.first_name,employees.sex,salaries.salary
from employees
join salaries
on employees.emp_no = salaries.emp_no

__List the first name, last name, and hire date for the employees who were hired in 1986
select first_name,last_name,hire_date
from employees
where hire_date between '1/1/1986' and '12/31/1986'
order by hire_date;

__List the manager of each department along with their department number, department name, employee number, last name, and first name
select departments.dept_no,departments.dept_name,dept_manager.emp_no,employees.last_name,employees.first_name
from departments
join dept_manager
on departments.dept_no = dept_manager.dept_no
join employees
on dept_manager.emp_no = employees.emp_no

__List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select employees.first_name,employees.last_name,employees.sex
from employees
where first_name = 'Hercules'
and last_name like 'B%'

__List each employee in the Sales department, including their employee number, last name, and first name.
select departments.dept_name, employees.last_name,employees.first_name
from dept_emp
join employees
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'
__List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name,employees.first_name, departments.dept_name
from employees
join dept_emp 
on dept_emp.emp_no = employees.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where departments.dept_name = 'Sales'
or departments.dept_name = 'Development'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select count(last_name) as frequency, last_name
from employees
group by last_name
order by count(last_name) desc;

