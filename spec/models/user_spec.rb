require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User登録機能の確認' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '正しいデータでUser登録が行える' do
      it '正しい情報を入力すると、新規ユーザー登録できること' do
        expect(@user).to be_valid
      end
    end
    context '間違ったデータだとUser登録が行えない' do
      it 'ニックネームが必須であること。' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'ニックネームが一意性であること。' do
        @user2 = FactoryBot.create(:user)
        @user.nickname = @user2.nickname
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname has already been taken')
      end
      it 'メールアドレスが必須であること。' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること。' do
        @user2 = FactoryBot.create(:user)
        @user.email = @user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is not an email')
      end
      it 'パスワードが必須であること。' do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'xx2xx'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'アイコンカラーが必須であること。' do
        @user.icon_color = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Icon color can't be blank")
      end
      it 'アイコンカラーは、#がつく６桁のカラーフォマットであること' do
        @user.icon_color = '#00abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Icon color must be a color format of #aaaaaa')
      end
      it 'アイコンカラーは、半角英字のみでは登録できないこと' do
        @user.icon_color = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Icon color must be a color format of #aaaaaa')
      end
      it 'アイコンカラーは、半角数字のみでは登録できないこと' do
        @user.icon_color = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Icon color must be a color format of #aaaaaa')
      end
      it 'アイコンカラーは、全角文字では登録できないこと' do
        @user.icon_color = 'あいうエオ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Icon color must be a color format of #aaaaaa')
      end
    end
  end
end
