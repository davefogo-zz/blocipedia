require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) {create(:wiki)}
  let(:my_user) {create(:user, role: :premium)}
  let(:user_wiki) {create(:wiki, user: my_user, private: true)}

  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:user)}

  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(20)}

  describe "attributes" do
    it "has title and body attributes" do
      expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body)
    end
  end

  describe ".make_public" do
    @my_user = User.create!(name: "User name", email: "email@tfaiwotafeiwt.com", password: "password", role: "premium")
    @user_wiki = @my_user.wikis.create(title: "this is a title to be used to test", body: "this is a body to be used to test if this class method works.", private: true)

    it "makes all wikis public for a user" do
      expect(my_user.wikis.count).to eq(1)
    end
  end
end
