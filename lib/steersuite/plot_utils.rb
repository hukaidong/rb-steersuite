# frozen_string_literal: true

##
# This module contains utility functions for converting different
# types of geometric data into the array of points that forms a closed polygon.
#
module Steersuite
  ##
  # Utility functions for plotting
  module PlotUtils
    module_function

    # Returns an array of points that form a unit circle.
    # Result is cached for performance.
    def unit_circle(resolution: 360)
      @unit_circle ||= {}
      @unit_circle[resolution] ||= (0...resolution).map do |i|
        theta = i * 2 * Math::PI / resolution
        [Math.cos(theta), Math.sin(theta)]
      end
    end

    def circle(center, radius, resolution: 360)
      x, y = center
      unit_circle(resolution: resolution).map do |cx, cy|
        [x + cx * radius, y + cy * radius]
      end
    end

    def rectangle(xmin, xmax, ymin, ymax)
      [[xmin, ymin], [xmax, ymin], [xmax, ymax], [xmin, ymax]]
    end

    def rectangle2(center, width, height, theta) # rubocop:disable Metrics/AbcSize
      x, y = center
      w2 = width / 2
      h2 = height / 2
      c = Math.cos(theta)
      s = Math.sin(theta)
      [[x + c * w2 + s * h2, y - s * w2 + c * h2], [x + c * w2 - s * h2, y - s * w2 - c * h2],
       [x - c * w2 - s * h2, y + s * w2 - c * h2], [x - c * w2 + s * h2, y + s * w2 + c * h2]]
    end
  end
end
