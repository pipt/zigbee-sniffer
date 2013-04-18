require "bindata"

class FrameControl < BinData::Record
  bit3le :frame_type
  bit1le :security_enabled
  bit1le :frame_pending
  bit1le :ack_request
  bit1le :pan_id_compression
  bit3le :reserved
  bit2le :dest_addressing_mode
  bit2le :frame_version
  bit2le :source_addressing_mode

  def type
    case frame_type
    when 0
      :beacon
    when 1
      :data
    when 2
      :ack
    when 3
      :mac_command
    else
      :reserved
    end
  end
end
