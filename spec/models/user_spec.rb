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
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'last_nameが空では登録できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(苗字)を入力してください", "お名前(苗字)全角文字を使用してください")
    end

    it 'first_nameが空では登録できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("お名前(名前)を入力してください", "お名前(名前)全角文字を使用してください")
    end

    it 'first_name・漢字・平仮名・カタカナ以外では登録できないこと' do
      @user.first_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(名前)全角文字を使用してください')
    end

    it 'last_name・漢字・平仮名・カタカナ以外では登録できないこと' do
      @user.last_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(苗字)全角文字を使用してください')
    end

    it 'last_name_katakanaが空では登録できないこと' do
      @user.last_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakanaを入力してください", "Last name katakanaはカタカナで入力して下さい。")
    end

    it 'first_name_katakanaが空では登録できないこと' do
      @user.first_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakanaを入力してください", "First name katakanaはカタカナで入力して下さい。")
    end

    it 'first_name_katakanaカタカナ以外では登録できないこと' do
      @user.first_name_katakana = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name katakanaはカタカナで入力して下さい。')
    end

    it 'last_name_katakanaカタカナ以外では登録できないこと' do
      @user.last_name_katakana = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name katakanaはカタカナで入力して下さい。')
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードには英字と数字の両方を含めて設定してください", "パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '1test'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください")
    end

    it 'パスワードに英小文字が含まれない場合無効な状態であること' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードには英字と数字の両方を含めて設定してください")
    end

    it 'パスワードに数字が含まれない場合無効な状態であること' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードには英字と数字の両方を含めて設定してください")
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123test'
      @user.password_confirmation = '132test'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
    end

    it 'emailに@を含まない場合は登録できないこと' do
      @user.email = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it '誕生日は空では登録できないこと' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
