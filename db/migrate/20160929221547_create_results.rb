class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.belongs_to :task, foreign_key: true
      t.string :status
      t.string :short_result
      t.text :result

      t.timestamps
    end
  end
end
