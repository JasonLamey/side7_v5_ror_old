class ChangeColumnTypeForCountryInAccount < ActiveRecord::Migration
  def change
    rename_column :accounts, :country, :country_id
  end
end
