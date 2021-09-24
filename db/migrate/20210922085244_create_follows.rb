class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :following, foreign_key: { to_table: :users}
      t.timestamps

      t.index [:user_id, :following_id], unique: true
    end
  end
end
