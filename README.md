# ZigBee Sniffer

A simple program that uses
a [UZBee+](http://www.flexipanel.com/WirelessProducts.htm) to sniff
Zigbee networks. 

## Usage

```
# ruby -I. sniffer.rb 0F --device /dev/tty.usbserial-00001014
212 [beacon] 33784:5 -> 0:0
213 [beacon] 33784:5 -> 0:0
223 [data] 0:1 -> 33784:3
223 [ack] 0:0 -> 0:0
249 [mac_command] 0:0 -> 65535:65535
243 [beacon] 33784:13 -> 0:0
148 [data] 0:3 -> 33784:1
148 [ack] 0:0 -> 0:0
```

The argument `0F` represents the channel to listen on, given in
hexadecimal. ZigBee channels in the 2.4GHz range that the UZBee+
supports are `0x0B` (11) to `0x1A` (26).

Output format is:

```
sequence_number [packet_type] source_pan_id:source_address -> destination_pan_id:destination_address
```

## Not yet implemented / TODO

* Filling in the source PAN ID when PAN ID compression is in use.
* Parsing auxiliary security headers.
* Displaying packet payloads.
