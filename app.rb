#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

	# НОВАЯ ВАЛИДАЦИЯ!
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true

end

class Barber < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
	@c = Client.new params[:client]
	@barbers = Barber.all
#	db = get_db
#	@barget = db.execute 'SELECT * FROM barbers'
	erb :visit
end

post '/visit' do

# => # СОХРАНЕНИЕ В БАЗУ true-vay

	@c = Client.new params[:client]
	@barbers = Barber.all

	if @c.save
		erb "<h2>Спасибо, вы записались!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

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

	# СТАРАЯ ВАЛИДАЦИЯ

#	# хеш ошибок
#	hh = { :username => 'Введите имя', :phone => 'Введите телефон', :date_time => 'Введите дату и время'}
#
#	@error = hh.select {|key,_| params[key] == ''}.values.join(",")
#	if @error != '' 
#		return erb :visit
#	end

end

get "/barber/:id" do 
	@barber = Barber.find(params[:id])
	erb :barber
end

get "/bookings" do
	@clients = Client.order "created_at DESC"
	erb :bookings
end

get "/client/:id" do 
	@client = Client.find params[:id]
	erb :client
end