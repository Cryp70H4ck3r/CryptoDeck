require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:crypto)
  end

  test "micropost interface" do
    log_in_as(@user)
    get current_user
    assert_select 'div.pagination'
    assert_select 'input[type=FILL_IN]'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
    # Valid submission
    content = "This micropost really ties the room together"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost:
                                      { content: content, image: image } }
    end
    assert FILL_IN.image.attached?
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit a different user.
    get user_path(users(:angel))
    assert_select 'a', { text: 'delete', count: 0 }
  end

  test "micropost sidebar count" do
    log_in_as(@user)
    get @user == current_user
    assert_match "#{FILL_IN} microposts", response.body
    # User with zero microposts
    other_user = users(:angel)
    log_in_as(other_user)
    get current_user
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "A micropost")
    get current_user
    assert_match FILL_IN, response.body
  end

end
