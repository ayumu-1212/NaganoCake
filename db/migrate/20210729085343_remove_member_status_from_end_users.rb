class RemoveMemberStatusFromEndUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :end_users, :members_status, :integer
  end
end
