use online_learning;
select * from courses order by price desc;
select * from enrollments;
select * from course_progress;

#1. Find students who enrolled in exactly one course
select e.student_id,s.full_name,count(e.course_id) as enrolled_courses 
from students s 
inner join enrollments e on e.student_id=s.student_id
group by e.student_id,s.full_name
having enrolled_courses=1
order by e.student_id;

#2. List courses priced below the avg course price
select * from courses where price< (select avg(price) from courses) order by price desc;

#3. Find students whose first enrollment was after 2024-06-01
select e.student_id,s.full_name,min(enroll_date) first_enroll_date from enrollments e 
inner join students s on s.student_id=e.student_id
group by e.student_id,s.full_name
having first_enroll_date>'2024-06-01';

#4. show students who completed at least one course fully
select e.student_id,s.full_name from course_progress cp
inner join enrollments e on e.enrollment_id=cp.enrollment_id
inner join students s on e.student_id=s.student_id
where cp.completed_percent = 100
group by e.student_id,s.full_name;

#5. Find the cheapest course in each category
select c.category,c.course_id,c.course_name,c.price from courses c
where c.price = (select min(price) from courses where category=c.category)
order by c.category;

#6.Display students whose highest course price is above 3000
select e.student_id,s.full_name,max(c.price) max_price from students s 
inner join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id
group by e.student_id,s.full_name
having max_price > 3000;

#7. show courses whose enrollment count is below average
select e.course_id,c.category,c.course_name,count(e.course_id) as count from enrollments e
inner join courses c on e.course_id=c.course_id
group by e.course_id,c.category,c.course_name
having count < (
	select avg(course_count) from (
		select count(*) as course_count from enrollments group by course_id)t
	)
order by e.course_id;

#8. Find students enrolled in at least 2 different categories
select e.student_id,s.full_name,count(distinct c.category) as cat_count from students s 
inner join enrollments e on e.student_id=s.student_id
inner join courses c on c.course_id=e.course_id
group by e.student_id,s.full_name
having cat_count >=2;

#9. List courses where no student has completed more than 50%
select e.course_id, c.course_name
from course_progress cp
join enrollments e on cp.enrollment_id = e.enrollment_id
join courses c on e.course_id = c.course_id
group by e.course_id, c.course_name
having max(cp.completed_percent)<=50;

#10. Find students whose total spending is blow average
select e.student_id,s.full_name,sum(c.price) as total from students s 
inner join enrollments e on s.student_id=e.student_id
inner join courses c on c.course_id=e.course_id
group by e.student_id,s.full_name
having total < (select avg(spent) from (select sum(c.price) as spent
from enrollments e join courses c on c.course_id=e.course_id
group by e.student_id)t);


#11. show students who enrolled but never completed any course
select e.student_id, s.full_name
from students s
join enrollments e on s.student_id = e.student_id
join course_progress cp on e.enrollment_id = cp.enrollment_id
group by e.student_id, s.full_name
having max(cp.completed_percent) < 100;

#12. find categories with more than 3 courses
select category,count(distinct course_id) as no_courses from courses
group by category
having no_courses >3;

#13. show students whose average completion is above overall average
select e.student_id,s.full_name,avg(cp.completed_percent) as avg_compl from course_progress cp
inner join enrollments e on e.enrollment_id=cp.enrollment_id
inner join students s on s.student_id=e.student_id
group by e.student_id,s.full_name
having avg_compl>(select avg(completed_percent) from course_progress);

#14. Find students enrolled in the least expensive courses
select distinct e.student_id,s.full_name from students s 
inner join enrollments e on s.student_id=e.student_id
inner join courses c on e.course_id=c.course_id
where c.price = (select min(price) from courses);

#15. Find courses whose price is lower than the average prce of their own category
select c.* from courses c
where c.price < (select avg(price) from courses where category= c.category);

#16. Find students who enrolled only in free courses
select e.student_id,s.full_name from students s
inner join enrollments e on s.student_id=e.student_id
inner join courses c on c.course_id=e.course_id
group by e.student_id,s.full_name
having max(c.price)=0;

#17. show courses where maximum completion <70%
select e.course_id,c.course_name from course_progress cp
inner join enrollments e on e.enrollment_id=cp.enrollment_id
inner join courses c on c.course_id=e.course_id
group by e.course_id,c.course_name
having max(completed_percent)<70;

#18. Find students who enrolled in the second most expensive course
select distinct e.student_id, s.full_name
from students s
join enrollments e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id
where c.price =(
    select max(price) from courses where price < (select max(price) from courses)
);

#19. display courses with enrollments greater than median
with course_count as(
		select course_id,count(*) as enroll_count from enrollments group by course_id
),
ordered_count as (
		select enroll_count,row_number() over(order by enroll_count) as rn,
				count(*) over() as total_rows
		from course_count
)

select cc.course_id,c.course_name,cc.enroll_count from course_count cc
join courses c on c.course_id=cc.course_id
where cc.enroll_count>(
	select avg(enroll_count) from ordered_count where rn in ((total_rows+1)/2,(total_rows+2)/2)
);

#20. Find students who completed exactly one course
select e.student_id,s.full_name from course_progress cp
join enrollments e on e.enrollment_id=cp.enrollment_id
join students s on s.student_id=e.student_id
where completed_percent=100
group by e.student_id,s.full_name
having count(e.course_id)=1;
