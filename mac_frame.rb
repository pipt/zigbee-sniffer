require "bindata"
require "frame_control"
require "auxiliary_security_header"

class MacFrame < BinData::Record
  endian :little

  frame_control :frame_control
  uint8 :sequence_number

  uint16 :dest_pan_id, :onlyif => :dest_pan_id?
  uint16 :short_dest_address, :onlyif => :short_dest_address?
  uint64 :long_dest_address, :onlyif => :long_dest_address?

  uint16 :source_pan_id, :onlyif => :source_pan_id?
  uint16 :short_source_address, :onlyif => :short_source_address?
  uint64 :long_source_address, :onlyif => :long_source_address?

  auxiliary_security_header :auxiliary_security_header, :onlyif => :security_header?

  def to_s
    "#{sequence_number} " +
      "[#{frame_control.type.to_s}] " +
      "#{source_pan_id}:#{short_source_address} -> #{dest_pan_id}:#{short_dest_address}"
  end

  def dest_pan_id?
    frame_control.dest_addressing_mode > 1
  end

  def short_dest_address?
    frame_control.dest_addressing_mode == 2
  end

  def long_dest_address?
    frame_control.dest_addressing_mode == 3
  end

  def source_pan_id?
    frame_control.source_addressing_mode > 1 && frame_control.pan_id_compression == 0
  end

  def short_source_address?
    frame_control.source_addressing_mode == 2
  end

  def long_source_address?
    frame_control.source_addressing_mode == 3
  end

  def security_header?
    frame_control.security_enabled == 1
  end
end
