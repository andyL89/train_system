require 'rspec'
require 'train'
require 'spec_helper'

describe '#Train' do

  describe('.all') do
    it('returns an empty array when there are no trains') do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a train') do
      train1 = Train.new({:name => 'Chugga Chugga', :id => nil})
      train1.save()
      train2 = Train.new({:name => 'Choo Choo', :id => nil})
      train2.save()
      expect(Train.all).to(eq([train1, train2]))
    end
  end

  describe('#==') do
    it('is the same train if it has the same attributs as another train') do
      train1 = Train.new({:name => 'Chugga Chugga', :id => nil})
      train2 = Train.new({:name => 'Chugga Chugga', :id => nil})
      expect(train1).to(eq(train2))
    end
  end

  describe('.clear') do
    it('clears all album') do
      train1 = Train.new({:name => 'Chugga Chugga', :id => nil})
      train1.save()
      train2 = Train.new({:name => 'Choo Choo', :id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('.find') do
    it('finds a train by id') do
      train1 = Train.new({:name => 'Chugga Chugga', :id => nil})
      train1.save()
      train2 = Train.new({:name => 'Choo Choo', :id => nil})
      train2.save()
      expect(Train.find(train1.id)).to(eq(train1))
    end
  end

  describe('#update') do
    it('updates an album by id') do
      train = Train.new({:name => 'Chugga Chugga', :id => nil})
      train.save()
      train.update({:name => 'Thomas'})
      expect(train.name).to(eq('Thomas'))
    end
  end

  describe('#delete') do
    it('it deletes a train from the database') do
      train1 = Train.new({:name => 'Chugga Chugga', :id => nil})
      train1.save()
      train2 = Train.new({:name => 'Choo Choo', :id => nil})
      train2.save()
      train1.delete()
      expect(Train.all).to(eq([train2]))
    end
  end


end