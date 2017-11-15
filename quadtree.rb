require_relative 'rect.rb'
require 'byebug'

class QuadNode < Rectangle
	include Enumerable
	attr_reader :children, :depth

	def initialize(x, y, width, height, children = [], depth = 0,  max_occupancy = 5, max_depth = 10)
		super(x, y, width, height)
		@children = children
		@max_depth = max_depth
		@max_occupancy = 5
		@depth = depth
	end

	def get_children
		return @children unless has_child_nodes?

		@u_l.get_children + @u_r.get_children + @l_l.get_children + @l_r.get_children
	end

	def child_nodes
		[@u_l, @u_r, @l_l, @l_r]
	end

	def has_child_nodes?
		child_nodes.none? &:nil?
	end

	def each(&prc)
		if has_child_nodes?
			child_nodes.each {|cn| cn.each(&prc)}
		else
			prc.call(self)
		end
	end

	def insert(c)
		return false unless inside?(c.x, c.y)

		if has_child_nodes?
			child_nodes.each {|q| q.insert(c)}
		else
			@children << c
			split if @children.count > @max_occupancy && @depth < @max_depth
		end

		true
	end

	def split
		return unless @children

		@u_l = @children.select {|c| c.x < @width / 2 && c.y < @height / 2 }
		@u_r = @children.select {|c| c.x > @width / 2 && c.y < @height / 2 }
		@l_l = @children.select {|c| c.x < @width / 2 && c.y > @height / 2 }
		@l_r = @children.select {|c| c.x > @width / 2 && c.y > @height / 2 }

		@children = nil
		half_height = @height / 2
		half_width = @width / 2

		@u_l = QuadNode.new(@x, @y, half_width, half_height, @u_l.dup, @depth + 1)
		@u_r = QuadNode.new(@x + half_width, @y, half_width, half_height, @u_r.dup, @depth + 1)
		@l_l = QuadNode.new(@x, @y+ half_height, half_width, half_height, @l_l.dup, @depth + 1)
		@l_r = QuadNode.new(@x + half_width, @y + half_height, half_width, half_height, @l_r.dup, @depth + 1)
	end

	def get_at(x, y)
		return [] unless inside?(x, y)

		if has_child_nodes?
			@u_l.get_at(x, y) + @u_r.get_at(x, y) +
			@l_l.get_at(x, y) + @l_r.get_at(x, y)
		elsif @children.is_a?(Array)
			return @children
		end
	end
end

if __FILE__ == $PROGRAM_NAME
	qt = QuadNode.new(0, 0, 100, 100)
	rects = Array.new(10) { Rectangle.new(rand(10) * 10, rand(10) * 10) }

	rects.each {|r| qt.insert(r)}
	binding.pry
end
