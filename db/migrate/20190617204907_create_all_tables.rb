class CreateAllTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
    end

    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :likes
      t.references :user
    end

    create_table :comments do |t|
      t.string :title
      t.string :content
      t.references :user
    end

    create_table :categories do |t|
      t.string :name
      t.references :user
    end

    create_table :category_posts do |t|
      t.references :category
      t.references :post
    end

  end
end
