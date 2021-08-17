class CreateTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :titles do |t|
      t.string :title,      null: false
      t.string :color,      null: false
      t.references :user,   null: false, foreign_key: true
      t.references :music,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
