class CreateDeals < ActiveRecord::Migration[8.0]
  def change
    create_table :deals do |t|
      t.string :title
      t.string :deal_type
      t.string :status
      t.decimal :purchase_price
      t.decimal :loan_amount
      t.references :contact, null: false, foreign_key: true
      t.references :loan_officer, null: false, foreign_key: { to_table: :users }
      t.date :estimated_close_date
      t.date :actual_close_date
      t.text :notes

      t.timestamps
    end
  end
end
