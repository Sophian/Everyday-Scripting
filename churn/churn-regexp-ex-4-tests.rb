require 'test/unit'
require 'churn-regexp-ex-3.rb'

class RearrangeTests < Test::Unit::TestCase

  def test_rearrange_with_middle_name
    assert_equal("Sophian T. Bensaou",
                 rearrange("Bensaou, Sophian Tokio"))
  end
end
