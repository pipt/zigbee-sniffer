require "serialport"
require "main"
require "phy_packet"

class Sniffer
  def initialize(port, channel)
    @port = port
    @channel = channel

    trap("INT") do
      leave_promiscuous_mode
      exit!
    end
  end

  def start
    leave_promiscuous_mode
    set_channel(channel)
    enter_promiscuous_mode

    while line = port.readline
      phy = PhyPacket.from_hex_string(line.chomp[6..-1]) rescue nil
      puts phy
    end
  end

private
  attr_reader :port, :channel

  def perform_command(command)
    port.write("#{command}\r\n")
    port.readline.chomp
  end

  def leave_promiscuous_mode
    perform_command("+MSTR=5100")
  end

  def enter_promiscuous_mode
    perform_command("+MSTR=5101")
  end

  def set_channel(channel)
    perform_command("+MSTR=00#{channel}")
  end
end

Main do
  argument("channel")
  option("device") {
    default "/dev/tty.usbserial-00001014"
  }

  def run
    port = SerialPort.new(params["device"].value, 115200, 8, 1)
    Sniffer.new(port, params["channel"].value).start
  end
end
