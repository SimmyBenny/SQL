use online_learning;
select * from courses;
select * from course_progress;
select * from enrollments;
select * from students;
select * from instructors;

#1. List all students from the students table
select * from students;

#2. Display only student_id, full_name, and city of all students.
select student_id, full_name,city from students;

#3. Fetch the first 15 students based on student_id
select * from students
order by student_id asc 
limit 15;

#4. show all courses whose price is greater than 1000
select * from courses where price > 1000 order by price;

#5. Display all couses belonging to the category "AI"
select * from courses where category = "AI";

#6. List all distinct cities from where students come.
select distinct city from students;

#7. show top 10 most expensive courses(highest price first).
select * from courses order by price desc limit 10;

#8. show students whose name starts with the letter "A"
select * from students where full_name like 'A%';

#9. Fetch courses whose category contains the word "data"
select * from courses where category like "%data%";

#10. find the total numbr of students in the platform
select count(*) as Total_students from students;

#11. count total number of courses in each category
select count(course_id) as Count_courses,category from courses
group by category; 

#12. Display instructors whi joined in the year 2024
select * from instructors where year(join_date) = 2024;

#13. show all enrolments made on the date 2024-08-01
select * from enrollments where enroll_date = '2024-08-01';

#14. show students who are not from mumbai
select * from students where city not in ('mumbai');

#15. Display the 5 cheapest courses(price in ascending order)
select * from courses order by price asc limit 5;

#16. Display courses names along with the length of each course name
select course_name,length(course_name) as course_name_length 
from courses;

#17. show students who signed up after 2023-01-01
select * from students 
where signup_date >  '2023-01-01' 
order by signup_date;

#18. show all courses with price 999
select * from courses where price = 999;

#19. list the latest 20 enrollmets (based on enroll_date)
select * from enrollments order by enroll_date desc limit 20;

#20. show students emails sorted alphabetically.
select email from students order by email;