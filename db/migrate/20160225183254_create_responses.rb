class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id
      t.integer :respondant_id

      t.timestamps
    end
    
    add_index :responses, :answer_choice_id
    add_index :responses, :respondant_id
  end
end
