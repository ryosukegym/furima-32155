require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nameが空では登録できないこと' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '1test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードに英小文字が含まれない場合無効な状態であること' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include( "Password には英字と数字の両方を含めて設定してください")
    end


    it 'パスワードに数字が含まれない場合無効な状態であること' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include( "Password には英字と数字の両方を含めて設定してください")
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123test'
      @user.password_confirmation = '132test'
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
