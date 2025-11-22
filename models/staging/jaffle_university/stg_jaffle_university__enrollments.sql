with 

source as (

    select * from {{ source('jaffle_university', 'enrollments') }}

),

renamed as (

    select
        id,
        student_id,
        course_id,
        instructor_id,
        semester_id,
        enroll_date,
        grade,
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
         month(enroll_date)::string || '-' || year(enroll_date)::string as course_started,
        credits

    from source

)

select * from renamed