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
    city_result = {}
    train_result = {}


    city_result = DB.exec("SELECT * FROM cities WHERE name = '#{city_name}';")
    if city_result == {}
      city = City.new({name: city_name, id: nil})
      city.save()
      city_result = city
    end
    city_id = city_result.values[0]
    city_id = city_id[0].to_i


    train_result = DB.exec("SELECT * FROM trains WHERE name = '#{train_name}';")
    if train_result == {}
      train = Train.new({name: train_name, id: nil})
      train.save()
      train_result = train
    end
    train_id = train_result.values[0]
    train_id = train_id[0].to_i


    DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city_id}, #{train_id});")
    [city_id, train_id, time]
  end
end

