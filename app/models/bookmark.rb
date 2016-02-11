class Bookmark < ActiveRecord::Base
  belongs_to :user
  # add server side validations here?
end
