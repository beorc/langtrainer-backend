class AddTokenAndSlugsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :current_course_slug, :string
    add_column :users, :language_slug, :string
    add_column :users, :native_language_slug, :string
    add_column :users, :question_help_enabled, :boolean, default: true
  end
end
