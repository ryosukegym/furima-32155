require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      experct(@user).to be_valid
    end

    it 'nameが空では登録できないこと' do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Pasword can't be blank")
    end
    it 'passwordが6文字以上であれば登録できること' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードに英小文字が含まれない場合無効な状態であること' do
      @user = User.new(password: '1' + 'A' * 5, password_confirmation: '1A' + 'a' * 3)
      @user.valid?
      expect(@user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
    end

    it 'パスワードに英大文字が含まれない場合無効な状態であること' do
      @user = User.new(password: '1' + 'a' * 5, password_confirmation: '1A' + 'a' * 3)
      @user.valid?
      expect(@user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
    end

    it 'パスワードに数字が含まれない場合無効な状態であること' do
      @user = User.new(password: 'A' + 'a' * 5, password_confirmation: '1A' + 'a' * 3)
      @user.valid?
      expect(@user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
  end
end
