class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :customer_id
      t.datetime :timestamp
      t.text :content
      t.text :agent_response

      t.timestamps
    end
  end
end
