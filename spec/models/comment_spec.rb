require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'title登録機能のテスト' do
    before do
      user = FactoryBot.create(:user)
      title = FactoryBot.create(:title)
      @comment = FactoryBot.build(:comment, user_id: user.id, title_id: title.id)
    end
    context '正常なデータなら登録できる' do
      it '全て正常なデータなら登録できる' do
        expect(@comment).to be_valid
      end
    end
    context 'データが間違っていると登録できない' do
      it 'textが空だと登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'userが空だと登録できない' do
        @comment.user_id = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'titleが空だと登録できない' do
        @comment.title_id = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Title must exist')
      end
    end
  end
end
