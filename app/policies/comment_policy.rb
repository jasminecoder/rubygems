class CommentPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
  
  
    def destroy?
        @user.has_role?(:admin) || 
        @record.user == @user || 
        @record.lesson.course.user == @user
    end
  
  end
  