class Realization < ActiveRecord::Base
  belongs_to :logical_form
  belongs_to :user
  validates_presence_of :logical_form
end
