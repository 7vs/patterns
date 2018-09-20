class Encrypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    until reader.eof? #while not reader.eof?
      clear_char = reader.getbyte
      encrypted_char = clear_char ^ @key.getbyte(key_index)
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end

class Decrypter
  def initialize(key)
    @key = key
  end

  def decrypt(reader)
    decrypted_message = ''
    key_index = 0
    until reader.eof?
      encrypted_byte = reader.getbyte
      key_byte = @key.getbyte(key_index)
      decrypted_byte = (encrypted_byte ^ key_byte)
      decrypted_message << decrypted_byte.chr('UTF-8')
      key_index = (key_index + 1) % @key.size
    end
    puts decrypted_message
  end
end

reader = File.open('message.txt')
writer = File.open('message.encrypted', 'w')
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)
reader.close
writer.close

class StringIOAdapter
  def initialize(string)
    @string = string
    @position = 0
  end

  def getbyte
    if @position >= @string.length
      raise EOFError
    else
      ch = @string.getbyte(@position)
      @position += 1
      return ch
    end
  end

  def eof?
    @position >= @string.length
  end
end

reader = StringIOAdapter.new('We attack at dawn')
writer = File.open('out.txt', 'w')
encrypter = Encrypter.new('XYZZY')
encrypter.encrypt(reader, writer)
writer.close



class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color
    # render the text ...
  end
end

class BritishTextObject
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    string = string
    @size_mm = size_mm
    @colour = colour
  end
  # ...
end

bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto
  def color
    colour
  end

  def text
    string
  end
  
  def size_inches
    return size_mm/25.4
  end
end