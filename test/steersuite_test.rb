# frozen_string_literal: true

require "test_helper"
require "utils/file_assertion_utils"

require "tmpdir"
require "securerandom"
require "fileutils"

class SteersuiteTest < Minitest::Test
  include FileAssertionUtils

  def test_if_defined_steersim_result
    assert defined? Steersuite::SteersimResult
  end

  def test_if_readbin_works
    assert Steersuite::SteersimResult.from_file("test/data/sample.bin").agent_data
  end

  def test_if_writebin_works
    Dir.mktmpdir do |dir|
      data = Steersuite::SteersimResult.from_file("test/data/sample.bin")
      data.filename = "test"
      data.to_file(dir)
      assert_file_equal(File.join(dir, "test.bin"), "test/data/sample.bin")
    end
  end

  def test_if_readbin_works_with_io
    file = File.open("test/data/sample.bin", "rb")
    assert Steersuite::SteersimResult.from_file(file).agent_data
  end

  def test_if_writebin_works_with_io
    from_file = File.open("test/data/sample.bin", "rb")
    to_file = StringIO.new
    to_file.set_encoding(from_file.external_encoding)

    data = Steersuite::SteersimResult.from_file(from_file)
    data.to_file(to_file)

    source = File.read("test/data/sample.bin", mode: "rb")
    assert_equal(source, to_file.string)
  end

  def test_if_plot_works
    Dir.mktmpdir do |dir|
      test_file = File.join(dir, "test.png")
      Steersuite::SteersimPlot.plot_file("test/data/sample.bin", test_file)
      assert_file_equal(test_file, "test/data/sample.png")
    end
  end
end
