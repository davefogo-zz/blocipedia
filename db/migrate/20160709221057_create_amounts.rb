class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.decimal :default

      t.timestamps null: false
    end
  end
end
