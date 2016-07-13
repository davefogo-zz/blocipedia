require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user, role: :premium)}

  it { is_expected.to have_many(:wikis)}
  it { is_expected.to have_many(:collaborators)}

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

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end


    describe "roles" do
      it "is standard user by default" do
        expect(user.role).to eq("standard")
      end

      context "standard user" do
        it "returns true for #standard?" do
          expect(user.standard?).to be_truthy
        end

        it "returns false for #premium?" do
          expect(user.premium?).to be_falsey
        end

        it "returns false for #admin?" do
          expect(user.admin?).to be_falsey
        end
      end

      context "premium user" do
        before do
          user.premium!
        end

        it "returns true for #premium?" do
          expect(user.role).to be_truthy
        end

        it "returns false for #standard?" do
          expect(user.standard?).to be_falsey
        end

        it "returns false for #admin?" do
          expect(user.admin?).to be_falsey
        end
      end

      context "admin user" do
        before do
          user.admin!
        end

        it "returns true to #admin?" do
          expect(user.admin?).to be_truthy
        end

        it "returns false for #standard?" do
          expect(user.standard?).to be_falsey
        end

        it "returns false for #premium?" do
          expect(user.premium?).to be_falsey
        end
      end
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

  describe "#downgrade" do
    it "responds to .downgrade" do
      expect(user).to respond_to(:downgrade)
    end

    it "downgrades a user from premium to standard" do
      user.downgrade
      expect(user.premium?).to be_falsey
    end
  end

  describe "@collaborator_to(wiki)" do
    before do
      @wiki = Wiki.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user, private: true)
    end

    it "returns nil if the user does not collaborate to the wiki" do
      expect(user.collaborator_to(@wiki)).to be_nil
    end

    it "returns the appropriate wiki if it exists" do
      collaborate = user.collaborators.where(wiki: @wiki).create
      expect(user.collaborator_to(@wiki)).to eq(collaborate)
    end
  end

end
