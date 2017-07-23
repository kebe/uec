class AddDriverRefToRoutes < ActiveRecord::Migration[5.1]
  def change
    add_reference(:routes, :driver)
  end
end
