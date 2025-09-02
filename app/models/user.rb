class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {owner: 0, vet: 1}

  include PgSearch::Model

  pg_search_scope :search_by_specialty,
    against: :specialty,
    using: { tsearch: { prefix: true } }

  pg_search_scope :search_by_city,
    against: :city,
    using: { tsearch: { prefix: true } }
end
