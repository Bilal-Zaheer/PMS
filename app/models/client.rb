# frozen_string_literal: true

class Client < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :phone, length: { is: 11 }
  validates :email, uniqueness: true
  paginates_per 5

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end