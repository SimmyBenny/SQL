use online_learning;
select * from students;
select * from enrollments;
select * from courses;
select * from course_progress;

#1. Display all students who signed up after 2024-01-01
select * from students where signup_date > '2024-01-01' order by signup_date;

#2. List all courses priced above 2000
select * from courses where price > 2000;

#3. show total number of students city-wise
select city,count(*) as No_of_students from students group by city;

#4. find the total number of enrollments per course
select course_id,count(*) as total_enrolls 
from enrollments 
group by course_id 
order by course_id;

#5. Display student names along with courses they enrolled in 
select s.full_name,e.course_id,c.course_name from students as s
inner join enrollments as e on s.student_id=e.student_id
inner join courses c on e.course_id=c.course_id
order by s.full_name;

#6. Find total revenue generated from courses
select sum(c.price) as revenue_generated from courses as c
inner join enrollments as e on c.course_id=e.course_id;

#7. show total amount spent by each student
select e.student_id,s.full_name,sum(c.price) as total_spent from students as s
inner join enrollments as e on s.student_id=e.student_id
inner join courses as c on e.course_id=c.course_id
group by e.student_id,s.full_name
order by total_spent;

#8. list students who enrolled in paid courses(price>0)
select e.student_id,s.full_name,e.course_id,c.price from students as s
inner join enrollments as e on s.student_id=e.student_id
inner join courses as c on e.course_id=c.course_id
where c.price>0;

#9. Find average course price category-wise
select category,avg(price) as avg_course_price 
from courses 
group by category;

#10. show students who enrolled in more than one course
select e.student_id,s.full_name,count(distinct e.course_id) as courses_enroll 
from enrollments as e
inner join students as s on e.student_id=s.student_id
group by e.student_id,s.full_name having courses_enroll > 1
order by courses_enroll;

#11. Display courses with zero enrollments
select c.course_id,c.course_name 
from courses c 
left join enrollments e on c.course_id=e.course_id
where e.course_id is null;

#12. find students who have never enrolled in any course
select s.student_id,s.full_name 
from students s 
left join enrollments e on s.student_id=e.student_id 
where e.student_id is null;

#13. show highest priced course
select * from courses order by price desc limit 1;

#14. count total enrollments month-wise
select year(enroll_date) as year,month(enroll_date) as month,count(*) as total_enrolls 
from enrollments 
group by year,month 
order by year;

#15. Display students with course completion above 80%
select cp.enrollment_id,s.full_name,c.course_name,cp.completed_percent
from course_progress cp
join enrollments e on cp.enrollment_id=e.enrollment_id
join students s on e.student_id=s.student_id
join courses c on e.course_id=c.course_id
where cp.completed_percent > 80;

#16. Find total number of courses per category
select category,count(distinct course_id) as total_courses 
from courses 
group by category 
order by total_courses;

#17. show students who enrolled but have 0% progress
select distinct cp.enrollment_id, e.student_id,s.full_name,cp.completed_percent from course_progress cp 
join enrollments e on cp.enrollment_id=e.enrollment_id
join students s on e.student_id=s.student_id
where cp.completed_percent=0
order by cp.enrollment_id;

#18. list top 3 students who spent the highest total amount
select e.student_id,s.full_name,sum(c.price) as total_spent from students s join enrollments e on e.student_id=s.student_id 
join courses c on e.course_id=c.course_id 
group by e.student_id,s.full_name order by total_spent desc limit 3;

#19. display course wise average completion percentage
select e.course_id,c.course_name,c.category,avg(cp.completed_percent) as avg_complet 
from course_progress cp 
join enrollments e on cp.enrollment_id=e.enrollment_id 
join courses c on e.course_id=c.course_id
group by e.course_id,c.course_name,c.category
order by avg_complet;

#20. show students who enrolled in courses costing more than 2000
select distinct e.student_id,s.full_name from students s
join enrollments e on s.student_id=e.student_id
join courses c on e.course_id=c.course_id
where c.price>2000;
