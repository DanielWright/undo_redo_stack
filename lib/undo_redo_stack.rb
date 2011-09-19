require 'stack'

class UndoRedoStack < Stack
  class NothingToUndoError < Exception; end
  class NothingToRedoError < Exception; end
  
  attr_accessor :position

  def initialize
    @position = 0
    super
  end
  
  alias :commands_size :size
  
  def has_commands?
    !empty?
  end

  def do(*commands)
    stack = self[0,position].push *commands
    push *stack
    @position = size
  end

  def undo
    raise NothingToUndoError unless has_commands?
    @position -= 1
    self[position]
  end

  def redo
    raise NothingToRedoError if position == commands_size
    self[position].tap { @position += 1}
  end
end
