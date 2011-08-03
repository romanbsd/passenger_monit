require 'test_helper'

class PassengerMonitTest < Test::Unit::TestCase
  
  def test_setup_block_configures
    PassengerMonit.setup do |config|
      assert_equal PassengerMonit, config
      config.pid_dir = 'test-dir'
    end
    
    assert_equal 'test-dir', PassengerMonit.pid_dir
  end
end