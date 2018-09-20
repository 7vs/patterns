# require 'observer'

module Subject
  def initialize
    @observers = []
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end
end

class Employee
  # include Observable
  include Subject
  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @old_salary = @salary
    @salary = new_salary
    if @old_salary != @salary
      # changed
      # notify_observers(self)
      notify_observers
    end  
  end
end

class Payroll
  def update(changed_employee)
    puts "Cut a new check for #{changed_employee.name}!"
    puts "His salary is now #{changed_employee.salary}!"
  end
end

class Taxman
  def update(changed_employee)
    puts "Send #{changed_employee.name} a new tax bill"
  end
end

payroll = Payroll.new
fred = Employee.new('Fred Flinstone', 'Crane operator', 30000.0)
fred.add_observer(payroll)
fred.salary = 35000.0

taxman = Taxman.new
fred.add_observer(taxman)
fred.salary = 9000.0