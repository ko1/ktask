class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name,                      null: false
      t.text :script,                      null: false
      t.string :description,               null: false
      t.integer :priority, default: 0,     null: false
      t.boolean :repeat,   default: false, null: false
      t.timestamps
    end
  end
end
