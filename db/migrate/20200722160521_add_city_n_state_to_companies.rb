class AddCityNStateToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city_state_blob, :jsonb, null: false, default: '{}'
  end
end
