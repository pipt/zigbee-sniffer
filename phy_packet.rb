require "bindata"
require "mac_frame"

class PhyPacket < BinData::Record
  endian :little

  uint8 :len
  mac_frame :mac_frame

  rest :rest

  def self.from_hex_string(str)
    read(str.scan(/../).map { |x| x.hex.chr }.join)
  end

  def to_s
    mac_frame.to_s
  end
end
