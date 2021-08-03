class CreateTrackings < ActiveRecord::Migration[6.1]
  def change
    create_table :trackings do |t|
      t.string :event
      t.json :properties

      t.timestamps
    end
  end
end
