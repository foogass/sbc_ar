class CreateBarbers < ActiveRecord::Migration
  def change
  	create_table :barbers do |t|
  		t.text :name
  		t.timestamps  		
  	end

  	Barber.create :name => 'David Courtney'
  	Barber.create :name => 'Xaoc'
  	Barber.create :name => 'Aliaksandr Salenka'
  end
end
