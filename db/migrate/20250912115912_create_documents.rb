class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :file_type
      t.references :deal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :encrypted_file_data
      t.datetime :upload_date

      t.timestamps
    end
  end
end
