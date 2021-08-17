require 'rails_helper'

RSpec.describe Music, type: :model do
  describe 'Music登録機能の確認' do
    before do
      user = FactoryBot.create(:user)
      @music = FactoryBot.build(:music, user_id: user.id)
    end
    context '正しいデータでMusic登録が行える' do
      it '正しい情報を入力すると、新規音楽登録できること' do
        expect(@music).to be_valid
      end
    end
    context '間違ったデータだとMusic登録が行えない' do
      it 'Category_idが必須であること。' do
        @music.category_id = ''
        @music.valid?
        expect(@music.errors.full_messages).to include("Category can't be blank")
      end
      it 'Genre_idが必須であること。' do
        @music.genre_id = ''
        @music.valid?
        expect(@music.errors.full_messages).to include("Genre can't be blank")
      end
      it '音楽ファイルが必須であること。' do
        @music.music = nil
        @music.valid?
        expect(@music.errors.full_messages).to include('Music must be attached')
      end
      it 'Userが必須であること。' do
        @music.user_id = ''
        @music.valid?
        expect(@music.errors.full_messages).to include('User must exist')
      end
    end
  end
end
