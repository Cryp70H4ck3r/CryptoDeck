require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:crypto)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                       middle_name: "",
                                       last_name: "",
                                       username: "",
                                       phone: "",
                                       email: "cryp7_h4ck3r@protonmail",
                                       bio: "",
                                       location: "",
                                       college_name: "",
                                       college_degree: "",
                                       job_title: "",
                                       job_duties: "",
                                       company_name: "",
                                       btc_adr: "",
                                       eth_adr: "",
                                       password:              "abc",
                                       password_confirmation: "123" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    first_name  = "Crypto"
    middle_name = "Bio"
    last_name = "Hacker"
    username = "Cryp70 H4ck3r"
    phone = "469-307-2579"
    location = "Planet Earth Milky Way Galaxy"
    bio = "Hacker, Programmer, Nerd"
    college_name = "Ashley University"
    college_degree = "Doctoral of Computer Science"
    company_name = "CryptoDeck"
    job_title = "Lead Programmer"
    job_duties = "Design and build CryptoDeck"
    eth_adr = "0x18A2Dbb76Ff69e0Cb402aa3d564b8f647e42285f"
    btc_adr = "bc1qml9clwsw3a7l0uu9mg4x4tytd2qnd6yp5js9px"
    email = "cryp70_h4ck3r@protonmail.com"
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              middle_name: middle_name,
                                              last_name: last_name,
                                              username: username,
                                              phone: phone,
                                              location: location,
                                              bio: bio,
                                              college_name: college_name,
                                              college_degree: college_degree,
                                              job_title: job_title,
                                              job_duties: job_duties,
                                              company_name: company_name,
                                              eth_adr: eth_adr,
                                              btc_adr: btc_adr,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name,  @user.first_name
    assert_equal middle_name, @user.middle_name
    assert_equal last_name, @user.last_name
    assert_equal username, @user.username
    assert_equal phone, @user.phone
    assert_equal bio, @user.bio
    assert_equal college_name, @user.college_name
    assert_equal college_degree, @user.college_degree
    assert_equal job_title, @user.job_title
    assert_equal company_name, @user.company_name
    assert_equal eth_adr, @user.eth_adr
    assert_equal btc_adr, @user.btc_adr
    assert_equal email, @user.email
  end

end
