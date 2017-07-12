class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id, null: false
      t.date :visited_date, null: false
    end

    add_index :visits, :shortened_url_id
  end
end
