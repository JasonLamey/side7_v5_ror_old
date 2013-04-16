class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :limit => 45
      t.string :code, :limit => 3

      t.timestamps
    end
  end
end
