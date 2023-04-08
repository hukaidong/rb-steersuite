#!/usr/bin/env -S ruby -s
# frozen_string_literal: true

require "steersuite"

ARGV.each do |arg|
  Steersuite::SteersimPlot.plot_file(arg)
end
