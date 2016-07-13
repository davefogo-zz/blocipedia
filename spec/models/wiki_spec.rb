require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) {create(:wiki)}
  let(:my_user) {create(:user, role: :premium)}
  let(:user_wiki) {create(:wiki, user: my_user, private: true)}

  it {is_expected.to have_many(:collaborators)}

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

  describe "scopes" do
    before do
      @public_wiki = Wiki.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: my_user)
      @private_wiki = Wiki.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user_wiki, private: true)
      create_session(user_wiki)
    end

    describe "visible_to(user)" do
      it "returns all wikis to premium and admin users" do

        expect(Wiki.visible_to(wiki_user)).to eq(Wiki.all)
      end

      it "returns only public wikis to guest and standard users" do
        expect(Wiki.visible_to(nil)).to eq([@public_wiki])
      end
    end
  end
end
