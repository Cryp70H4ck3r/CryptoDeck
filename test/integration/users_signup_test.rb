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
                                         email: "user@invalid",
                                         bio: "",
                                         location: "",
                                         college_name: "",
                                         college_degree: "",
                                         job_title: "",
                                         job_duties: "",
                                         company_name: "",
                                         btc_adr: "",
                                         eth_adr: "",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
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
                                         btc_adr: "abc123",
                                         eth_adr: "a1b2c3",
                                         password:              "abc123",
                                         password_confirmation: "abc123"  } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
