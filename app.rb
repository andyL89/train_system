require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/city')
require('./lib/operator')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'train_system'})

get('/') do
  @cities = City.all
  erb(:cities)
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

get('/cities/:id') do
  @city = City.find(params[:id].to_i)
  @trains = Train.find_by_city(params[:id].to_i)
  erb(:city)
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @cities = City.find_by_train(params[:id])
  erb(:train)
end

get('/operator/:id') do
  @cities = City.all
  @trains = Train.all
  @operator = Operator.find(params[:id].to_i)
  erb(:operator)
end

get('/operator/:id/cities') do
  @cities = City.all
  @operator = Operator.find(params[:id].to_i)
  erb(:operator_cities)
end

post('/operator/:id/cities') do
  city = City.new({name: params[:city_name], id: nil})
  city.save()
  @cities = City.all
  @operator = Operator.find(params[:id].to_i)
  erb(:operator_cities)
end

get('/operator/:id/trains') do
  @trains = Train.all
  @operator = Operator.find(params[:id].to_i)
  erb(:operator_trains)
end

post('/operator/:id/trains') do
  train = Train.new({name: params[:train_name], id: nil})
  train.save()
  @trains = Train.all
  @operator = Operator.find(params[:id].to_i)
  erb(:operator_trains)
end

get('/operator/:id/cities/:c_id') do
  @operator = Operator.find(params[:id].to_i)
  @city = City.find(params[:c_id].to_i)
  erb(:operator_city)
end

get('/operator/:id/trains/:t_id') do
  @operator = Operator.find(params[:id].to_i)
  @train = Train.find(params[:t_id].to_i)
  erb(:operator_train)
end

patch('/operator/:id/cities/:c_id') do
  @operator = Operator.find(params[:id].to_i)
  @city = City.find(params[:c_id].to_i)
  @city.update({name: params[:name]})
  @cities = City.all
  erb(:operator_cities)
end

patch('/operator/:id/trains/:t_id') do
  @operator = Operator.find(params[:id].to_i)
  @train = Train.find(params[:t_id].to_i)
  @train.update({name: params[:name]})
  @trains = Train.all
  erb(:operator_trains)
end

delete('/operator/:id/cities/:c_id') do
  @operator = Operator.find(params[:id].to_i)
  @city = City.find(params[:c_id].to_i)
  @city.delete()
  @cities = City.all
  @trains = Train.all
  erb(:operator_cities)
end

delete('/operator/:id/trains/:t_id') do
  @operator = Operator.find(params[:id].to_i)
  @train = Train.find(params[:t_id].to_i)
  @train.delete()
  @cities = City.all
  @trains = Train.all
  erb(:operator_trains)
end

get('/operator/:id/stops') do
  @operator = Operator.find(params[:id].to_i)
  @stops = Operator.find_stops()
  erb(:operator_stops)
end

post('/operator/:id/stops') do
  @operator = Operator.find(params[:id].to_i)
  Operator.stops(params[:city_name], params[:train_name], params[:time])
  @stops = Operator.find_stops()
  erb(:operator_stops)
end