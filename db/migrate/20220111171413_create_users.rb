class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      # Basic Personal Intel #
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :username
      t.string :bio
      # Basic Contact Intel #
      t.string :email
      t.string :phone
      t.string :location
      # Basic Job Intel #
      t.string :job_title
      t.string :job_duties
      t.string :company_name
      # Basic College Intel #
      t.string :college_degree
      t.string :college_name
      # Basic BTC & ETH Addresses Intel #
      t.string :btc_adr
      t.string :eth_adr

      t.timestamps
    end
  end
end
