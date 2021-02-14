module CoursesHelper
    def enrollment_button(course)
        if current_user
            if course.user == current_user 
                link_to 'You created this course. Go to Analytics', course_path(course)
            elsif course.enrollments.where(user: current_user).any?

                link_to course_path(course) do
                    #"You bought this course. Keep learning" +
                    "<i class='fa fa-spinner'></i>".html_safe + " " +
                    number_to_percentage(course.progress(current_user), precision: 0)
                  end

            elsif course.price > 0
                link_to 'Buy', new_course_enrollment_path(course), class: 'btn btn-sm btn-success'
            else 
                link_to 'Free', new_course_enrollment_path(course), class: 'btn btn-sm btn-success'
            end
        else  
            link_to 'check price', new_course_enrollment_path(course), class:'btn btn-sm btn-success'
        end
    end

    def review_button(course)
        user_course = course.enrollments.where(user: current_user)
        if current_user
            if user_course.any?
                if user_course.pending_review.any?
                    link_to 'Add a review', edit_enrollment_path(user_course.first), class: 'btn btn-sm btn-info'
                else
                    'You have left a review. Thanks!'
                    link_to 'Thanks for your Review', enrollment_path(user_course.first)
                end
            end
        end
    end

    def review_count(course)
        course.enrollments.where(rating: [1..5]).size
    end
end
