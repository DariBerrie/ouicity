require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures first name presence' do
      user = User.new(last_name: "Johnson", email: "john@johnson.com").save
      expect(user).to eq(false)
    end

    it 'ensures last name presence' do
      user = User.new(first_name: "John", email: "john@johnson.com").save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(first_name: "John", last_name: "Johnson").save
      expect(user).to eq(false)
    end

    it 'ensures address presence' do
      user = User.new(first_name: "John", last_name: "Johnson").save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(first_name: "John", last_name: "Johnson", email: "john@johnson.com", 
                      address: "10 Rue Stephenson, Paris", password: "Password0!").save
      expect(user).to eq(true)
    end

  end

  context 'scope tests' do 

    it 'should return users with resident role' do
      User.new(first_name: "John", last_name: "Johnson", email: "john@johnson.com", 
               address: "10 Rue Stephenson, Paris", password: "Password0!").save
      expect(User.resident_users.size).to eq(1)
    end

    it 'should return users with worker role' do
      user = User.new(first_name: "John", last_name: "Johnson", email: "john@johnson.com", 
               address: "10 Rue Stephenson, Paris", password: "Password0!", role: 1).save   
      expect(User.worker_users.size).to eq(1)
    end
  end
end
