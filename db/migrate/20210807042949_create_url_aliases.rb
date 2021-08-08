class CreateUrlAliases < ActiveRecord::Migration[6.1]
  def change
    create_table :url_aliases do |t|
      t.string :alias, index: true, null: false
      t.string :url, index: true, null: false
      t.datetime :released_at

      t.timestamps
    end

    add_index :url_aliases, :alias, name: 'index_url_aliases_on_uniq_active_alias', unique: true, where: 'released_at IS NULL'
    add_index :url_aliases, :url, name: 'index_url_aliases_on_uniq_active_url', unique: true, where: 'released_at IS NULL'
  end
end
