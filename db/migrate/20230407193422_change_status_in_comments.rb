class ChangeStatusInComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :status, :integer, default: 0
  end
end
