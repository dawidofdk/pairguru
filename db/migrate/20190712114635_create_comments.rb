class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content, nil: false
      t.references :user, foreign_key: true, nil: false
      t.references :movie, foreign_key: true, nil: false

      t.timestamps
    end

    add_index :comments, [:user_id, :movie_id], unique: true
  end
end
