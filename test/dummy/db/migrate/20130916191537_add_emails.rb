class AddEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :to
      t.string :from
      t.string :subject
      t.string :body
      t.timestamps
    end
  end
end
