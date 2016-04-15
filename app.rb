#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
#	db = get_db
#	@barget = db.execute 'SELECT * FROM barbers'
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:date_time]
	@barber = params[:barber]

	c = Client.new
	c.name = @username
	c.phone = @phone
	c.datestamp = @date_time
	c.barber = @barber
	c.save

	# хеш ошибок
	hh = { :username => 'Введите имя', :phone => 'Введите телефон', :date_time => 'Введите дату и время'}

	@error = hh.select {|key,_| params[key] == ''}.values.join(",")
	if @error != '' 
		return erb :visit
	end

	#db = get_db
	#db.execute 'INSERT INTO users (username, phone, datestamp, barber) VALUES ( ?, ?, ?, ?)', [@username, @phone, @date_time, @barber]

	#db.execute "INSERT INTO users (name, phone, datestamp, barber) VALUES (#{@username}, #{@phone}, #{@date_time}, #{@barber});"
	#db.close

# ИЛИ

#	# для каждой пары ключ-значение
#	hh.each do |key, value|
#
#		# если параметр пуст
#		if params[key] == ''
#
#			# переменной error присвоить значение value из хэша ошибок
#			@error = hh[key]
#
#			return erb ;
#		end
#	end

#	f = File.open("/users.txt", "a")
#	f.write("Name: #{@username.capitalize}, phone: #{@phone}, Date & Time: #{@date_time}, barber: #{@barber}")
#	f.close

	#@title = "Спасибо!"
	#@message = "Мы будем ждать вас в #{@date_time}"

	#erb :message
end