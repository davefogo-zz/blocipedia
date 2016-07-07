require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) {create(:wiki)}

  describe "attributes" do
    it "has title and body attributes" do
      expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body)
    end
  end
end
