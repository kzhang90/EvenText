# comments need to be implemented!!!

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark
end