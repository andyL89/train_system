class City
  attr_reader :id, :name

  def initialize(attrs)
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id)
  end

  def self.all
    returned_cities = DB.exec('SELECT * FROM cities')
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  def ==(city_to_compare)
    self.name() == city_to_compare.name()
  end

  def self.clear
    DB.exec('DELETE FROM cities *;')
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    name = city.fetch("name")
    id = city.fetch("id").to_i
    City.new({:name => name, :id => id})
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    end
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def trains
    Train.find_by_city(self.id)
  end

  def self.find_by_train(train_id)
    cities = []
    returned_cities = DB.exec("SELECT * FROM stops WHERE train_id = #{train_id};")
    returned_cities.each() do |city|
      city_id = city.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id}")
      name = city.fetch("name")
      id = city.fetch("id").to_i
      cities << (City.new({:name => name, :id => id}))
    end
    cities
  end

end