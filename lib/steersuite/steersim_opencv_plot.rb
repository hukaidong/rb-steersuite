# frozen_string_literal: true

require "numo/gnuplot"
require "pathname"

module Steersuite
  ##
  # Plotting module for Steersim results
  #
  module SteersimOpenCVPlot
    private

    def render_agent_data(agentdata, renderer)
      agentdata.map do |agent|
        renderer.draw_polyline(agent, color: CV::Color::LightGray, thickness: 1)
      end
    end

    def fill_plot_data_object_0(object_data, renderer)
      # rectangle
      # xmin, xmax, ymin, ymax
      xmin = object_data.shift
      xmax = object_data.shift
      ymin = object_data.shift
      ymax = object_data.shift
      rect = Steersuite::PlotUtils.rectangle(xmin, xmax, ymin, ymax)
      renderer.draw_polyfill(rect, color: CV::Color::Black)
    end

    def fill_plot_data_object_1(object_data, renderer)
      # circle
      # x, y, r
      x = object_data.shift
      y = object_data.shift
      r = object_data.shift
      circle = Steersuite::PlotUtils.circle([x, y], r, resolution: 8)
      renderer.draw_polyfill(circle, color: CV::Color::Black)
    end

    def fill_plot_data_object_2(object_data, renderer)
      # rectangle2
      # x, y, w, h, theta
      x = object_data.shift
      y = object_data.shift
      w = object_data.shift
      h = object_data.shift
      deg = object_data.shift
      rect = Steersuite::PlotUtils.rectangle2([x, y], w, h, deg)
      renderer.draw_polyfill(rect, color: CV::Color::Black)
    end

    def render_obstacle_data(object_type, object_info, renderer)
      object_data = object_info.dup
      object_type.each do |type|
        case type
        when 1 then fill_plot_data_object_1(object_data, renderer)
        when 0 then fill_plot_data_object_0(object_data, renderer)
        when 2 then fill_plot_data_object_2(object_data, renderer)
        else
          raise "Unknown object type #{type}"
        end
      end
    end

    public

    def render_steersim_result(data, renderer)
      render_obstacle_data(data.object_type, data.object_info, renderer)
      render_agent_data(data.agent_data, renderer)
    end

    def render_agent_snapshot(data, frame, renderer, agent_id: :all, agent_color: CV::Color::Red)
      target_agent_id = case agent_id
                        when :all
                          (0...data.agent_data.size).to_a
                        when Integer
                          [agent_id]
                        when Array
                          agent_id
                        end
      target_agent_id.each do |id|
        agent_loc = data.agent_data[id].fetch(frame, nil)
        next if agent_loc.nil?

        agent_circle = PlotUtils.circle(agent_loc, 0.15, resolution: 24)
        renderer.draw_polyfill(agent_circle, color: agent_color)
      end
    end

    module_function :fill_plot_data_object_0,
                    :fill_plot_data_object_1,
                    :fill_plot_data_object_2,
                    :render_agent_data,
                    :render_obstacle_data,
                    :render_agent_snapshot,
                    :render_steersim_result
  end
end
