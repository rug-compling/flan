class LogicalForm < ActiveRecord::Base
  validates :key, :data, :pdf, :presence => true
  validates :key, :uniqueness => true
  has_many :realization, :dependent => :destroy
end
