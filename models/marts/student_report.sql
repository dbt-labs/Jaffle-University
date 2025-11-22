select  
    student_name,
    sum(credits) as total_credits,
    count(*) as total_courses,
    listagg(course_title, ', ') as courses_taken,
    listagg(instructor_name, ', ') as instructors
from
    {{ ref('int_student_data') }}
group by student_name
order by total_credits desc, student_name asc
