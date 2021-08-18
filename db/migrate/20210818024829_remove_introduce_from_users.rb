class RemoveIntroduceFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :introduce, :text
  end
end
