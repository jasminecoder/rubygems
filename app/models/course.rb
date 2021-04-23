class Course < ApplicationRecord
    validates :title, :short_description, :language, :level, :price, presence: true
    validates :description, length: {:minimum => 5 }
    validates :short_description, length: {:maximum => 300 }
    validates :title, uniqueness: true, length: { :maximum => 70 }
    validates :price, numericality: {greater_than_or_equal_to: 0 }
    has_rich_text :description
    belongs_to :user, counter_cache: true
    has_many :lessons, dependent: :destroy
    has_many :enrollments, dependent: :restrict_with_error
    has_many :user_lessons, through: :lessons
    has_many :course_tags, dependent: :destroy
    has_many :tags, through: :course_tags

    has_one_attached :avatar
    validates :avatar, presence: true, 
                content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                size: { less_than: 500.kilobytes , message: 'File size needs to be under 500 KB' }
    
                # validates :avatar, attached: true, 
    #                    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    #                    size: { less_than: 500.kilobytes , message: 'File size needs to be under 500 KB' }
    
    extend FriendlyId
    friendly_id :title, use: :slugged

    
    scope :latest, -> { order(created_at: :desc).limit(3) }
    scope :popular, -> { order(enrollments_count: :desc, created_at: :desc ).limit(3) }
    scope :top_rated, -> { order(average_rating: :desc, created_at: :desc ).limit(3) }
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
    scope :approved, -> { where(approved: true) }
    scope :unapproved, -> { where(approved: false) }
     

    LANGUAGES = [:"English", :"Spanish", :"French", :"Italian"]
    def self.languages 
        LANGUAGES.map { |language| [language, language] }
    end


    LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
    def self.levels 
        LEVELS.map { |level| [level, level] }
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }

    def bought_by?(user)
        user.present? && enrollments.where(user_id: user.id).exists?
    end
    
    def to_s 
        title 
    end

    def progress(user)
        unless self.lessons_count == 0
            user_lessons.where(user: user).count/self.lessons_count.to_f*100
        end
    end

    def update_rating
        if enrollments.any? && enrollments.where.not(rating: nil).any?
          update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
        else
          update_column :average_rating, (0)
        end
    end
    
end
