class Realization < ActiveRecord::Base
  belongs_to :logical_form
  validates_presence_of :logical_form
end
