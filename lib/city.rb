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

end