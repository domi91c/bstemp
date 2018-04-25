class User < ApplicationRecord
  has_one :store
  has_many :products
  has_many :orders
  has_many :purchases, through: :orders
  has_many :favorites, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  # validates_presence_of :password
  # validates_presence_of :password_confirmation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def cart_count
    $redis.hlen "cart#{id}"
  end

  def cart_name
    "cart#{id}"
  end

  def customer
    Stripe::Customer.retrieve(stripe_customer_id) if stripe_customer_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def favorite(product)
    favorites.find_or_create_by(product: product)
    product.reload
  end

  def unfavorite(product)
    favorites.where(product: product).destroy_all
    product.reload
  end

end
