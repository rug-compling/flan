# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

DATADIR='/Users/daniel/sw/Alpino/FlanTrees'

LogicalForm.delete_all()

Dir.glob("#{DATADIR}/ADT/*.xml").each { |xmlFile|
  adt = File.open(xmlFile, 'r').read()
  id = File.basename(xmlFile, '.xml')
  pdf = File.open("#{DATADIR}/PDF/#{id}.pdf.base64").read()
  
  lf = LogicalForm.create(:key => id,
    :data => adt,
    :pdf => pdf)
  
  1.upto(10).each { |n|
    Realization.create(:logical_form => lf,
      :sentence => "Realization #{n}")
  }
}
