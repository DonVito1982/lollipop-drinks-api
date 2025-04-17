class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at
    end
  end
end
