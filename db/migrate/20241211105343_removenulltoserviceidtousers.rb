class Removenulltoserviceidtousers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :service_id, true
  end
end
