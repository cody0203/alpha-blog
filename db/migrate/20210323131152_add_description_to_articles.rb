class AddDescriptionToArticles < ActiveRecord::Migration[6.1]
  def change
    # Add new column - description with type is text for articles table with new migrate file
    add_column :articles, :description, :text
  end
end
