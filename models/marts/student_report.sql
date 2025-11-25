select  
    student_name,
    course_started,
    avg(grade_points) as gpa,
    sum(credits) as total_credits,
    count(*) as total_courses,
    listagg(course_title, ', ') as courses_taken,
    listagg(instructor_name, ', ') as instructors
from
    (select 
        s.first_name || ' ' || s.last_name as student_name,
        i.first_name || ' ' || i.last_name as instructor_name,
        c.title as course_title,
        c.credits,
        e.grade,
        case
            when grade in ('A') then 4.0
            when grade in ('A-') then 3.7
            when grade in ('B+') then 3.3
            when grade in ('B') then 3.0
            when grade in ('B-') then 2.7
            when grade in ('C+') then 2.3
            when grade in ('C') then 2.0
            when grade in ('C-') then 1.7
            when grade in ('D') then 1.0
            when grade in ('F') then 0.0
            else 0.0
        end as grade_points,
        month(e.enroll_date)::string || '-' || year(e.enroll_date)::string as course_started
    from {{ ref('stg_jaffle_university__instructors') }} as i
    join raw.jaffle_university.departments as d on i.dept_id = d.id
    join raw.jaffle_university.enrollments as e on i.id = e.instructor_id
    join raw.jaffle_university.courses as c on e.course_id = c.id
    join raw.jaffle_university.students as s on e.student_id = s.id
    where e.enroll_date >= '1/1/2025')
group by student_name,
    course_started
order by gpa desc, total_credits desc, student_name asc
