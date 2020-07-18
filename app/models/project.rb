class Project < ActiveRecord::Base 
    belongs_to :student 
    validates :title, presence: true 
    validates :description, presence: true 
    validates :platform, presence: true 
    validates :programming_language, presence: true 
    validates :start_date, presence: true 
    validates :end_date, presence: true 
end




