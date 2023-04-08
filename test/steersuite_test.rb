# frozen_string_literal: true

require "tmpdir"
require "securerandom"
require "fileutils"
require "test_helper"

class SteersuiteTest < Minitest::Test
  # A helper verifies the generated file is the same as given file
  # @param [String] generated_file
  # @param [String] truth_file
  # @return [Boolean]
  def assert_file_equal(generated_file, truth_file)
    assert(File.exist?(generated_file))
    assert(File.exist?(truth_file))
    return if File.read(generated_file) == File.read(truth_file)

    # If the files are not the same, write the generated file to a temporary file
    # for debugging purpose
    tmp_file = File.join(Dir.tmpdir, "steersuite-debug-log",
                         Random.alphanumeric)
    FileUtils.mkdir_p(File.dirname(tmp_file))
    File.write(tmp_file, File.read(generated_file))
    flunk "Generated file is not the same as the truth file. A temporary file is written to #{tmp_file}."
  end

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

  def test_if_plot_works
    Dir.mktmpdir do |dir|
      test_file = File.join(dir, "test.png")
      Steersuite::SteersimPlot.plot_file("test/data/sample.bin", test_file)
      assert_file_equal(test_file, "test/data/sample.png")
    end
  end
end
