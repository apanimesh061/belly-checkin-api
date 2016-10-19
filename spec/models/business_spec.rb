require 'spec_helper'

describe Business do

  it 'can be created' do
    business = create :business
    expect(business).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for Business!')
  end

end
