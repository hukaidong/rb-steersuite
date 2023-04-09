# frozen_string_literal: true

require "numo/gnuplot"
require "pathname"

module Steersuite
  ##
  # Plotting module for Steersim results
  #
  module SteersimPlot
    private

    def get_agent_plot_data(agentdata)
      agentdata.map do |agent|
        agent.transpose << { w: "lines lw 10 notitle" }
      end
    end

    def fill_plot_data_object_0(plot_data, object_data)
      # rectangle
      # xmin, xmax, ymin, ymax
      xmin = object_data.shift
      xmax = object_data.shift
      ymin = object_data.shift
      ymax = object_data.shift
      rect = Steersuite::PlotUtils.rectangle(xmin, xmax, ymin, ymax)
      plot_data << (rect.transpose << { w: "filledcurves closed notitle lt rgb 'black'" })
    end

    def fill_plot_data_object_1(plot_data, object_data)
      # circle
      # x, y, r
      x = object_data.shift
      y = object_data.shift
      r = object_data.shift
      circle = Steersuite::PlotUtils.circle([x, y], r, resolution: 8)
      plot_data << (circle.transpose << { w: "filledcurves closed notitle lt rgb 'black'" })
    end

    def fill_plot_data_object_2(plot_data, object_data)
      # rectangle2
      # x, y, w, h, theta
      x = object_data.shift
      y = object_data.shift
      w = object_data.shift
      h = object_data.shift
      theta = object_data.shift
      rect = Steersuite::PlotUtils.rectangle2([x, y], w, h, theta)
      plot_data << (rect.transpose << { w: "filledcurves closed notitle lt rgb 'black'" })
    end

    def get_obstacle_plot_data(object_type, object_info)
      object_data = object_info.dup
      plot_data = []
      object_type.each do |type|
        case type
        when 1 then fill_plot_data_object_1(plot_data, object_data)
        when 0 then fill_plot_data_object_0(plot_data, object_data)
        when 2 then fill_plot_data_object_2(plot_data, object_data)
        else
          raise "Unknown object type #{type}"
        end
      end
      plot_data
    end

    def get_plot_data(data)
      get_agent_plot_data(data.agent_data) + get_obstacle_plot_data(
        data.object_type, data.object_info
      )
    end

    def plot_scenario(data, filename, title: "")
      gp = Numo::Gnuplot.new
      gp.set terminal: "png"
      gp.set title: title
      gp.set "size ratio -1"
      gp.unset "xtics"
      gp.unset "ytics"
      gp.debug_on if $DEBUG
      gp.plot(*get_plot_data(data))
      gp.output filename.to_s
    end

    public

    def plot_file(filename, target = nil, title: "")
      data = Steersuite::SteersimResult.from_file(filename)
      target ||= Pathname.new(filename).sub_ext(".png")
      plot_scenario(data, target, title: title)
    end

    module_function :fill_plot_data_object_0,
                    :fill_plot_data_object_1,
                    :fill_plot_data_object_2,
                    :get_agent_plot_data, :get_obstacle_plot_data,
                    :get_plot_data, :plot_scenario, :plot_file
  end
end
