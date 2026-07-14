class RemoveOccurredAtFromInteractions < ActiveRecord::Migration[8.0]
  def change
    remove_column :interactions, :occurred_at
  end
end
