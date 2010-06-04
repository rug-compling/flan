# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

DATADIR='/Users/daniel/sw/Alpino/FlanTrees'

Judgment.delete_all()
Realization.delete_all()
LogicalForm.delete_all()
User.delete_all()

# Owner of all initial realizations.
user = User.create { |u|
  u.email = 'user@example.org'
  u.password = 'password'
  u.password_confirmation = 'password'
}

user.confirmed_at = Time.now
user.save

uid = user.id

Dir.glob("#{DATADIR}/ADT/*.xml").each { |xmlFile|
  adt = File.open(xmlFile, 'r').read()
  id = File.basename(xmlFile, '.xml')
  pdf = File.open("#{DATADIR}/PDF/#{id}.pdf.base64").read()
  begin
    rels = File.open("#{DATADIR}/rels/#{id}.txt").readlines
  rescue
    next
  end
  
  lf = LogicalForm.create(:key => id,
    :data => adt,
    :pdf => pdf)
 
  rels.each { |rel|
    Realization.create(:user_id => uid,
      :logical_form => lf,
      :sentence => rel.strip,
      :published => true)
  }
}
