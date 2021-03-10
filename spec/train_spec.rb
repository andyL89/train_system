require 'rspec'
require 'train'
require 'spec_helper'

describe '#Train' do

  describe('.all') do
    it('returns an empty array when there are no trains') do
      expect(Train.all).to(eq([]))
    end
  end


end