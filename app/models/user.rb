class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    primary_key: :id,
    foreign_key: :author_id
  )
  has_many(
    :responses,
    class_name: "Response",
    primary_key: :id,
    foreign_key: :respondant_id
  )
end
