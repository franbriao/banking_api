require 'rails_helper'
require 'validates_email_format_of/rspec_matcher'

RSpec.describe Account, type: :model do
  it { is_expected.to have_many(:account_transactions) }
  it { is_expected.to validate_presence_of(:email) }
  it { should validate_email_format_of(:email).with_message('not valid') }

  it 'has a valid factory' do
    expect(build(:account)).to be_valid
  end

  context 'on account creation' do
    it 'creates an account successfully' do
      account = create(:account, email: 'testing@testing.com')
      expect(account).to be_valid
      expect(account.api_key).not_to be_nil
    end

    it 'is not valid without an email' do
      account = build(:account, email: nil)
      expect(account).not_to be_valid
    end
  end
end
