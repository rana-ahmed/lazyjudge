require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid formate" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it "has user_name unique field" do
    FactoryGirl.create(:user, user_name: 'rana')
    expect(FactoryGirl.build(:user, user_name: 'rana')).not_to be_valid
  end
  describe "role parameter" do
    it "takes role as 0" do
      expect(FactoryGirl.create(:user, role: 0)).to be_valid
    end
    it "takes role as 1" do
      expect(FactoryGirl.create(:user, role: 1)).to be_valid
    end
    it "takes role as 2" do
      expect(FactoryGirl.create(:user, role: 2)).to be_valid
    end
  end
end
