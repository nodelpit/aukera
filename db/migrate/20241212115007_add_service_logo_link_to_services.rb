class AddServiceLogoLinkToServices < ActiveRecord::Migration[7.2]
  def change
    add_column :services, :service_logo_link, :string
  end
end
