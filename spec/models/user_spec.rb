require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

  it { is_expected.to have_many(:wikis)}

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@email.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name, email and password attributes " do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) {build(:user, name: " ")}
    let(:user_with_invalid_email) {build(:user, email: " ")}

    it "is an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "is an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
end
