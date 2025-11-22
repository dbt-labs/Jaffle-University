select  
    student_name,
    course_started,
    avg(grade_points) as gpa,
    sum(credits) as total_credits,
    count(*) as total_courses,
    listagg(course_title, ', ') as courses_taken,
    listagg(instructor_name, ', ') as instructors
from
    {{ ref('int_student_data') }}
    where enroll_date >= '1/1/2025'
group by student_name,
    course_started
order by gpa desc, total_credits desc, student_name asc