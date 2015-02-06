class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :email, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
