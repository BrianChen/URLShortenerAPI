class ChangeVisitsColumnNullToFalse < ActiveRecord::Migration[5.0]
  def change
    change_column_null :shortened_urls, :visits, false, default: 0
  end
end
