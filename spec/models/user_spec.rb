require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe "Validations" do
    subject { User.new(first_name:'Edlyn', last_name:'Shih', email:'123@gmail.com', password:'password', password_confirmation:'password') }

    it "will save when password and password_confirmation doesn't match" do
      expect(subject).to be_valid
    end

    it "will not save when password and password_confirmation doesn't match" do
      subject.password_confirmation='1234'
      expect(subject).to_not be_valid
    end

    it "ensure emails are unique and not case sensitive" do
      subject.save
      @new_user = User.new(first_name: "test2", last_name: "test2", email: "123@GMAIL.com", password: "password", password_confirmation: "password")
      expect(@new_user).to_not be_valid
    end

    it "will not save when email is blank" do
      subject.email=nil
      expect(subject).to_not be_valid
    end

    it "will not save when first name is blank" do
      subject.first_name=nil
      expect(subject).to_not be_valid
    end

    it "will not save when email is blank" do
      subject.email=nil
      expect(subject).to_not be_valid
    end

    it "will not save when last name is blank" do
      subject.last_name=nil
      expect(subject).to_not be_valid
    end

    it "will not save when password minimum length is not met" do
      subject.password='hello'
      expect(subject).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    subject { User.new(first_name:'Edlyn', last_name:'Shih', email:'123@gmail.com', password:'password', password_confirmation:'password') }

    it "will log the user in when email exists and password is correct" do
      expect(subject).to be_valid
      subject.save

      expect(subject.authenticate_with_credentials('123@gmail.com', 'password')).to_not be_nil
    end

    it "will log the user in when there's spaces before and after their email" do
      subject.email = '  123@gmail.com  '
      subject.save

      expect(subject.authenticate_with_credentials('  123@gmail.com  ', 'password')).to_not be_nil
    end

    it "will log the user with different cases" do
      subject.email = '123@gMaiL.cOm'
      subject.save

      expect(subject.authenticate_with_credentials('123@gMaiL.cOm', 'password')).to_not be_nil
    end
    
  end
    
end