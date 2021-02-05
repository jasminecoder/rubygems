class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  
  def index
    @courses = Course.all.limit(3)
    @latest = Course.latest
    @latest_good_reviews = Enrollment.reviewed.latest_good_reviews
    @popular = Course.popular
    @top_rated = Course.top_rated
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc ).limit(3) 
  end

  def activity 
    @activities = PublicActivity::Activity.all.sort_by(&:created_at).reverse
  end
end
