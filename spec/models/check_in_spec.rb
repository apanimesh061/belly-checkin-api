require 'spec_helper'

describe CheckIn do

  it 'can be created' do
    check_in = create :check_in
    expect(check_in).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for CheckIn!')
  end

end
