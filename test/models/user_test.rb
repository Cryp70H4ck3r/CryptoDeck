require "test_helper"

class UserTest < ActiveSupport::TestCase

  # Set Basic User Information Tests #
  def setup
    @user = User.new(first_name: "Crypto", middle_name: "Bio", last_name: "Hacker", username: "Cryp70 H4ck3r", bio: "Ethical Hacker, Programmer, Nerd!", email: "cryp70_h4ck3r@protonmail.com", phone: "469-307-2579", location: "Planet Earth, Milky Way Galaxy", job_title: "Lead Programmer", job_duties: "Design & develop Crypto Deck", company_name: "CryptoDeck", college_degree: "Doctoral of Computer Science", college_name: "Ashley University", btc_adr: "bc1qml9clwsw3a7l0uu9mg4x4tytd2qnd6yp5js9px", eth_adr: "0x18A2Dbb76Ff69e0Cb402aa3d564b8f647e42285f", password: "abc123", password_confirmation: "abc123")
  end

  # Ensure User Input is Valid #
  test "should be valid" do
    assert @user.valid?
  end

  # Test User's First Name Attributes #
  test "First Name (first_name) should be present" do
    @user.first_name = "    "
    assert_not @user.valid?
  end

  test "First Name (first_name) should not be too long" do
    @user.first_name = "a" * 56
    assert_not @user.valid?
  end

  # Test User's Middle Name Attributes #
  test "Middle Name (middle_name) should be present" do
    @user.middle_name = "    "
    assert_not @user.valid?
  end

  test "Middle Name (middle_name) should not be too long" do
    @user.middle_name = "a" * 56
    assert_not @user.valid?
  end

  # Test User's Last Name Attributes #
  test "Last Name (last_name) should be present" do
    @user.last_name = "    "
    assert_not @user.valid?
  end

  test "Last Name (last_name) should not be too long" do
    @user.last_name = "a" * 56
    assert_not @user.valid?
  end

  # Test User's Username Attributes #
  test "Username (username) should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "Username (username) should not be too long" do
    @user.username = "a" * 56
    assert_not @user.valid?
  end

  # Test User's Biography Attributes #
  test "Biography (bio) should be present" do
    @user.bio = "    "
    assert_not @user.valid?
  end

  test "Biography (bio) should not be too long" do
    @user.bio = "a" * 1001
    assert_not @user.valid?
  end

  # Test User's Email Attributes #
  test "Email (email) should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "Email (email) should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "Email (email) validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "Email (email) validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email (email) addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Email (email) addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end


  # Test User's Telephone Attributes #
  test "Telephone (phone) should be present" do
    @user.phone = "    "
    assert_not @user.valid?
  end

  test "Telephone (phone) should not be too long" do
    @user.phone = "a" * 16
    assert_not @user.valid?
  end

  # Test User's Location Attributes #
  test "Location (location) should be present" do
    @user.location = "    "
    assert_not @user.valid?
  end

  test "Location (location) should not be too long" do
    @user.location = "a" * 176
    assert_not @user.valid?
  end

  # Test User's Job Title Attributes #
  test "Job Title (job_title) should be present" do
    @user.job_title = "    "
    assert_not @user.valid?
  end

  test "Job Title (job_title) should not be too long" do
    @user.job_title = "a" * 71
    assert_not @user.valid?
  end

  # Test User's Job Duties & Responsibilities Attributes #
  test "Job Duties (job_duties) should be present" do
    @user.job_duties = "    "
    assert_not @user.valid?
  end

  test "Job Duties (job_duties) should not be too long" do
    @user.job_duties = "a" * 101
    assert_not @user.valid?
  end

  # Test User's Company Name Attributes #
  test "Company Name (company_name) should be present" do
    @user.company_name = "    "
    assert_not @user.valid?
  end

  test "Company Name (company_name) should not be too long" do
    @user.company_name = "a" * 101
    assert_not @user.valid?
  end

  # Test User's College Degree Attributes #
  test "College Degree (college_degree) should be present" do
    @user.college_degree = "    "
    assert_not @user.valid?
  end

  test "College Degree (college_degree) should not be too long" do
    @user.college_degree = "a" * 101
    assert_not @user.valid?
  end

  # Test User's College Name Attributes #
  test "College Name (college_name) should be present" do
    @user.college_name = "    "
    assert_not @user.valid?
  end

  test "College Name (college_name) should not be too long" do
    @user.college_name = "a" * 101
    assert_not @user.valid?
  end

  # Test User's Bitcoin Address Attributes #
  test "Bitcoin Address (btc_adr) should be present" do
    @user.btc_adr = "    "
    assert_not @user.valid?
  end

  test "Bitcoin Address (btc_adr) should not be too long" do
    @user.btc_adr = "a" * 201
    assert_not @user.valid?
  end

  # Test User's Ethereum Address Attributes #
  test "Ethereum Address (eth_adr) should be present" do
    @user.eth_adr = "    "
    assert_not @user.valid?
  end

  test "Ethereum Address (eth_adr) should not be too long" do
    @user.eth_adr = "a" * 201
    assert_not @user.valid?
  end

  # Test User's Password Attributes #
  test "Password (password) should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "Password (password) should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    crypto = users(:crypto)
    angel  = users(:angel)
    assert_not crypto.following?(angel)
    crypto.follow(angel)
    assert crypto.following?(angel)
    crypto.unfollow(angel)
    assert_not crypto.following?(angel)
    assert angel.followers.include?(crypto)
    crypto.follow(crypto)
    assert_not crypto.following?(crypto)
  end

  test "feed should have the right posts" do
    crypto = users(:crypto)
    angel  = users(:angel)
    celtic = users(:celtic)
    # Posts from followed user
    celtic.microposts.each do |post_following|
      assert crypto.feed.include?(post_following)
    end
    # Self-posts for user with followers
    crypto.microposts.each do |post_self|
      assert crypto.feed.include?(post_self)
      assert_equal crypto.feed.distinct, crypto.feed
    end
    # Self-posts for user with no followers
    angel.microposts.each do |post_self|
      assert angel.feed.include?(post_self)
    end
    # Posts from unfollowed user
    angel.microposts.each do |post_unfollowed|
      assert_not crypto.feed.include?(post_unfollowed)
    end
  end

end
