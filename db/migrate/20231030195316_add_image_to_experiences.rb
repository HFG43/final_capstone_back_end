class AddImageToExperiences < ActiveRecord::Migration[7.0]
  def change
    add_column :experiences, :image, :string, null: false
  end
end
