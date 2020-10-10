class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |col|
      col.text :content
      col.integer :post_id

      col.timestamps
    end
  end
end
