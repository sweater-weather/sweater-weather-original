require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe 'methods' do
    it "is created with an api key" do
      user = User.create!(email: 'user@email.com', password: 'password123', password_confirmation: 'password123')
      expect(user.api_key.nil?).to eq(false)
    end
  end
end
