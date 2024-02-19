.macro lwi(<reg>, <val>)
{
    .alias  temp_Hi = <val> / 0x10000
    .alias  temp_Lo = <val> & 0xFFFF
    lis     <reg>, temp_Hi
    ori     <reg>, <reg>, temp_Lo
}

.macro call(<addr>)
{
  	%lwi(r12, <addr>)
  	mtctr r12
  	bctrl    
}

.macro randi()
{
	%call(0x8003fc7c)
}

# Load byte at given address
.macro loadByte(<reg>, <val>)
{
    .alias  temp_Hi = <val> / 0x10000
    .alias  temp_Lo = <val> & 0xFFFF
    lis     <reg>, temp_Hi
    ori     <reg>, <reg>, temp_Lo
	lbz <reg>, 0(<reg>)
}

# Load code menu header given its base toggle address
# .macro cmHeader(<reg>, <val>)
# {
#	.alias  temp_Hi = <val> / 0x10000
#   .alias  temp_Lo = <val> & 0xFFFF
#	lis <reg>, temp_Hi
#	ori <reg>, <reg>, temp_Lo
#	lwz <reg>, 0(<reg>)
#	lbz <reg>, 0xB(<reg>)
#	
# }

# Load theme toggle value
# .alias ThemeToggleLoc = 0x80495D1C
# .macro loadThemeSetting(<reg>)
# {
# 	%loadByte(<reg>, ThemeToggleLoc)
# }