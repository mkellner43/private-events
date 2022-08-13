class AddDetailsColumnToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :details, :text
  end
end
