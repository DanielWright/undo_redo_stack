require 'stack'

class UndoRedoStack
  class NothingToUndoError < Exception; end
  class NothingToRedoError < Exception; end

  def initialize
    @commands = Stack.new
    @undos = Stack.new
  end
  
  def commands_size
    @commands.size
  end

  def has_commands?
    false
  end

  def do(*commands)
    @commands.push *commands
  end

  def undo
    raise NothingToUndoError if @commands.empty?
    @commands.pop.tap { |command| @undos.push command }
  end

  def redo
    raise NothingToRedoError if @undos.empty?
    @undos.pop.tap { |command| @commands.push command }
  end
end
