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
end