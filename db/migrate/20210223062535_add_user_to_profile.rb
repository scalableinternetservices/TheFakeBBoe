class AddUserToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :user, index: true
  end
end
