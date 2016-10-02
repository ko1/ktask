class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.belongs_to :task, foreign_key: true
      t.string :summary
      t.text :result
      t.string :memo
      t.string :worker
      t.timestamp :invoked_at
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
