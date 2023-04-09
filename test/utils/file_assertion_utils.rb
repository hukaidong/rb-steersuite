# frozen_string_literal: true

module FileAssertionUtils
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
end
