class AddDefaultRoleToMemberships < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :memberships, :role, :integer, default: 0
      end
      
      dir.down do |dir|
        change_column :memberships, :role, :integer, default: nil
      end
    end
  end
end
