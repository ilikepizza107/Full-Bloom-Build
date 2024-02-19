##########################
# Stage-Specific Results #
# [mawwk, ilikepizza107] #
##########################
# Load byte at given address
.macro loadByte(<reg>, <val>)
{
    .alias  temp_Hi = <val> / 0x10000
    .alias  temp_Lo = <val> & 0xFFFF
    lis     <reg>, temp_Hi
    ori     <reg>, <reg>, temp_Lo
	lbz <reg>, 0(<reg>)
}
.alias ConfigID = 0x26
.alias ResultsID = 0x28

	%loadByte(r6, 0x8053EF81)	# r6: ASL stage ID
	mr r7, r23
	cmpwi r6, ResultsID
	bne notResults

StageResults:
	%loadByte(r6, 0x9017F42D)	# Load previous stage ID
	
	cmpwi r6, 0x01; li r5, 0x4246; beq StoreString	# Battlefield
	cmpwi r6, 0x02; li r5, 0x4644; beq StoreString	# Final Destination
	cmpwi r6, 0x04; li r5, 0x4C4D; beq StoreString	# Luigi's Mansion
	cmpwi r6, 0x09; li r5, 0x5454; beq StoreString	# Temple of Time
	cmpwi r6, 0x0C; li r5, 0x4648; beq StoreString	# Frigate Husk
	cmpwi r6, 0x0D; li r5, 0x5949; beq StoreString	# Yoshi's Island
	cmpwi r6, 0x21; li r5, 0x5356; beq StoreString	# Smashville
	cmpwi r6, 0x2D; li r5, 0x444C; beq StoreString	# Dream Land
	cmpwi r6, 0x37; li r5, 0x5452; beq StoreString	# Training Room
	cmpwi r6, 0x47; li r5, 0x4754; beq StoreString	# Golden Temple
	cmpwi r6, 0x2E	# PS2

notResults:
	cmpwi r6, ConfigID
	beq end

DelfinoParamCheck:
	cmpwi r6, 0x03
	bne MetalParamCheck	
	addi r7, r7, 14			# "Delfino_Secret"
	b StartCompare

MetalParamCheck:
	cmpwi r6, 0x05
	bne SVParamCheck	
	addi r7, r7, 12			# "Metal_Cavern"
	b StartCompare

SVParamCheck:
	cmpwi r6, 0x21		\
	bne PS2ParamCheck	
	addi r7, r7, 10			# "Smashville"
	b StartCompare

PS2ParamCheck:
	cmpwi r6, 0x2E			# \ If PS2 and not Inv6 or Inv7,
	bne TOTParamCheck
	addi r7, r7, 17			# "Pokemon_Stadium_2"
	b StartCompare

TOTParamCheck:
	cmpwi r6, 0x09		
	bne YIParamCheck	
	addi r7, r7, 14			# "Temple_of_Time"
	b StartCompare	

YIParamCheck:
	cmpwi r6, 0x0D		
	bne StartCompare
	addi r7, r7, 13			# "Yoshis_Island"

StartCompare:
	lis r4, 0x6C74; ori r4, r4, 0x7300	# "lts" followed by null terminator

StoreString:
	sth r5, 1(r7)			# Replace with new suffix

end: