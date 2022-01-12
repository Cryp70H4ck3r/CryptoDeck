class User < ApplicationRecord

  # Handle Before Saving User Arguments #
  attr_accessor :remember_token
  before_save { email.downcase! }
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Validate User's First Name (first_name) Attributes #
  validates :first_name, presence: true, length: { maximum: 55 }, allow_nil: true

  # Validate User's Middle Name (middle_name) Attributes #
  validates :middle_name, presence: true, length: { maximum: 55 }, allow_nil: true

  # Validate User's Last Name (last_name) Attributes #
  validates :last_name, presence: true, length: { maximum: 55 }, allow_nil: true

  # Validate User's Username (username) Attributes #
  validates :username, presence: true, length: { maximum: 55 }

  # Validate User's Biography (bio) Attributes #
  validates :bio, presence: true, length: { maximum: 1000 }, allow_nil: true

  # Set Email REGEX Rubular #
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Validate User's Email (email) Attributes #
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  # Validate User's Telephone (phone) Attributes #
  validates :phone, presence: true, length: { maximum: 15 }, allow_nil: true

  # Validate User's Location (location) Attributes #
  validates :location, presence: true, length: { maximum: 175 }, allow_nil: true

  # Validate User's Job Title (job_title) Attributes #
  validates :job_title, presence: true, length: { maximum: 70 }, allow_nil: true

  # Validate User's Job Duties (job_duties) Attributes #
  validates :job_duties, presence: true, length: { maximum: 100 }, allow_nil: true

  # Validate User's Company Name (company_name) Attributes #
  validates :company_name, presence: true, length: { maximum: 100 }, allow_nil: true

  # Validate User's College Degree (college_degree) Attributes #
  validates :college_degree, presence: true, length: { maximum: 100 }, allow_nil: true

  # Validate User's College Name (college_name) Attributes #
  validates :college_name, presence: true, length: { maximum: 100 }, allow_nil: true

  # Validate User's Bitcoin Address (btc_adr) Attributes #
  validates :btc_adr, presence: true, length: { maximum: 200 }, allow_nil: true

  # Validate User's Ethereum Address (eth_adr) Attributes #
  validates :eth_adr, presence: true, length: { maximum: 200 }, allow_nil: true

  # Ensure User's Has A Secured Password #
  has_secure_password

  # Validate User's Password (password) Attributes #
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end


  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns a user's status feed.
  def feed
    part_of_feed = "relationships.follower_id = :id or microposts.user_id = :id"
    Micropost.left_outer_joins(user: :followers)
             .where(part_of_feed, { id: id })
             .includes(:user, image_attachment: :blob)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end
