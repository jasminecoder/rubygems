module EnrollmentsHelper
    def enrollment_button(course)
        if current_user
            if course.user == current_user 
                link_to 'You created this course. Go to Analytics', course_path(course)
            elsif course.enrollments.where(user: current_user).any?
                link_to 'You already have this course', course_path(course)
            elsif course.price > 0
                link_to 'Buy', new_course_enrollment_path(course), class: 'btn btn-sm btn-success'
            else 
                link_to 'Free', new_course_enrollment_path(course), class: 'btn btn-sm btn-success'
            end
        else  
            link_to 'check price', course_path(course), class:'btn btn-sm btn-success'
        end
    end
end
