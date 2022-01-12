class AddMicropostIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :micropost_id, :integer
  end
end
