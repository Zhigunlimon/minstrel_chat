class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.references :attachable
      t.string :attachable_type

      t.timestamps null: false
    end
  end
end
