require 'spec_helper'

describe '#Operator' do

  describe '.stops' do
    it('takes in 3 params and adds a row to our stops table') do
      city = City.new({name: 'Portland', id: nil})
      city.save()
      train = Train.new({name: 'Big CHOO CHOO', id: nil})
      train.save()
      time = '05:45'
      result = Operator.stops(city.name, train.name, time)
      expect(result).to(eq([city.id, train.id, '05:45']))
    end
  end
end