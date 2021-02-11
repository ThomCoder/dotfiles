set pagination on
set trace-commands on
set logging off
set logging overwrite on
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

define xac
    dont-repeat
    set $addr = (char *)($arg0)
    set $endaddr = $addr + $arg1
    while $addr < $endaddr
        printf "%p: ", $addr
        set $lineendaddr = $addr + 8
        if $lineendaddr > $endaddr
            set $lineendaddr = $endaddr
        end
        set $a = $addr
        while $a < $lineendaddr
            printf "0x%02x ", *(unsigned char *)$a
            set $a++
        end
        printf "'"
        set $a = $addr
        while $a < $lineendaddr
            printf "%c", *(char *)$a < 32 || *(char *)$a > 126 ? '.' : *(char *)$a
            set $a++
        end
        printf "'\n"
        set $addr = $addr + 8
    end
end

document xac
Examine memory both as raw bytes as well as ascii print.
usage: xac address count
end
