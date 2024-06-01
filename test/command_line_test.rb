# frozen_string_literal: true

require "test_helper"
require "utils/file_assertion_utils"

class CommandLineTest < Minitest::Test
  include FileAssertionUtils

  def test_if_plot_works
    Dir.mktmpdir do |dir|
      test_file = File.join(dir, "sample.png")
      system("exe/steersim-plot -to=#{dir} test/data/sample.bin")
      assert File.exist?(test_file)
      # TODO: Add a test to compare the generated image with a reference image
      # assert_file_equal(test_file, "test/data/sample.png")
    end
  end
end
