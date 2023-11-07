class AddDetailsToExperiences < ActiveRecord::Migration[7.0]
  def change
    add_column :experiences, :details, :text, null: false
  end
end
