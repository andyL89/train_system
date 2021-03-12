class Operator
  attr_reader :id, :name

  def initialize (attrs)
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id).to_i
  end

  def self.find(id)
    operator = DB.exec("SELECT * FROM train_operators WHERE id = #{id};").first
    name = operator.fetch("name")
    id = operator.fetch("id").to_i
    Operator.new({:name => name, :id => id})
  end

  def self.stops(city_name, train_name, time)
    city_result = DB.exec("SELECT * FROM cities WHERE name = '#{city_name}';")
    if city_result.first() == nil
      city = City.new({name: city_name, id: nil})
      city.save()
      city_result = city
      city_id = city_result.id
    else
      city_id = city_result.first().fetch("id").to_i
    end

    train_result = DB.exec("SELECT * FROM trains WHERE name = '#{train_name}';")
    if train_result.first() == nil
      train = Train.new({name: train_name, id: nil})
      train.save()
      train_result = train
      train_id = train_result.id
    else
      train_id = train_result.first().fetch("id").to_i
    end
    DB.exec("INSERT INTO stops (city_id, train_id, time) VALUES (#{city_id}, #{train_id}, '#{time}');")
    [city_id, train_id, time]
  end

  def self.find_stops
    stops_array = []
    stops = DB.exec("SELECT * FROM stops;")
    stops.each do |stop|
      train_id = stop.fetch("train_id").to_i
      city_id = stop.fetch("city_id").to_i
      time = stop.fetch("time")
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};").first()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};").first()
      train_name = train.fetch("name")
      city_name = city.fetch("name")
      stops_array.push([city_name, train_name, time])
    end
    stops_array
  end
end

