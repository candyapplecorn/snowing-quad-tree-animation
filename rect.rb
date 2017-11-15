class Rectangle
	attr_accessor :x, :y, :width, :height

	def initialize(x, y, width = 7, height = 7)
		@x = x
		@y = y
		@width = width
		@height = height
	end
	
	def inside?(x, y)
		x.between?(@x, @x + @width) && y.between?(@y, @y + @height)
	end
end
