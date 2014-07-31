class AddLikeNumToMessages < ActiveRecord::Migration

  def change
    add_column :messages, :like_num, :integer
  end

end
