require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject do
      User.new(first_name: 'Test', last_name: 'User', email: 'user@test.com', password: '1234567',
               password_confirmation: '1234567')
    end

    it 'requires the first name to be not empty' do
      # @user = User.create(first_name: nil, last_name: 'Kek', email: 'tyler1@riot.com', password:'1234567')
      # expect(@user.errors.full_messages).to include ("First name can't be blank")
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'requires the last name to be not empty' do
      @user = User.create(first_name: 'Top', last_name: nil, email: 'tyler1@riot.com', password: '1234567')
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'requires the email to be not empty' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: nil, password: '1234567')
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'requires the password check to pass' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'tyler1@riot.com', password: '1234567',
                          password_confirmation: '7654321')
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'does not allow user to create new account with existing email' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                          password_confirmation: '1234567')
      @user1 = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                           password_confirmation: '1234567')
      expect(@user1.errors.full_messages).to include('Email has already been taken')
    end

    it 'does not allow user to create new account with existing email but with different cases' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                          password_confirmation: '1234567')
      @user1 = User.create(first_name: 'Top', last_name: 'Kek', email: 'uSeR1@USer.COM', password: '1234567',
                           password_confirmation: '1234567')
      expect(@user1.errors.full_messages).to include('Email has already been taken')
    end

    it 'does not allow passowrd below the length of 6' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'tyler1@riot.com', password: '123',
                          password_confirmation: '123')
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'should create user if all the conditions are satisfied' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'tyler1@riot.com', password: '123456',
                          password_confirmation: '123456')
      expect(@user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'allows user to login even with leading and trailing spaces' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                          password_confirmation: '1234567')
      logged_in = User.authenticate_with_credentials('    user1@user.com    ', '1234567')
      expect(logged_in).to eq @user
    end

    it 'allows user to login even with different cases' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'eXample@domain.COM', password: '1234567',
                          password_confirmation: '1234567')
      logged_in = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', '1234567')
      expect(logged_in).to_not be_nil
    end

    it 'will not allow user with wrong credentials to log in' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                          password_confirmation: '1234567')
      logged_in = User.authenticate_with_credentials('bleh@user.com', '1234567')
      expect(logged_in).to be_nil
    end

    it 'will allow user with correct credentials to log in' do
      @user = User.create(first_name: 'Top', last_name: 'Kek', email: 'user1@user.com', password: '1234567',
                          password_confirmation: '1234567')
      logged_in = User.authenticate_with_credentials('user1@user.com', '1234567')
      expect(logged_in).to_not be_nil
    end
  end
end
