class Stack
  class EmptyStackError < Exception; end

  extend Forwardable

  def initialize
    @stack = []
  end

  def_delegators :@stack, :empty?, :size, :push, :[]

  def pop
    raise Stack::EmptyStackError if empty?
    @stack.pop
  end
end
