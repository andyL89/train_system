class Train
  attr_reader :id, :name

  def initialize(attrs)
    @name = attrs.fetch(:name)
    @id = attrs.fetch(:id)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

end