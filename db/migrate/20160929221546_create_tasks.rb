class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :script
      t.integer :priority
      t.boolean :repeat
      t.string :memo
      t.boolean :invoked

      t.timestamps
    end
  end
end
