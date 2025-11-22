select 
        s.first_name || ' ' || s.last_name as student_name,
        i.first_name || ' ' || i.last_name as instructor_name,
        c.title as course_title,
        c.credits,
        e.grade,
    from {{ ref('stg_jaffle_university__instructors') }} as i
    join {{ ref('stg_jaffle_university__departments') }} as d on i.dept_id = d.id
    join {{ ref('stg_jaffle_university__enrollments') }} as e on i.id = e.instructor_id
    join {{ ref('stg_jaffle_university__courses') }} as c on e.course_id = c.id
    join {{ ref('stg_jaffle_university__students') }} as s on e.student_id = s.id
