class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :occupation, :string
    add_column :users, :birth_date, :datetime
  end
end
