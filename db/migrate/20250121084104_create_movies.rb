class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :casts
      t.string :directors
      t.string :genres
      t.string :status
      t.string :released_date
      t.string :score
      t.string :actions

      t.timestamps
    end
  end
end
