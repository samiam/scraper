class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :visitor
      t.string :home
      t.datetime :date
      t.integer :visitor_points
      t.integer :home_points

      t.timestamps null: false
    end
  end
end
