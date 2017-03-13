class CryptoconditionsRuby::Lib::Writer
  attr_accessor :components
  def initialize
    @components = []
  end

  def write_uint(value, length)
    raise TypeError.new('UInt must be an integer') unless value.is_a?(Integer)
    raise TypeError.new('UInt must be positive') unless value > 0
    raise TypeError.new('UInt {} doesn not fit in {} bytes') if sprintf('%02b', value).length > length * 8

    buffer = (length - 1).times.map { 0 }.push(value).pack('C*')
    write(buffer)
  end

  def write_var_uint(value)
    if value.is_a?(String)
      write_var_octet_string(value)
    else
      raise TypeError.new('UInt must be an integer') unless value.is_a?(Integer)
      raise TypeError.new('UInt must be positive') unless value > 0

      length_of_value = (sprintf('%02b', value).length / 8.0).ceil.to_i
      buffer = (length_of_value - 1).times.map { 0 }.push(value).pack('C*')
      write_var_octet_string(buffer)
    end
  end

  def write_octet_string(buffer, length)
    raise TypeError.new('buffer must be an array of bytes') unless value.is_a?(Array)
    raise ArgumentError.new("Incorrect length for octet string (actual: #{buffer.length}, expected: #{value})") unless buffer.length == length

    write(buffer)
  end

  def write_var_octet_string(buffer)
    msb = 0x80
    if buffer.length <= 127
      write_uint8(buffer.length)
    else
      length_of_length = (sprintf('%02b', buffer.length).length / 8.0).ceil.to_i
      write_uint8(msb | length_of_length)
      write_uint(buffer.length, length_of_length)
    end
  end

  def write(in_bytes)
    out = in_bytes
    if out.is_a?(String) || out.is_a?(Array)
      out = out.bytes if out.is_a?(String)
      out = out.map {|i| sprintf('%02x', i).to_i(16).chr }.join
    else
      out = out.encode('utf-8')
    end
    components.append(out)
  end

  def buffer
    components.pack('C*')
  end

  def write_uint8(value)
    write_uint(value, 1)
  end

  def write_uint16(value)
    write_uint(value, 2)
  end

  def write_uint32(value)
    write_uint(value, 4)
  end

  def write_uint64(value)
    write_uint(value, 8)
  end
end
