class AddUserIdToFacultyAndStudent < ActiveRecord::Migration
  def change
    add_column :students, :user_id, :integer
    add_column :faculties, :user_id, :integer
  end
end
