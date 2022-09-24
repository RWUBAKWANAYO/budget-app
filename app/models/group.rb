class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :user_transactions

  validates :name, presence: true
  validates :icon, presence: true

  def icons
    data = JSON.parse(File.read('./app/icons/icons.json'))
  end
end
