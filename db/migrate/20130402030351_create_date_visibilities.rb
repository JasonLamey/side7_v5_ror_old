class CreateDateVisibilities < ActiveRecord::Migration
  def change
    create_table :date_visibilities do |t|
      t.string :visibility, :limit => 45

      t.timestamps
    end
  end
end
