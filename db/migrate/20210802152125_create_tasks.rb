class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
