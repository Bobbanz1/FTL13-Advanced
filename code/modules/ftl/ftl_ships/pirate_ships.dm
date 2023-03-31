/datum/starship/clanker
	name = "pirate clanker"
	description = "A pirate rustbucket made from the scraps of various ships. What a miracle that it actually works."
	faction = list("pirate",60)
	salvage_map = "clanker.dmm"

	//Boarding vars
	boarding_map = "clanker.dmm"
	boarding_chance = 30
	mob_faction = "pirate"

	x_num = 3
	y_num = 3

	hull_integrity = 10
	shield_strength = 1000
	hit_chance = 0.95

	repair_time = 400
	recharge_rate = 200

	init_ship_components = list("1,1" = "ion_weapon", "2,1" = "cockpit", "3,1" = "fast_chaingun",\
	"1,2" = "shields", "2,2" = "repair", "3,2" = "shields",\
	"1,3" = "engine","2,3" = "engine", "3,3" = "engine")


	/*
		WCW
		SRS
		EEE
	*/


/datum/starship/asteroid
	name = "pirate space rock"
	description = "Huh, this is literaly an asteroid with rockets strapped onto it. Neat."
	faction = list("pirate",10)
	salvage_map = "clanker.dmm" //placeholder

	//Boarding vars
	boarding_map = "clanker.dmm" // placeholder
	boarding_chance = 30
	mob_faction = "pirate"

	x_num = 4
	y_num = 5

	hull_integrity = 30
	shield_strength = 1000
	hit_chance = 1.1 //its a fucking asteroid, if you miss this you are stupid

	repair_time = 300
	recharge_rate = 200
	heat_points = 5

	init_ship_components = list("1,1" = "hull", "2,1" = "chaingun", "3,1" = "r_weapon_laser", "4,1" = "hull",\
	"1,2" = "s_weapon", "2,2" = "hull", "3,2" = "hull", "4,2" = "s_weapon",\
	"1,3" = "hull", "2,3" = "repair", "3,3" = "cockpit", "4,3" = "hull",\
	"1,3" = "hull","2,3" = "shield", "3,3" = "reactor", "3,4" = "hull",\
	"1,3" = "hull","2,3" = "engine", "3,3" = "engine", "3,4" = "hull")


	/*
		HWWH
		WHHW
		HRCH
		HSRH
		HEEH
	*/


/datum/starship/purifier
	name = "pirate purifier"
	description = "They want the ship. The crew is disposable."
	faction = list("pirate",50)
	salvage_map = "clanker.dmm" //send a mapper

	x_num = 5
	y_num = 4

	hull_integrity = 18
	shield_strength = 0
	hit_chance = 0.9

	repair_time = 450
	recharge_rate = 225
	init_ship_components = list("1,1" = "ion_weapon", "5,1" = "ion_weapon",\
	"1,2" = "hull", "2,2" = "fast_chembomber", "3,2" = "cockpit", "4,2" = "fast_chembomber", "5,2" = "hull",\
	"2,3" = "reactor", "3,3" = "pirate_boarding_pod", "4,3" = "repair",\
	"2,4" = "engine", "4,4" = "engine")


	/*
		 W   W
		 HWCWH
		  RWR
		  E E
	*/