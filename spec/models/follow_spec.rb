require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'Follow登録機能の確認' do
    before do
      @user = FactoryBot.create(:user)
      @followed = FactoryBot.create(:user)
      @follow = FactoryBot.build(:follow, user_id: @user.id, following_id: @followed.id)
    end
    context '正しいデータでフォロー登録が行える' do
      it '正しい情報を入力すると、新規フォロー登録できること' do
        expect(@follow).to be_valid
      end
      it '複数人をフォローできること' do
        @exist_follow = FactoryBot.create(:follow, user_id: @follow.user_id)
        expect(@follow).to be_valid
      end
      it '複数人からフォローされることができること' do
        @exist_follow = FactoryBot.create(:follow, following_id: @follow.following_id)
        expect(@follow).to be_valid
      end
    end
    context '間違ったデータだとフォロー登録が行えない' do
      it 'user_idが必須であること。' do
        @follow.user_id = ''
        @follow.valid?
        expect(@follow.errors.full_messages).to include("User must exist")
      end
      it 'following_idが必須であること。' do
        @follow.following_id = ''
        @follow.valid?
        expect(@follow.errors.full_messages).to include("Following must exist")
      end
      it 'userとfollowingは一致しないこと。' do
        @follow.following_id = @follow.user_id
        @follow.valid?
        expect(@follow.errors.full_messages).to include("User can't follow yourself")
      end
      it 'userとfollowingの組み合わせは唯一であること。' do
        @exist_follow = FactoryBot.create(:follow, user_id: @follow.user_id, following_id: @follow.following_id)
        @follow.valid?
        expect(@follow.errors.full_messages).to include("User has already been taken")
      end
    end
  end
end
