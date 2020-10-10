class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |col|
      col.text :author
      col.text :content

      col.timestamps
    end
  end
end
