require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         middle_name: "",
                                         last_name: "",
                                         username: "",
                                         phone: "",
                                         email: "cryp70_h4ck3r@Protonmail",
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
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name:  "Crypto",
                                         middle_name: "Bio",
                                         last_name: "Hacker",
                                         username: "Cryp70 H4ck3r",
                                         phone: "469-307-2579",
                                         email: "cryp70_h4ck3r@protonmail.com",
                                         bio: "Ethical Hacker, Programmer, Nerd!",
                                         location: "Planet Earth, Milky Way Galaxy",
                                         college_name: "Ashley University",
                                         college_degree: "Doctoral of Computer Science",
                                         job_title: "Lead Programmer",
                                         job_duties: "Design & Develop CryptoDeck",
                                         company_name: "CryptoDeck",
                                         btc_adr: "bc1qml9clwsw3a7l0uu9mg4x4tytd2qnd6yp5js9px",
                                         eth_adr: "0x18A2Dbb76Ff69e0Cb402aa3d564b8f647e42285f",
                                         password:              "abc123",
                                         password_confirmation: "abc123"  } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

end
