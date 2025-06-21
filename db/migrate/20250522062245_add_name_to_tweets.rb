class AddNameToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :name, :string
  end
end
