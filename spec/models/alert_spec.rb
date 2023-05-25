require 'rails_helper'

RSpec.describe Alert, type: :model do
  context 'validation tests' do
    before(:each) do
      User.new(first_name: "John", last_name: "Johnson", email: "john@johnson.com", 
          address: "10 Rue Stephenson, Paris", password: "Password0!").save
    end

    it 'ensures title presence' do
      alert = Alert.new(description: "There are trash bags blocking the bike lane.",
                        category: "Pollution", address: "30 rue de Nice, 69008, Lyon, France", creator: User.first ).save
      expect(alert).to eq(false)
    end

    it 'ensures description presence and character length' do
      alert = Alert.new(title: "Trash bags blocking bike lane",
                        category: "Pollution", address: "30 rue de Nice, 69008, Lyon, France", creator: User.first ).save
      expect(alert).to eq(false)
    end

    it 'ensures category presence' do
      alert = Alert.new(title: "Trash bags blocking bike lane", description: "There are trash bags blocking the bike lane.",
                        address: "30 rue de Nice, 69008, Lyon, France", creator: User.first  ).save
      expect(alert).to eq(false)
    end

    it 'ensures address presence' do
      alert = Alert.new(title: "Trash bags blocking bike lane", description: "There are trash bags blocking the bike lane.",
                        category: "Pollution", creator: User.first ).save
      expect(alert).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(first_name: "John", last_name: "Johnson", email: "john@johnson.com", 
                      address: "10 Rue Stephenson, Paris", password: "Password0!").save
      alert = Alert.new(title: "Trash bags blocking bike lane", description: "There are trash bags blocking the bike lane.",
                        category: "Pollution", address: "30 rue de Nice, 69008, Lyon, France", creator: User.first ).save
      expect(alert).to eq(true)
    end
  end
end
