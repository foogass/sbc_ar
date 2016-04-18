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

# => # СОХРАНЕНИЕ В БАЗУ true-vay

	c = Client.new params[:client]
	c.save

# => # СОХРАНЕНИЕ В БАЗУ lame-vay

#	@username = params[:username]
#	@phone = params[:phone]
#	@date_time = params[:date_time]
#	@barber = params[:barber]
#
#
#	# Сохраняем значения в таблицу clients
#	c = Client.new
#	c.name = @username
#	c.phone = @phone
#	c.datestamp = @date_time
#	c.barber = @barber
#	c.save

	# хеш ошибок
	hh = { :username => 'Введите имя', :phone => 'Введите телефон', :date_time => 'Введите дату и время'}

	@error = hh.select {|key,_| params[key] == ''}.values.join(",")
	if @error != '' 
		return erb :visit
	end

end