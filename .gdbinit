tui enable
layout src
focus cmd
set trace-commands on
set logging off
set logging overwrite on
# set disassemble-next-line on
set tui border-kind ascii

# I have no need to debug std lib code
skip dir /usr

define qquit
	set confirm off
	quit
end
document qquit
Quit without asking for confirmation.
end
