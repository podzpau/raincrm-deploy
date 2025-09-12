class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :deal, null: false, foreign_key: true
      t.string :message_type
      t.datetime :read_at

      t.timestamps
    end
  end
end
