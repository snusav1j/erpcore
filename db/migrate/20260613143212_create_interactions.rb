class CreateInteractions < ActiveRecord::Migration[8.0]
  def change
    create_table :interactions do |t|
      t.references :client, null: false, foreign_key: true

      t.string :interaction_type
      t.string :status
      t.text :comment

      t.datetime :occurred_at

      t.timestamps
    end
  end
end