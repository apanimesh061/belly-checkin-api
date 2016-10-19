require 'spec_helper'

describe CheckIn do

  it 'can be created' do
    check_in = create :check_in
    expect(check_in).to_not be_nil
  end

  it { should belong_to :user }
  it { should belong_to :business }

  it { should have_db_index :user_id }
  it { should have_db_index :business_id }

  it { should validate_presence_of :business_id }
  it { should validate_presence_of :user_id }

end
