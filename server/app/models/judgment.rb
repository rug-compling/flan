class Judgment < ActiveRecord::Base
  validates :user_id, :presence => true,
    :uniqueness => {:scope => [:logical_form_id, :realization_id]}
end
