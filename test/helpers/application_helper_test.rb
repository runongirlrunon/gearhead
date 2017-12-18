require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Gearhead"
    assert_equal full_title("Help"), "Help | Gearhead"
  end
end
