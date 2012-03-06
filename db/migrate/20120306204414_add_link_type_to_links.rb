class AddLinkTypeToLinks < ActiveRecord::Migration
  def self.up
    # link_types: 'kids', 'parents'
    add_column :links, :link_type, :string, :null => false, :default => 'kids'
  end

  def self.down
    remove_column :links, :link_type
  end
end
