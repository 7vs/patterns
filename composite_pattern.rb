class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end

  def total_number_basic_tasks
    1
  end

  def to_s
    name
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end

  def <<(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def [](index)
    @sub_tasks[index]
  end

  def []=(index, new_value)
    @sub_tasks[index] = new_value
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.get_time_required }
    time
  end

  def total_number_basic_tasks
    total = 0
    @sub_tasks.each { |task| total += task.total_number_basic_tasks }
    total
  end
end

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients –flour \'n sugar')
  end

  def get_time_required
    1.0
  end
end

class AddliquidsTask < Task
  def initialize
    super('Add : water')
  end

  def get_time_required
    1.5
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0
  end
end

class FillPanTask < Task
  def initialize
    super('Fill the pan up with the batter!')
  end

  def get_time_required
    3.0
  end
end

class BakeTask < Task
  def initialize
    super('Put the cake in the oven!')
  end

  def get_time_required
    3.0
  end
end

class FrostTask < Task
  def initialize
    super('Put the cake in the fridge!')
  end

  def get_time_required
    3.0
  end
end

class LickSpoonTask < Task
  def initialize
    super('Yummy!')
  end

  def get_time_required
    1.0
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(AddliquidsTask.new)
    add_sub_task(MixTask.new)
  end
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task(MakeBatterTask.new)
    add_sub_task(FillPanTask.new)
    add_sub_task(BakeTask.new)
    add_sub_task(FrostTask.new)
    add_sub_task(LickSpoonTask.new)
  end
end

cake = MakeCakeTask.new
p cake.get_time_required
p cake.total_number_basic_tasks

ObjectSpace.each_object(Task) { |object| puts "task: #{object}" }


# require 'rubygems'
# require 'fox16'
# include Fox
# application = FXApp.new("CompositeGUI", "CompositeGUI")
# main_window = FXMainWindow.new(application, "Composite",
# nil, nil, DECOR_ALL)
# main_window.width = 400
# main_window.height = 200
# super_frame = FXVerticalFrame.new(main_window,
# LAYOUT_FILL_X|LAYOUT_FILL_Y)
# FXLabel.new(super_frame, "Text Editor Application")
# text_editor = FXHorizontalFrame.new(super_frame,
# LAYOUT_FILL_X|LAYOUT_FILL_Y)
# text = FXText.new(text_editor, nil, 0,
# TEXT_READONLY|TEXT_WORDWRAP|LAYOUT_FILL_X|LAYOUT_FILL_Y)
# text.text = "This is some text."
# # Button bar along the bottom
# button_frame = FXVerticalFrame.new(text_editor,
# LAYOUT_SIDE_RIGHT|LAYOUT_FILL_Y)
# FXButton.new(button_frame, "Cut")
# FXButton.new(button_frame, "Copy")
# FXButton.new(button_frame, "Paste")
# application.create
# main_window.show(PLACEMENT_SCREEN)
# application.run