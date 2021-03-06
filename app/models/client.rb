# frozen_string_literal: true

class Client < ApplicationRecord
  paginates_per 5

  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :phone, presence: true, length: { is: 11 }, numericality: { only_integer: true }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.search(search)
    if search
      where('name LIKE (?) OR email LIKE (?)', "%#{search}%", "%#{search}%")
    else
      all
    end.order(:id)
  end
end
