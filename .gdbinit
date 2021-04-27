set pagination on
set trace-commands on
set logging off
set logging overwrite on
set print frame-arguments all
# print the full thing
set print elements 0
# set disassemble-next-line on

# I have no need to debug std lib code
skip dir /usr

define qquit
	set confirm off
	quit
end
document qquit
Quit without asking for confirmation.
end

define xxd
  if $argc < 2
    set $size = sizeof(*$arg0)
  else
    set $size = $arg1
  end
  dump binary memory dump.bin $arg0 ((void *)$arg0)+$size
  eval "shell xxd -o %d -g 1 dump.bin; rm dump.bin", ((void *)$arg0)
end
document xxd
  Dump memory with xxd command (keep the address as offset)

  xxd addr [size]
    addr -- expression resolvable as an address
    size -- size (in byte) of memory to dump
            sizeof(*addr) is used by default
end

define memd5
  if $argc < 2
    set $size = sizeof(*$arg0)
  else
    set $size = $arg1
  end
  dump binary memory dump.bin $arg0 ((void *)$arg0)+$size
  eval "shell md5sum dump.bin; rm dump.bin"
end
document memd5
  Calculate md5 checksum of a range of memory

  memd5 addr [size]
    addr -- expression resolvable as an address
    size -- size (in byte) of memory to dump
            sizeof(*addr) is used by default
end
