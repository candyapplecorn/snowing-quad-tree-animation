require 'byebug'
require_relative 'rect.rb'
require 'gosu'
require_relative 'quadtree.rb'

class Tutorial < Gosu::Window
  def initialize
	@width = 640
 	@height = 480
  	super @width, @height 

	self.caption = "Snow - Move the Mouse Around!"

	@quad = QuadNode.new(0, 0, @width, @height)

	@snowflakes = Array.new(100) do
		Rectangle.new(rand(@width), rand(@height)) 
	end
  end
  
  def update
	nq = QuadNode.new(0, 0, @width, @height)

	@snowflakes.each {|s| nq.insert(s) }

	@quad = nq
  end
  
  def draw
	show_background
	show_boxes
	outline_nodes unless mouse_x < @width * 0.2
  end

	def show_boxes
		in_win = cursor_in_window?
		@snowflakes.each do |b|
			unless in_win
				b.x += rand(2)
				b.y += rand(3)
				b.x %= @width
				b.y %= @height
			end

			ani_rect(b, in_win ? 0xff_ff0000 : 0xff_ffffff)
		end
	end

	def outline_nodes
		@quad.each do |node|
			ani_rect_outline node
		end
	end

	def show_background
		@background_image ||= Gosu::Image.new('assets/airadventurelevel4.png')
		@fx ||= @width.fdiv @background_image.width
		@fy ||= @height.fdiv @background_image.height

		@background_image.draw(0, 0, 0, @fx, @fy)
	end

	def cursor_in_window?
		mouse = get_mouse
		x = (mouse[:x] - @width).abs
		y = (mouse[:y] - @height).abs

		return x.between?(@width * 0.2, @width * 0.8) && 
			y.between?(@height * 0.2, @height * 0.8)
	end

	def needs_cursor?; true; end
end


def ani_rect(rect, color = Gosu::Color.argb(0xff_ffffff))
	Gosu::draw_rect(rect.x, rect.y, rect.width, 
					rect.height, color)#, z = 0, mode = :default)
end

def get_mouse
	{ :x => mouse_x, :y => mouse_y }
end

def ani_rect_outline(qn, c = Gosu::Color.argb(0xff_000000))
	# top and bottom lines
	draw_line(qn.x, qn.y, c, qn.x + qn.width, qn.y, c)
	draw_line(qn.x, qn.y + qn.height, c, qn.x + qn.width, qn.y + qn.height, c)
	# right and left lines
	draw_line(qn.x, qn.y, c, qn.x, qn.y + qn.height, c)
	draw_line(qn.x + qn.width, qn.y, c, qn.x + qn.width, qn.y + qn.height, c)
end


Tutorial.new.show
