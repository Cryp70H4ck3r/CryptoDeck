class User < ApplicationRecord

  # Handle Before Saving User Arguments #
  before_save { email.downcase! }

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
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
