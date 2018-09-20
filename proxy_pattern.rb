class BankAccount
  attr_reader :balance

  def initialize(starting_balance=0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end


require 'etc'

class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end

  def method_missing(method_name, *args)
    check_access
    @subject.send(method_name, *args)
  end

  def check_access
    if Etc.getlogin != @owner_name
      raise "Illegal access: #{Etc.getlogin} cannot access account."
    end
  end
end

account.deposit(50)
account.withdraw(10)
proxy = BankAccountProxy.new(account, 'Owner Name')
proxy.deposit(50)
proxy.withdraw(10)


class VirtualAccountProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(method_name, *args)
    s = subject
    s.send(method_name, *args)
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

account = VirtualAccountProxy.new { BankAccount.new(10) }

