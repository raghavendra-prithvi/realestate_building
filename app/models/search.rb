class Search < ActiveRecord::Base
  set_table_name "search"
  belongs_to :user
end
