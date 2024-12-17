class CreateUserServices < ActiveRecord::Migration[7.2]
  def change
    create_table :user_services do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.timestamps
    end

    add_index :user_services, [:user_id, :service_id], unique: true
  end
end
