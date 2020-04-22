class AddPhotoLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :photo_links do |t|
      t.string :filepath
      t.integer :columns
      t.integer :rows
    end
  end
end
