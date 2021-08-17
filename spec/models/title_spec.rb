require 'rails_helper'

RSpec.describe Title, type: :model do
  describe 'User登録機能の確認' do
    before do
      user = FactoryBot.create(:user)
      music = FactoryBot.create(:music)
      @title = FactoryBot.build(:title, user_id: user.id, music_id: music.id)
    end
    context '正しいデータでtitle登録が行える' do
      it '正しい情報を入力すると、タイトル登録できること' do
        expect(@title).to be_valid
      end
    end
    context '間違ったデータだとtitle登録が行えない' do
      it 'タイトルが必須であること。' do
        @title.title = ''
        @title.valid?
        expect(@title.errors.full_messages).to include("Title can't be blank")
      end
      it 'カラーが必須であること。' do
        @title.color = ""
        @title.valid?
        expect(@title.errors.full_messages).to include("Color can't be blank")
      end
      it 'カラーは、#がつく６桁のカラーフォマットであること' do
        @title.color = "#00abc"
        @title.valid?
        expect(@title.errors.full_messages).to include("Color must be a color format of #aaaaaa")
      end
      it 'カラーは、半角英字のみでは登録できないこと' do
        @title.color = "aaaaaaa"
        @title.valid?
        expect(@title.errors.full_messages).to include("Color must be a color format of #aaaaaa")
      end
      it 'カラーは、半角数字のみでは登録できないこと' do
        @title.color = "1234567"
        @title.valid?
        expect(@title.errors.full_messages).to include("Color must be a color format of #aaaaaa")
      end
      it 'アイコンカラーは、全角文字では登録できないこと' do
        @title.color = "アイウエオか"
        @title.valid?
        expect(@title.errors.full_messages).to include("Color must be a color format of #aaaaaa")
      end
      it 'ユーザーが空だと登録できないこと' do
        @title.user_id = ""
        @title.valid?
        expect(@title.errors.full_messages).to include("User must exist")
      end
      it '音楽が空だと登録できないこと' do
        @title.music_id = ""
        @title.valid?
        expect(@title.errors.full_messages).to include("Music must exist")
      end
    end
  end
end
