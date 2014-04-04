class CreateWebCounts < ActiveRecord::Migration
  def change
    create_table :web_counts do |t|
      t.integer :num_request, default: 0

      t.timestamps
    end
  end
end
