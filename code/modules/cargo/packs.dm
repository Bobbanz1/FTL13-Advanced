/datum/supply_pack
	var/name = "Crate"
	var/group = ""
	var/hidden = FALSE
	var/contraband = FALSE
	var/cost = 700 // Minimum cost, or infinite points are possible.
	var/access = FALSE
	var/access_any = FALSE
	var/list/contains = null
	var/crate_name = "crate"
	var/crate_type = /obj/structure/closet/crate
	var/dangerous = FALSE // Should we message admins?
	var/special = FALSE //Event/Station Goals/Admin enabled packs
	var/special_enabled = FALSE


			// ftl specific vars
	var/sensitivity = 0 // 0 = all, 1 = neutral,solgov,nt, 2 = nt
	var/min_amount_to_stock = -1	//-1 is infinite in stock; change to reflect scarcity. If -1, will not run a rand.
	var/max_amount_to_stock
	var/base_chance_to_spawn = 50	// reflects base chance an item has to appear in a station on generation; modified by station module and faction
	var/list/chance_modifiers	//assoc list that holds bonuses/maluses per faction_chances; FACTION/MODULE = +-CHANCE; adds to the base chance.
	var/list/cost_modifiers	//a regular list of keywords, which are checked against a module's keywords to determine final price at a station. Cost modifiers set in module.

/datum/supply_pack/proc/generate(turf/T)
	var/obj/structure/closet/crate/C = new crate_type(T)
	C.name = crate_name
	if(access)
		C.req_access = list(access)
	if(access_any)
		C.req_one_access = access_any

	fill(C)

	return C

/datum/supply_pack/proc/fill(obj/structure/closet/crate/C)
	for(var/item in contains)
		new item(C)


//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Emergency ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/emergency
	group = "Emergency"
	base_chance_to_spawn = 60

/datum/supply_pack/emergency/spacesuit
	name = "Space Suit Crate"
	cost = 3000
	access = ACCESS_EVA
	chance_modifiers = list("Nanotrasen" = 15, "Emergency" = 10)
	cost_modifiers = list("Emergency")
	contains = list(/obj/item/clothing/suit/space,
					/obj/item/clothing/suit/space,
					/obj/item/clothing/head/helmet/space,
					/obj/item/clothing/head/helmet/space,
					/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath)
	crate_name = "space suit crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/vehicle
	name = "Biker Gang Kit" //TUNNEL SNAKES OWN THIS TOWN
	cost = 2000
	contraband = TRUE
	chance_modifiers = list("Solgov" = 10, "Vehicle" = 50)
	cost_modifiers = list("Vehicle", "Clothes")
	base_chance_to_spawn = 20 //gotta make atvs rare
	contains = list(/obj/vehicle/atv,
					/obj/item/key,
					/obj/item/clothing/suit/jacket/leather/overcoat,
					/obj/item/clothing/gloves/color/black,
					/obj/item/clothing/head/soft,
					/obj/item/clothing/mask/bandana/skull)//so you can properly #cargoniabikergang
	crate_name = "Biker Kit"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/emergency/equipment
	name = "Emergency Equipment"
	cost = 3500
	chance_modifiers = list("Nanotrasen" = 15, "Emergency" = 10, "Solgov" = 5, "Syndicate" = -15, "Robotics" = 10)
	cost_modifiers = list("Emergency", "Atmos", "Robotics")
	contains = list(/mob/living/simple_animal/bot/floorbot,
					/mob/living/simple_animal/bot/floorbot,
					/mob/living/simple_animal/bot/medbot,
					/mob/living/simple_animal/bot/medbot,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas)
	crate_name = "emergency crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/internals
	name = "Internals Crate"
	cost = 1000
	chance_modifiers = list("Nanotrasen" = 15, "Emergency" = 10, "Syndicate" = -20)
	cost_modifiers = list("Emergency", "Atmos")
	contains = list(/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath,
					/obj/item/clothing/mask/breath,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air,
					/obj/item/tank/internals/air)
	crate_name = "internals crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/firefighting
	name = "Firefighting Crate"
	cost = 1000
	chance_modifiers = list("Nanotrasen" = 10, "Emergency" = 10)
	cost_modifiers = list("Emergency")
	contains = list(/obj/item/clothing/suit/fire/firefighter,
					/obj/item/clothing/suit/fire/firefighter,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/mask/gas,
					/obj/item/device/flashlight,
					/obj/item/device/flashlight,
					/obj/item/tank/internals/oxygen/red,
					/obj/item/tank/internals/oxygen/red,
					/obj/item/extinguisher,
					/obj/item/extinguisher,
					/obj/item/clothing/head/hardhat/red,
					/obj/item/clothing/head/hardhat/red)
	crate_name = "firefighting crate"

/datum/supply_pack/emergency/atmostank
	name = "Firefighting Watertank"
	cost = 1000
	access = ACCESS_ATMOSPHERICS
	chance_modifiers = list("Engineering" = 10, "Atmos" = 20)
	cost_modifiers = list("Emergency", "Atmos")
	contains = list(/obj/item/watertank/atmos)
	crate_name = "firefighting watertank crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/emergency/radiation
	name = "Radiation Protection Crate"
	cost = 1000
	chance_modifiers = list("Engineering" = 10, "Supermatter" = 30)
	cost_modifiers = list("Emergency", "Engineering")
	contains = list(/obj/item/clothing/head/radiation,
					/obj/item/clothing/head/radiation,
					/obj/item/clothing/suit/radiation,
					/obj/item/clothing/suit/radiation,
					/obj/item/device/geiger_counter,
					/obj/item/device/geiger_counter,
					/obj/item/reagent_containers/food/drinks/bottle/vodka,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass)
	crate_name = "radiation protection crate"
	crate_type = /obj/structure/closet/crate/radiation

/datum/supply_pack/emergency/weedcontrol
	name = "Weed Control Crate"
	cost = 1500
	access = ACCESS_HYDROPONICS
	chance_modifiers = list("Food" = 10, "Emergency" = 10)
	cost_modifiers = list("Emergency", "Food")
	contains = list(/obj/item/scythe,
					/obj/item/clothing/mask/gas,
					/obj/item/grenade/chem_grenade/antiweed,
					/obj/item/grenade/chem_grenade/antiweed)
	crate_name = "weed control crate"
	crate_type = /obj/structure/closet/crate/secure/hydroponics

/datum/supply_pack/emergency/metalfoam
	name = "Metal Foam Grenade Crate"
	cost = 1000
	chance_modifiers = list("Engineering" = 10)
	contains = list(/obj/item/storage/box/metalfoam)
	crate_name = "metal foam grenade crate"

/datum/supply_pack/emergency/smartmetalfoam
	name = "Smart Metal Foam Grenade Crate"
	cost = 1250
	chance_modifiers = list("Engineering" = 5)
	contains = list(/obj/item/storage/box/smartmetalfoam)
	crate_name = "smart metal foam grenade crate"

/datum/supply_pack/emergency/droneshells
	name = "Drone Shell Crate"
	cost = 1000
	chance_modifiers = list("Robotics" = 10)

	contains = list(/obj/item/drone_shell,
					/obj/item/drone_shell,
					/obj/item/drone_shell)
	crate_name = "drone shell crate"

/datum/supply_pack/emergency/spacesuits
	name = "EVA Suit Crate"
	cost = 2000
	chance_modifiers = list("Engineering" = 10, "Atmos" = 10)
	cost_modifiers = list("Emergency", "Atmos")
	contains = list(/obj/item/clothing/suit/space/eva,
					/obj/item/clothing/suit/space/eva,
					/obj/item/clothing/suit/space/eva,
					/obj/item/clothing/head/helmet/space/eva,
					/obj/item/clothing/head/helmet/space/eva,
					/obj/item/clothing/head/helmet/space/eva,)
	crate_name = "EVA Suit Crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/specialops
	name = "Special Ops Supplies"
	hidden = TRUE
	cost = 2000
	chance_modifiers = list("Syndicate" = 100, "Security" = 20)
	cost_modifiers = list("Emergency", "Atmos")
	contains = list(/obj/item/storage/box/emps,
					/obj/item/grenade/smokebomb,
					/obj/item/grenade/smokebomb,
					/obj/item/grenade/smokebomb,
					/obj/item/pen/sleepy,
					/obj/item/grenade/chem_grenade/incendiary)
	crate_name = "emergency crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/syndicate
	name = "NULL_ENTRY"
	hidden = TRUE
	cost = 20000
	contains = list()
	crate_name = "emergency crate"
	crate_type = /obj/structure/closet/crate/internals
	chance_modifiers = list("Syndicate" = 100, "Nanotrasen"=-100)
	dangerous = TRUE

/datum/supply_pack/emergency/syndicate/fill(obj/structure/closet/crate/C)
	var/crate_value = 30
	var/list/uplink_items = get_uplink_items(SSticker.mode)
	while(crate_value)
		var/category = pick(uplink_items)
		var/item = pick(uplink_items[category])
		var/datum/uplink_item/I = uplink_items[category][item]

		if(!I.surplus || prob(100 - I.surplus))
			continue
		if(crate_value < I.cost)
			continue
		crate_value -= I.cost
		new I.item(C)

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Security ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/security
	group = "Security"
	access = ACCESS_SECURITY
	crate_type = /obj/structure/closet/crate/secure/gear
	sensitivity = 2
	base_chance_to_spawn = 25
	min_amount_to_stock = -1	// chance for infinite stuff. Makes sense, since most of this won't be seen outside of security keyworded areas.
	max_amount_to_stock = 5

/datum/supply_pack/security/supplies
	name = "Security Supplies Crate"
	cost = 1000
	chance_modifiers = list("Security" = 50, "Toys" = -25, "Clothes" = 10)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/storage/box/flashbangs,
					/obj/item/storage/box/teargas,
					/obj/item/storage/box/flashes,
					/obj/item/storage/box/handcuffs)
	crate_name = "security supply crate"

/datum/supply_pack/security/helmets
	name = "Helmets Crate"
	cost = 1000
	chance_modifiers = list("Security" = 50, "Clothes" = 25)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/clothing/head/helmet/sec,
					/obj/item/clothing/head/helmet/sec,
					/obj/item/clothing/head/helmet/sec)
	crate_name = "helmet crate"

/datum/supply_pack/security/armor
	name = "Armor Crate"
	cost = 1000
	chance_modifiers = list("Security" = 30, "Toys" = -25, "Emergency" = 10)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/suit/armor/vest,
					/obj/item/clothing/suit/armor/vest)
	crate_name = "armor crate"

/datum/supply_pack/security/baton
	name = "Stun Batons Crate"
	cost = 1000
	chance_modifiers = list("Security" = 50, "Toys" = -10)
	cost_modifiers = list("Security")
	contains = list(/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded,
					/obj/item/melee/baton/loaded)
	crate_name = "stun baton crate"

/datum/supply_pack/security/wall_flash
	name = "Wall-Mounted Flash Crate"
	cost = 1000
	chance_modifiers = list("Security" = 50, "Engineering" = 25,)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash,
					/obj/item/storage/box/wall_flash)
	crate_name = "wall-mounted flash crate"

/datum/supply_pack/security/laser
	name = "Lasers Crate"
	cost = 2000
	base_chance_to_spawn = 5 //let's not have most stations packin heat
	chance_modifiers = list("Security" = 75, "Toys" = -5)
	cost_modifiers = list("Security")
	contains = list(/obj/item/gun/energy/laser,
					/obj/item/gun/energy/laser,
					/obj/item/gun/energy/laser)
	crate_name = "laser crate"

/datum/supply_pack/security/taser
	name = "Taser Crate"
	cost = 3000	// why do tazers cost more than lethals???
	base_chance_to_spawn = 30
	chance_modifiers = list("Security" = 50, "Toys" = -25)
	cost_modifiers = list("Security")
	contains = list(/obj/item/gun/energy/e_gun/advtaser,
					/obj/item/gun/energy/e_gun/advtaser,
					/obj/item/gun/energy/e_gun/advtaser)
	crate_name = "taser crate"

/datum/supply_pack/security/disabler
	name = "Disabler Crate"
	cost = 1500
	base_chance_to_spawn = 35
	chance_modifiers = list("Security" = 50, "Toys" = -15)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler,
					/obj/item/gun/energy/disabler)
	crate_name = "disabler crate"
	sensitivity = 1

/datum/supply_pack/security/forensics
	name = "Forensics Crate"
	cost = 2000
	chance_modifiers = list("Security" = 25, "Toys" = -5, "Clothes" = 25)
	cost_modifiers = list("Security", "Clothes")
	contains = list(/obj/item/device/detective_scanner,
	                /obj/item/storage/box/evidence,
	                /obj/item/device/camera,
	                /obj/item/device/taperecorder,
	                /obj/item/toy/crayon/white,
	                /obj/item/clothing/head/fedora/det_hat)
	crate_name = "forensics crate"
	sensitivity = 1

/datum/supply_pack/security/armory
	access = ACCESS_ARMORY
	crate_type = /obj/structure/closet/crate/secure/weapon
	base_chance_to_spawn = 5
	chance_modifiers = list("Security" = 75, "Toys" = -5)
	cost_modifiers = list("Security")

/datum/supply_pack/security/armory/stechkin_ammo
	name = "10mm Ammunition Crate"
	cost = 3000
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Ammo" = 25)
	cost_modifiers = list("Security", "Ammo")
	contains = list(/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/c10mm,
					/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm)
	crate_name = "10mm ammunition crate"
	sensitivity = 1					//highly doubt the syndies would give sec ammo

/datum/supply_pack/security/armory/riothelmets
	name = "Riot Helmets Crate"
	cost = 1500
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Ammo" = 25, "Clothing" = 25)
	cost_modifiers = list("Security", "Ammo", "Clothing")
	contains = list(/obj/item/clothing/head/helmet/riot,
					/obj/item/clothing/head/helmet/riot,
					/obj/item/clothing/head/helmet/riot)
	crate_name = "riot helmets crate"

/datum/supply_pack/security/armory/riotarmor
	name = "Riot Armor Crate"
	cost = 1500
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Clothing" = 25)
	cost_modifiers = list("Security", "Clothing")
	contains = list(/obj/item/clothing/suit/armor/riot,
					/obj/item/clothing/suit/armor/riot,
					/obj/item/clothing/suit/armor/riot)
	crate_name = "riot armor crate"

/datum/supply_pack/security/armory/riotshields
	name = "Riot Shields Crate"
	cost = 2000
	contains = list(/obj/item/shield/riot,
					/obj/item/shield/riot,
					/obj/item/shield/riot)
	crate_name = "riot shields crate"

/datum/supply_pack/security/armory/bulletarmor
	name = "Bulletproof Armor Crate"
	cost = 1500
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Clothing" = 10)
	cost_modifiers = list("Security")
	contains = list(/obj/item/clothing/suit/armor/bulletproof,
					/obj/item/clothing/suit/armor/bulletproof,
					/obj/item/clothing/suit/armor/bulletproof)
	crate_name = "bulletproof armor crate"

/datum/supply_pack/security/armory/swat
	name = "SWAT Crate"
	cost = 6000
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Clothing" = 10)
	cost_modifiers = list("Security")
	contains = list(/obj/item/clothing/head/helmet/swat/nanotrasen,
					/obj/item/clothing/head/helmet/swat/nanotrasen,
					/obj/item/clothing/suit/space/swat,
					/obj/item/clothing/suit/space/swat,
					/obj/item/clothing/mask/gas/sechailer/swat,
					/obj/item/clothing/mask/gas/sechailer/swat,
					/obj/item/storage/belt/military/assault,
					/obj/item/storage/belt/military/assault,
					/obj/item/clothing/gloves/combat,
					/obj/item/clothing/gloves/combat)
	crate_name = "swat crate"

/datum/supply_pack/security/armory/combatknives
	name = "Combat Knives Crate"
	cost = 3000
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Melee" = 25)
	cost_modifiers = list("Security", "Melee")
	contains = list(/obj/item/kitchen/knife/combat,
					/obj/item/kitchen/knife/combat,
					/obj/item/kitchen/knife/combat)
	crate_name = "combat knife crate"

/datum/supply_pack/security/armory/laserarmor
	name = "Reflector Vest Crate"
	cost = 2000
	chance_modifiers = list("Security" = 75, "Toys" = -5)
	cost_modifiers = list("Security")
	contains = list(/obj/item/clothing/suit/armor/laserproof,
					/obj/item/clothing/suit/armor/laserproof)
	crate_name = "reflector vest crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/ballistic
	name = "Combat Shotguns Crate"
	cost = 8000
	contains = list(/obj/item/gun/ballistic/shotgun/automatic/combat,
					/obj/item/gun/ballistic/shotgun/automatic/combat,
					/obj/item/gun/ballistic/shotgun/automatic/combat,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier)
	crate_name = "combat shotguns crate"

/datum/supply_pack/security/armory/energy
	name = "Energy Guns Crate"
	cost = 2500
	contains = list(/obj/item/gun/energy/e_gun,
					/obj/item/gun/energy/e_gun)
	crate_name = "energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/security/armory/fire
	name = "Incendiary Weapons Crate"
	cost = 1500
	access = ACCESS_HEADS
	contains = list(/obj/item/flamethrower/full,
					/obj/item/tank/internals/plasma,
					/obj/item/tank/internals/plasma,
					/obj/item/tank/internals/plasma,
					/obj/item/grenade/chem_grenade/incendiary,
					/obj/item/grenade/chem_grenade/incendiary,
					/obj/item/grenade/chem_grenade/incendiary)
	crate_name = "incendiary weapons crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	dangerous = TRUE

/datum/supply_pack/security/armory/wt550
	name = "WT-550 Auto Rifle Crate"
	cost = 3500
	contains = list(/obj/item/gun/ballistic/automatic/wt550,
					/obj/item/gun/ballistic/automatic/wt550)
	crate_name = "auto rifle crate"

/datum/supply_pack/security/armory/wt550ammo
	name = "WT-550 Auto Rifle Ammo Crate"
	cost = 3000
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Ammo" = 30)
	cost_modifiers = list("Security", "Ammo")
	contains = list(/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9)
	crate_name = "auto rifle ammo crate"

/datum/supply_pack/security/armory/mindshield
	name = "mindshield implants Crate"
	cost = 4000
	contains = list(/obj/item/storage/lockbox/loyalty)
	crate_name = "mindshield implant crate"

/datum/supply_pack/security/armory/trackingimp
	name = "Tracking Implants Crate"
	cost = 2000
	contains = list(/obj/item/storage/box/trackimp)
	crate_name = "tracking implant crate"

/datum/supply_pack/security/armory/chemimp
	name = "Chemical Implants Crate"
	cost = 2000
	contains = list(/obj/item/storage/box/chemimp)
	crate_name = "chemical implant crate"

/datum/supply_pack/security/armory/exileimp
	name = "Exile Implants Crate"
	cost = 3000
	contains = list(/obj/item/storage/box/exileimp)
	crate_name = "exile implant crate"

/datum/supply_pack/security/securitybarriers
	name = "Security Barriers Crate"
	contains = list(/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier,
					/obj/item/grenade/barrier)
	cost = 2000
	crate_name = "security barriers crate"

/datum/supply_pack/security/firingpins
	name = "Standard Firing Pins Crate"
	cost = 2000
	contains = list(/obj/item/storage/box/firingpins,
					/obj/item/storage/box/firingpins)
	crate_name = "firing pins crate"

/datum/supply_pack/security/securityclothes
	name = "Security Clothing Crate"
	cost = 3000
	chance_modifiers = list("Security" = 75, "Toys" = -5, "Clothing" = 50)
	cost_modifiers = list("Security", "Clothing")
	contains = list(/obj/item/clothing/under/rank/security/navyblue,
					/obj/item/clothing/under/rank/security/navyblue,
					/obj/item/clothing/suit/security/officer,
					/obj/item/clothing/suit/security/officer,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/head/beret/sec/navyofficer,
					/obj/item/clothing/under/rank/masteratarms/navyblue,
					/obj/item/clothing/suit/security/masteratarms,
					/obj/item/clothing/head/beret/sec/navymasteratarms,
					/obj/item/clothing/under/rank/head_of_security/navyblue,
					/obj/item/clothing/suit/security/hos,
					/obj/item/clothing/head/beret/sec/navyhos)
	crate_name = "security clothing crate"

/datum/supply_pack/security/armory/hardsuit
	name = "Security Hardsuit Crate"
	cost = 3000
	access = ACCESS_ARMORY
	contains = list(/obj/item/clothing/suit/space/hardsuit/security,
					/obj/item/clothing/suit/space/hardsuit/security,
					/obj/item/clothing/suit/space/hardsuit/security)
	crate_name = "Security Hardsuit Crate"
	crate_type = /obj/structure/closet/crate/secure


/datum/supply_pack/security/justiceinbound
	name = "Standard Justice Enforcer Crate"
	cost = 6000 //justice comes at a price. An expensive, noisy price.
	contraband = TRUE
	contains = list(/obj/item/clothing/head/helmet/justice,
					/obj/item/clothing/mask/gas/sechailer)
	crate_name = "security clothing crate"
	sensitivity = 0

//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Engineering /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/engineering
	group = "Engineering"
	crate_type = /obj/structure/closet/crate/engineering
	sensitivity = 1
	base_chance_to_spawn = 40
	chance_modifiers = list("Engineering" = 25)
	cost_modifiers = list("Engineering")

/datum/supply_pack/engineering/fueltank
	name = "Fuel Tank Crate"
	cost = 800
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	crate_name = "fuel tank crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/engineering/tools
	name = "Toolbox Crate"
	contains = list(/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/electrical,
					/obj/item/storage/toolbox/mechanical,
					/obj/item/storage/toolbox/mechanical)
	cost = 1000
	crate_name = "toolbox crate"

/datum/supply_pack/engineering/powergamermitts
	name = "Insulated Gloves Crate"
	cost = 2000	//Made of pure-grade bullshittinium
	contains = list(/obj/item/clothing/gloves/color/yellow,
					/obj/item/clothing/gloves/color/yellow,
					/obj/item/clothing/gloves/color/yellow)
	crate_name = "insulated gloves crate"

/datum/supply_pack/engineering/power
	name = "Powercell Crate"
	cost = 1000
	contains = list(/obj/item/stock_parts/cell/high,
					/obj/item/stock_parts/cell/high,
					/obj/item/stock_parts/cell/high)
	crate_name = "electrical maintenance crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/obj/item/stock_parts/cell/inducer_supply
	maxcharge = 5000
	charge = 5000

/datum/supply_pack/engineering/inducers
	name = "NT-75 Electromagnetic Power Inducers Crate"
	cost = 2000
	contains = list(/obj/item/inducer/sci {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0}, /obj/item/inducer/sci {cell_type = /obj/item/stock_parts/cell/inducer_supply; opened = 0}) //FALSE doesn't work in modified type paths apparently.
	crate_name = "inducer crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/engiequipment
	name = "Engineering Gear Crate"
	cost = 1300
	chance_modifiers = list( "Engineering" = 25, "Clothing" = 25)
	cost_modifiers = list("Engineering", "Clothing")
	contains = list(/obj/item/storage/belt/utility,
					/obj/item/storage/belt/utility,
					/obj/item/storage/belt/utility,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/suit/hazardvest,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/welding,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/head/hardhat,
					/obj/item/clothing/glasses/meson/engine,
					/obj/item/clothing/glasses/meson/engine)
	crate_name = "engineering gear crate"

/datum/supply_pack/engineering/engine/hardsuit
	name = "Engineering Hardsuit Crate"
	cost = 3000
	access = ACCESS_ENGINE
	contains = list(/obj/item/clothing/suit/space/hardsuit/engine,
					/obj/item/clothing/suit/space/hardsuit/engine,
					/obj/item/clothing/suit/space/hardsuit/engine)
	crate_name = "Hardsuit Crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/engineering/engine/mininghardsuit
	name = "Mining Hardsuit Crate"
	cost = 2800
	access = ACCESS_MINING
	chance_modifiers = list( "Clothing" = 25, "Cargo" = 25)
	cost_modifiers = list("Clothing", "Cargo")
	contains = list(/obj/item/clothing/suit/space/hardsuit/mining,
					/obj/item/clothing/suit/space/hardsuit/mining,
					/obj/item/clothing/suit/space/hardsuit/mining)
	crate_name = "Hardsuit Crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/engineering/colonization
	name = "G.E.C.K colonization kit"
	cost = 15000
	access = ACCESS_CE
	base_chance_to_spawn = 1
	chance_modifiers = list( "Engineering" = 25)
	cost_modifiers = null 	//No.
	contains= list(/obj/item/construction/rcd/combat,
			/obj/item/construction/rcd/combat,
			/obj/item/rcd_ammo/large,
			/obj/item/rcd_ammo/large,
			/obj/machinery/power/port_gen/pacman,
			/obj/item/stack/cable_coil,
			/obj/item/stack/cable_coil,
			/obj/item/stack/sheet/metal/fifty,
			/obj/item/stack/sheet/metal/fifty,
			/obj/item/stack/sheet/glass/fifty,
			/obj/item/stack/sheet/glass/fifty,
			/obj/item/stock_parts/cell/high,
			/obj/item/stock_parts/cell/high,
			/obj/item/electronics/apc,
			/obj/item/electronics/apc,
			/obj/item/electronics/airalarm,
			/obj/item/electronics/airalarm,
			/obj/item/stack/sheet/plasteel/fifty,
			/obj/item/stack/sheet/mineral/plasma,
			/obj/machinery/portable_atmospherics/canister/oxygen,
			/obj/item/pipe_dispenser,
			/obj/machinery/hydroponics/constructable,
			/obj/machinery/hydroponics/constructable,
			/obj/item/stack/tile/grass,
			/obj/item/stack/tile/pod,
			/obj/item/stack/tile/pod,
			/obj/item/storage/box/rndboards)
	crate_name = "advanced colonization crate"
	crate_type = /obj/structure/closet/crate/secure/engineering


/datum/supply_pack/engineering/shieldgen
	name = "Anti-breach Shield Projector Crate"
	cost = 2500
	chance_modifiers = list( "Engineering" = 25, "Emergency" = 25)
	cost_modifiers = list("Engineering")
	contains = list(/obj/machinery/shieldgen,
					/obj/machinery/shieldgen)
	crate_name = "anti-breach shield projector crate"

/datum/supply_pack/engineering/grounding_rods
	name = "Grounding Rod Crate"
	cost = 1700
	contains = list(/obj/machinery/power/grounding_rod,
					/obj/machinery/power/grounding_rod,
					/obj/machinery/power/grounding_rod,
					/obj/machinery/power/grounding_rod)
	crate_name = "grounding rod crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/pacman
	name = "P.A.C.M.A.N Generator Crate"
	cost = 2500
	contains = list(/obj/machinery/power/port_gen/pacman)
	crate_name = "PACMAN generator crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical

/datum/supply_pack/engineering/solar
	name = "Solar Panel Crate"
	cost = 2000
	contains  = list(/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/solar_assembly,
					/obj/item/circuitboard/computer/solar_control,
					/obj/item/electronics/tracker,
					/obj/item/paper/guides/jobs/engi/solars)
	crate_name = "solar panel crate"
	crate_type = /obj/structure/closet/crate/engineering/electrical
	sensitivity = 0 // The syndicate believes in clean, cheap sources of renewable energy.

/datum/supply_pack/engineering/engine
	name = "Emitter Crate"
	cost = 1500
	access = ACCESS_CE
	base_chance_to_spawn = 25
	contains = list(/obj/machinery/power/emitter,
					/obj/machinery/power/emitter)
	crate_name = "emitter crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	min_amount_to_stock = 1
	dangerous = TRUE

/datum/supply_pack/engineering/engine/field_gen
	name = "Field Generator Crate"
	cost = 1500
	contains = list(/obj/machinery/field/generator,
					/obj/machinery/field/generator)
	crate_name = "field generator crate"

/datum/supply_pack/engineering/engine/sing_gen
	name = "Singularity Generator Crate"
	cost = 5000
	contains = list(/obj/machinery/the_singularitygen)
	crate_name = "singularity generator crate"

/datum/supply_pack/engineering/engine/tesla_gen
	name = "Tesla Generator Crate"
	cost = 5000
	contains = list(/obj/machinery/the_singularitygen/tesla)
	crate_name = "tesla generator crate"

/datum/supply_pack/engineering/engine/collector
	name = "Collector Crate"
	cost = 2500
	contains = list(/obj/machinery/power/rad_collector,
					/obj/machinery/power/rad_collector,
					/obj/machinery/power/rad_collector)
	max_amount_to_stock = 5
	crate_name = "collector crate"

/datum/supply_pack/engineering/engine/PA
	name = "Particle Accelerator Crate"
	cost = 3000
	contains = list(/obj/structure/particle_accelerator/fuel_chamber,
					/obj/machinery/particle_accelerator/control_box,
					/obj/structure/particle_accelerator/particle_emitter/center,
					/obj/structure/particle_accelerator/particle_emitter/left,
					/obj/structure/particle_accelerator/particle_emitter/right,
					/obj/structure/particle_accelerator/power_box,
					/obj/structure/particle_accelerator/end_cap)
	crate_name = "particle accelerator crate"
	sensitivity = 2

/datum/supply_pack/engineering/engine/supermatter_shard
	name = "Supermatter Shard Crate"
	cost = 10000
	access = ACCESS_CE
	chance_modifiers = list( "Engineering" = 25, "Supermatter" = 25)
	cost_modifiers = list("Engineering")
	contains = list(/obj/machinery/power/supermatter_shard)
	crate_name = "supermatter shard crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE

/datum/supply_pack/engineering/engine/am_shielding
	name = "Antimatter Shielding Crate"
	cost = 2000
	contains = list(/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container,
					/obj/item/device/am_shielding_container)//10 shields: 3x3 containment and a core
	crate_name = "antimatter shielding crate"

/datum/supply_pack/engineering/engine/am_core
	name = "Antimatter Control Crate"
	cost = 5000
	contains = list(/obj/machinery/power/am_control_unit)
	crate_name = "antimatter control crate"

/datum/supply_pack/engineering/engine/am_jar
	name = "Antimatter Containment Jar Crate"
	cost = 2000
	contains = list(/obj/item/am_containment,
					/obj/item/am_containment)
	crate_name = "antimatter jar crate"

/datum/supply_pack/engineering/shuttle_engine
	name = "Shuttle Engine Crate"
	cost = 5000
	access = ACCESS_CE
	contains = list(/obj/structure/shuttle/engine/propulsion/burst/cargo)
	crate_name = "shuttle engine crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	special = TRUE

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Medical /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/medical
	group = "Medical"
	crate_type = /obj/structure/closet/crate/medical
	chance_modifiers = list( "Medical" = 25)
	cost_modifiers = list("Medical")

/datum/supply_pack/medical/supplies
	name = "Medical Supplies Crate"
	cost = 2000
	contains = list(/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/epinephrine,
					/obj/item/reagent_containers/glass/bottle/epinephrine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/beaker/large,
					/obj/item/reagent_containers/glass/beaker/large,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/stack/medical/gauze,
					/obj/item/storage/box/beakers,
					/obj/item/storage/box/syringes,
				    /obj/item/storage/box/bodybags)
	crate_name = "medical supplies crate"

/datum/supply_pack/medical/firstaid
	name = "First Aid Kit Crate"
	cost = 1000
	contains = list(/obj/item/storage/firstaid/regular,
					/obj/item/storage/firstaid/regular,
					/obj/item/storage/firstaid/regular,
					/obj/item/storage/firstaid/regular)
	crate_name = "first aid kit crate"

/datum/supply_pack/medical/firstaidbruises
	name = "Bruise Treatment Kit Crate"
	cost = 1000
	contains = list(/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/brute)
	crate_name = "brute treatment kit crate"

/datum/supply_pack/medical/firstaidburns
	name = "Burn Treatment Kit Crate"
	cost = 1000
	contains = list(/obj/item/storage/firstaid/fire,
					/obj/item/storage/firstaid/fire,
					/obj/item/storage/firstaid/fire)
	crate_name = "burn treatment kit crate"

/datum/supply_pack/medical/firstaidtoxins
	name = "Toxin Treatment Kit Crate"
	cost = 1000
	contains = list(/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/toxin)
	crate_name = "toxin treatment kit crate"

/datum/supply_pack/medical/firstaidoxygen
	name = "Oxygen Deprivation Kit Crate"
	cost = 1000
	contains = list(/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/o2)
	crate_name = "oxygen deprivation kit crate"

/datum/supply_pack/medical/virus
	name = "Virus Crate"
	cost = 2500
	access = ACCESS_CMO
	min_amount_to_stock = 1
	max_amount_to_stock = 3
	contains = list(/obj/item/reagent_containers/glass/bottle/flu_virion,
					/obj/item/reagent_containers/glass/bottle/cold,
					/obj/item/reagent_containers/glass/bottle/epiglottis_virion,
					/obj/item/reagent_containers/glass/bottle/liver_enhance_virion,
					/obj/item/reagent_containers/glass/bottle/fake_gbs,
					/obj/item/reagent_containers/glass/bottle/magnitis,
					/obj/item/reagent_containers/glass/bottle/pierrot_throat,
					/obj/item/reagent_containers/glass/bottle/brainrot,
					/obj/item/reagent_containers/glass/bottle/hullucigen_virion,
					/obj/item/reagent_containers/glass/bottle/anxiety,
					/obj/item/reagent_containers/glass/bottle/beesease,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/beakers,
					/obj/item/reagent_containers/glass/bottle/mutagen)
	crate_name = "virus crate"
	crate_type = /obj/structure/closet/crate/secure/plasma
	dangerous = TRUE
	sensitivity = 2

/datum/supply_pack/medical/bloodpacks
	name = "Blood Pack Variety Crate"
	cost = 3500
	contains = list(/obj/item/reagent_containers/blood/empty,
					/obj/item/reagent_containers/blood/empty,
					/obj/item/reagent_containers/blood/APlus,
					/obj/item/reagent_containers/blood/AMinus,
					/obj/item/reagent_containers/blood/BPlus,
					/obj/item/reagent_containers/blood/BMinus,
					/obj/item/reagent_containers/blood/OPlus,
					/obj/item/reagent_containers/blood/OMinus)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/medical/iv_drip
	name = "IV Drip Crate"
	cost = 1000
	contains = list(/obj/machinery/iv_drip)
	crate_name = "iv drip crate"

/datum/supply_pack/medical/defibs
	name = "Defibrillator Crate"
	cost = 2500
	contains = list(/obj/item/defibrillator/loaded,
					/obj/item/defibrillator/loaded)
	crate_name = "defibrillator crate"

/datum/supply_pack/medical/vending
	name = "Medical Vending Crate"
	cost = 2000
	contains = list(/obj/item/vending_refill/medical,
					/obj/item/vending_refill/medical,
					/obj/item/vending_refill/medical)
	crate_name = "medical vending crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Science /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/science
	group = "Science"
	crate_type = /obj/structure/closet/crate/science
	sensitivity = 2
	base_chance_to_spawn = 25
	chance_modifiers = list( "Science" = 30)
	cost_modifiers = list("Science")

/datum/supply_pack/science/robotics
	name = "Robotics Assembly Crate"
	cost = 1000
	access = ACCESS_ROBOTICS
	chance_modifiers = list( "Science" = 15, "Robotics" = 25)
	cost_modifiers = list("Science", "Robotics")
	contains = list(/obj/item/device/assembly/prox_sensor,
					/obj/item/device/assembly/prox_sensor,
					/obj/item/device/assembly/prox_sensor,
					/obj/item/storage/toolbox/electrical,
					/obj/item/storage/box/flashes,
					/obj/item/stock_parts/cell/high,
					/obj/item/stock_parts/cell/high)
	crate_name = "robotics assembly crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/robotics/mecha_ripley
	name = "Circuit Crate (Ripley APLU)"
	cost = 3000
	access = ACCESS_ROBOTICS
	contains = list(/obj/item/book/manual/ripley_build_and_repair,
					/obj/item/circuitboard/mecha/ripley/main,
					/obj/item/circuitboard/mecha/ripley/peripherals)
	crate_name = "\improper APLU Ripley circuit crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/robotics/mecha_odysseus
	name = "Circuit Crate (Odysseus)"
	cost = 2500
	access = ACCESS_ROBOTICS
	contains = list(/obj/item/circuitboard/mecha/odysseus/peripherals,
					/obj/item/circuitboard/mecha/odysseus/main)
	crate_name = "\improper Odysseus circuit crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/plasma
	name = "Plasma Assembly Crate"
	cost = 1000
	access = ACCESS_TOX_STORAGE
	contains = list(/obj/item/tank/internals/plasma,
					/obj/item/tank/internals/plasma,
					/obj/item/tank/internals/plasma,
					/obj/item/device/assembly/igniter,
					/obj/item/device/assembly/igniter,
					/obj/item/device/assembly/igniter,
					/obj/item/device/assembly/prox_sensor,
					/obj/item/device/assembly/prox_sensor,
					/obj/item/device/assembly/prox_sensor,
					/obj/item/device/assembly/timer,
					/obj/item/device/assembly/timer,
					/obj/item/device/assembly/timer)
	crate_name = "plasma assembly crate"
	crate_type = /obj/structure/closet/crate/secure/plasma

/datum/supply_pack/science/shieldwalls
	name = "Shield Generators"
	cost = 2000
	access = ACCESS_TELEPORTER
	contains = list(/obj/machinery/shieldwallgen,
					/obj/machinery/shieldwallgen,
					/obj/machinery/shieldwallgen,
					/obj/machinery/shieldwallgen)
	crate_name = "shield generators crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/transfer_valves
	name = "Tank Transfer Valves Crate"
	cost = 6000
	access = ACCESS_RD
	max_amount_to_stock = 2 //haha let's no let people get too many explosives
	contains = list(/obj/item/device/transfer_valve,
					/obj/item/device/transfer_valve)
	crate_name = "tank transfer valves crate"
	crate_type = /obj/structure/closet/crate/secure/science
	dangerous = TRUE

/datum/supply_pack/science/research
	name = "Machine Prototype Crate"
	cost = 8000
	access = ACCESS_RESEARCH
	contains = list(/obj/item/device/machineprototype)
	crate_name = "machine prototype crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/science/tablets
	name = "Tablet Crate"
	cost = 5000
	contains = list(/obj/item/device/modular_computer/tablet/preset/cargo,
					/obj/item/device/modular_computer/tablet/preset/cargo,
					/obj/item/device/modular_computer/tablet/preset/cargo,
					/obj/item/device/modular_computer/tablet/preset/cargo,
					/obj/item/device/modular_computer/tablet/preset/cargo)
	crate_name = "tablet crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Organic /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/organic
	group = "Food & Livestock"
	crate_type = /obj/structure/closet/crate/freezer
	chance_modifiers = list( "Food" = 15)
	cost_modifiers = list("Food")
	min_amount_to_stock = 3
	max_amount_to_stock = 20
/datum/supply_pack/organic/food
	name = "Food Crate"
	cost = 1000
	contains = list(/obj/item/reagent_containers/food/condiment/flour,
					/obj/item/reagent_containers/food/condiment/rice,
					/obj/item/reagent_containers/food/condiment/milk,
					/obj/item/reagent_containers/food/condiment/soymilk,
					/obj/item/reagent_containers/food/condiment/saltshaker,
					/obj/item/reagent_containers/food/condiment/peppermill,
					/obj/item/storage/fancy/egg_box,
					/obj/item/reagent_containers/food/condiment/enzyme,
					/obj/item/reagent_containers/food/condiment/sugar,
					/obj/item/reagent_containers/food/snacks/meat/slab/monkey,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana,
					/obj/item/reagent_containers/food/snacks/grown/banana)
	crate_name = "food crate"

/datum/supply_pack/organic/pizza
	name = "Pizza Delivery"
	cost = 6000 // Best prices this side of the galaxy.
	base_chance_to_spawn = 0
	min_amount_to_stock = -1 // made to order
	contains = list(/obj/item/pizzabox/margherita,
					/obj/item/pizzabox/mushroom,
					/obj/item/pizzabox/meat,
					/obj/item/pizzabox/vegetable)
	crate_name = "pizza crate"
	chance_modifiers = list("Pizza" = 100)
	cost_modifiers = list()		//Best prices, this side of the galaxy.

/datum/supply_pack/organic/cream_pie
	name = "High-yield Clown-grade Cream Pie Crate"
	cost = 6000
	contains = list(/obj/item/storage/backpack/duffelbag/clown/cream_pie)
	crate_name = "party equipment crate"
	contraband = TRUE
	access = ACCESS_THEATRE
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/organic/monkey
	name = "Monkey Crate"
	cost = 2000
	contains = list (/obj/item/storage/box/monkeycubes)
	crate_name = "monkey crate"

/datum/supply_pack/organic/party
	name = "Party Equipment"
	cost = 2000
	contains = list(/obj/item/storage/box/drinkingglasses,
					/obj/item/reagent_containers/food/drinks/shaker,
					/obj/item/reagent_containers/food/drinks/bottle/patron,
					/obj/item/reagent_containers/food/drinks/bottle/goldschlager,
					/obj/item/reagent_containers/food/drinks/ale,
					/obj/item/reagent_containers/food/drinks/ale,
					/obj/item/reagent_containers/food/drinks/beer,
					/obj/item/reagent_containers/food/drinks/beer,
					/obj/item/reagent_containers/food/drinks/beer,
					/obj/item/reagent_containers/food/drinks/beer,
					/obj/item/device/flashlight/glowstick,
					/obj/item/device/flashlight/glowstick/red,
					/obj/item/device/flashlight/glowstick/blue,
					/obj/item/device/flashlight/glowstick/cyan,
					/obj/item/device/flashlight/glowstick/orange,
					/obj/item/device/flashlight/glowstick/yellow,
					/obj/item/device/flashlight/glowstick/pink)
	crate_name = "party equipment crate"

/datum/supply_pack/organic/critter
	crate_type = /obj/structure/closet/crate/critter
	max_amount_to_stock = 5
	min_amount_to_stock = 0	//can generate without actual stock. Flavor!
	base_chance_to_spawn = 20
	chance_modifiers = list("Animals" = 50)
	cost_modifiers = list("Animals")

/datum/supply_pack/organic/critter/cow
	name = "Cow Crate"
	cost = 3000
	contains = list(/mob/living/simple_animal/cow)
	crate_name = "cow crate"

/datum/supply_pack/organic/critter/goat
	name = "Goat Crate"
	cost = 2500
	contains = list(/mob/living/simple_animal/hostile/retaliate/goat)
	crate_name = "goat crate"

/datum/supply_pack/organic/critter/chick
	name = "Chicken Crate"
	cost = 2000
	contains = list( /mob/living/simple_animal/chick)
	crate_name = "chicken crate"

/datum/supply_pack/organic/critter/corgi
	name = "Corgi Crate"
	cost = 5000
	base_chance_to_spawn = 10
	contains = list(/mob/living/simple_animal/pet/dog/corgi,
					/obj/item/clothing/neck/petcollar)
	crate_name = "corgi crate"

/datum/supply_pack/organic/critter/corgi/generate()
	. = ..()
	if(prob(50))
		var/mob/living/simple_animal/pet/dog/corgi/D = locate() in .
		qdel(D)
		new /mob/living/simple_animal/pet/dog/corgi/Lisa(.)

/datum/supply_pack/organic/critter/cat
	name = "Cat Crate"
	base_chance_to_spawn = 10
	cost = 5000 //Cats are worth as much as corgis.
	contains = list(/mob/living/simple_animal/pet/cat,
					/obj/item/clothing/neck/petcollar,
                    /obj/item/toy/cattoy)
	crate_name = "cat crate"

/datum/supply_pack/organic/critter/cat/generate()
	. = ..()
	if(prob(50))
		var/mob/living/simple_animal/pet/cat/C = locate() in .
		qdel(C)
		new /mob/living/simple_animal/pet/cat/Proc(.)

/datum/supply_pack/organic/critter/pug
	name = "Pug Crate"
	cost = 5000
	base_chance_to_spawn = 10
	contains = list(/mob/living/simple_animal/pet/dog/pug,
					/obj/item/clothing/neck/petcollar)
	crate_name = "pug crate"

/datum/supply_pack/organic/critter/fox
	name = "Fox Crate"
	cost = 5000
	base_chance_to_spawn = 10
	contains = list(/mob/living/simple_animal/pet/fox,
					/obj/item/clothing/neck/petcollar)
	crate_name = "fox crate"

/datum/supply_pack/organic/critter/butterfly
	name = "Butterflies Crate"
	contraband = TRUE
	cost = 5000
	contains = list(/mob/living/simple_animal/butterfly)
	crate_name = "entomology samples crate"

/datum/supply_pack/organic/critter/butterfly/generate()
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/simple_animal/butterfly(.)

/datum/supply_pack/organic/hydroponics
	name = "Hydroponics Crate"
	cost = 1500
	chance_modifiers = list("Hydroponics" = 25)
	cost_modifiers = list("Hydroponics")
	contains = list(/obj/item/reagent_containers/spray/plantbgone,
					/obj/item/reagent_containers/spray/plantbgone,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/reagent_containers/glass/bottle/ammonia,
					/obj/item/hatchet,
					/obj/item/cultivator,
					/obj/item/device/plant_analyzer,
					/obj/item/clothing/gloves/botanic_leather,
					/obj/item/clothing/suit/apron)
	crate_name = "hydroponics crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/hydrotank
	name = "Hydroponics Backpack Crate"
	cost = 1000
	access = ACCESS_HYDROPONICS
	contains = list(/obj/item/watertank)
	crate_name = "hydroponics backpack crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/organic/potted_plants
	name = "Potted Plants Crate"
	cost = 700
	contains = list(/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random,
					/obj/item/twohanded/required/kirbyplants/random)
	crate_name = "potted plants crate"
	crate_type = /obj/structure/closet/crate/hydroponics

/datum/supply_pack/organic/hydroponics/seeds
	name = "Seeds Crate"
	cost = 1000
	min_amount_to_stock = 5
	max_amount_to_stock = 25
	contains = list(/obj/item/seeds/chili,
					/obj/item/seeds/berry,
					/obj/item/seeds/corn,
					/obj/item/seeds/eggplant,
					/obj/item/seeds/tomato,
					/obj/item/seeds/soya,
					/obj/item/seeds/wheat,
					/obj/item/seeds/wheat/rice,
					/obj/item/seeds/carrot,
					/obj/item/seeds/sunflower,
					/obj/item/seeds/chanter,
					/obj/item/seeds/potato,
					/obj/item/seeds/sugarcane)
	crate_name = "seeds crate"

/datum/supply_pack/organic/hydroponics/exoticseeds
	name = "Exotic Seeds Crate"
	cost = 1500
	base_chance_to_spawn = 25
	min_amount_to_stock = 1
	max_amount_to_stock = 3
	contains = list(/obj/item/seeds/nettle,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/replicapod,
					/obj/item/seeds/plump,
					/obj/item/seeds/liberty,
					/obj/item/seeds/amanita,
					/obj/item/seeds/reishi,
					/obj/item/seeds/banana,
					/obj/item/seeds/eggplant/eggy,
					/obj/item/seeds/random,
					/obj/item/seeds/random)
	crate_name = "exotic seeds crate"

/datum/supply_pack/organic/hydroponics/beekeeping_fullkit
	name = "Beekeeping Starter Crate"
	cost = 1500
	base_chance_to_spawn = 30
	chance_modifiers = list("Hydroponics" = 25, "Clothing" = 5)
	cost_modifiers = list("Hydroponics", "Clothing")
	contains = list(/obj/structure/beebox,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/honey_frame,
					/obj/item/queen_bee/bought,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/melee/flyswatter)
	crate_name = "beekeeping starter crate"

/datum/supply_pack/organic/hydroponics/beekeeping_suits
	name = "Beekeeper Suit Crate"
	cost = 1000
	contains = list(/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit,
					/obj/item/clothing/head/beekeeper_head,
					/obj/item/clothing/suit/beekeeper_suit)
	crate_name = "beekeeper suits"

/datum/supply_pack/organic/vending
	name = "Bartending Supply Crate"
	cost = 2000
	chance_modifiers = list("Vending" = 25)
	cost_modifiers = list("Vending")
	contains = list(/obj/item/vending_refill/boozeomat,
					/obj/item/vending_refill/boozeomat,
					/obj/item/vending_refill/boozeomat,
					/obj/item/vending_refill/coffee,
					/obj/item/vending_refill/coffee,
					/obj/item/vending_refill/coffee)
	crate_name = "bartending supply crate"

/datum/supply_pack/organic/vending/snack
	name = "Snack Supply Crate"
	cost = 1500
	contains = list(/obj/item/vending_refill/snack,
					/obj/item/vending_refill/snack,
					/obj/item/vending_refill/snack)
	crate_name = "snacks supply crate"

/datum/supply_pack/organic/vending/cola
	name = "Softdrinks Supply Crate"
	cost = 1500
	contains = list(/obj/item/vending_refill/cola,
					/obj/item/vending_refill/cola,
					/obj/item/vending_refill/cola)
	crate_name = "soft drinks supply crate"

/datum/supply_pack/organic/vending/cigarette
	name = "Cigarette Supply Crate"
	cost = 1500
	contains = list(/obj/item/vending_refill/cigarette,
					/obj/item/vending_refill/cigarette,
					/obj/item/vending_refill/cigarette)
	crate_name = "cigarette supply crate"

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Materials ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/materials
	group = "Raw Materials"
	base_chance_to_spawn = 35
	chance_modifiers = list("Materials" = 25)
	cost_modifiers = list("Materials")

/datum/supply_pack/materials/metal50
	name = "50 Metal Sheets"
	cost = 1000
	contains = list(/obj/item/stack/sheet/metal/fifty)
	crate_name = "metal sheets crate"

/datum/supply_pack/materials/plasteel20
	name = "20 Plasteel Sheets"
	cost = 7500
	base_chance_to_spawn = 35
	contains = list(/obj/item/stack/sheet/plasteel/twenty)
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/plasteel50
	name = "50 Plasteel Sheets"
	base_chance_to_spawn = 25
	cost = 16500
	contains = list(/obj/item/stack/sheet/plasteel/fifty)
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/glass50
	name = "50 Glass Sheets"
	cost = 1000
	contains = list(/obj/item/stack/sheet/glass/fifty)
	crate_name = "glass sheets crate"

/datum/supply_pack/materials/wood50
	name = "50 Wood Planks"
	cost = 2000
	contains = list(/obj/item/stack/sheet/mineral/wood/fifty)
	crate_name = "wood planks crate"

/datum/supply_pack/materials/cardboard50
	name = "50 Cardboard Sheets"
	cost = 1000
	base_chance_to_spawn = 75
	contains = list(/obj/item/stack/sheet/cardboard/fifty)
	crate_name = "cardboard sheets crate"

/datum/supply_pack/materials/plastic50
	name = "50 Plastic Sheets"
	cost = 1000
	contains = list(/obj/item/stack/sheet/plastic/fifty)
	crate_name = "plastic sheets crate"

/datum/supply_pack/materials/sandstone30
	name = "30 Sandstone Blocks"
	cost = 1000
	base_chance_to_spawn = 75
	contains = list(/obj/item/stack/sheet/mineral/sandstone/thirty)
	crate_name = "sandstone blocks crate"

/datum/supply_pack/materials/diamond
	name = "diamond"
	cost = 2000
	base_chance_to_spawn = 80
	contains = list(/obj/item/stack/sheet/mineral/diamond)
	crate_name = "diamond crate"

//////////////////////////////////////////////////////////////////////////////
////////////////////////////// Munitions /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/munitions
	group = "Munitions"
	crate_name = "munitions crate"
	sensitivity = 2
	base_chance_to_spawn = 25
	chance_modifiers = list("Ammo" = 50)
	cost_modifiers = list("Ammo")

/datum/supply_pack/munitions/he
	name = "MAC Cannon Shell (High Explosive)"
	cost = 1000
	min_amount_to_stock = 5
	max_amount_to_stock = 25
	contains = list(/obj/structure/shell)
	access = ACCESS_MUNITIONS
	crate_type = /obj/structure/closet/crate/secure
	sensitivity = 1

/datum/supply_pack/munitions/sp
	name = "MAC Cannon Shell (Shield Piercing)"
	cost = 2000
	min_amount_to_stock = 1
	max_amount_to_stock = 5
	contains = list(/obj/structure/shell/shield_piercing)
	access = ACCESS_MUNITIONS
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/munitions/sh
	name = "MAC Cannon Shell (Smart Homing)"
	cost = 1500
	min_amount_to_stock = 3
	max_amount_to_stock = 15
	contains = list(/obj/structure/shell/smart_homing)
	access = ACCESS_MUNITIONS
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/munitions/ball
	name = "Cannon-Ball Bundle"
	cost = 1000
	access = ACCESS_MUNITIONS
	base_chance_to_spawn = 20
	chance_modifiers = list("Ammo" = 10, "Pirate" = 50)
	cost_modifiers = list("Ammo")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/structure/shell/cannon_ball,
					/obj/structure/shell/cannon_ball,
					/obj/structure/shell/cannon_ball,
					/obj/structure/shell/cannon_ball,
					/obj/structure/shell/cannon_ball,
					/obj/structure/shell/cannon_ball)

//////////////////////////////////////////////////////////////////////////////
////////////////////////////// Weapon chips //////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/weapon_chip
	name = "Burst Phase Cannon Chip"
	group = "Weapon Chips"
	cost = 4500
	access = ACCESS_CE
	crate_name = "Burst Phase Cannon Chip crate"
	base_chance_to_spawn = 50
	min_amount_to_stock = 1
	max_amount_to_stock = 2
	chance_modifiers = list("Weaponry" = 70)
	cost_modifiers = list("Weaponry")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/item/weapon_chip)

/datum/supply_pack/weapon_chip/basic
	name = "Basic Phase Cannon Chip"
	group = "Weapon Chips"
	cost = 2000
	access = ACCESS_CE
	crate_name = "Basic Phase Cannon Chip crate"
	base_chance_to_spawn = 70
	min_amount_to_stock = 1
	max_amount_to_stock = 4
	chance_modifiers = list("Weaponry" = 100)
	cost_modifiers = list("Weaponry")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/item/weapon_chip/laser_basic)

/datum/supply_pack/weapon_chip/focused
	name = "Focused Phase Cannon Chip"
	group = "Weapon Chips"
	cost = 6000
	access = ACCESS_CE
	crate_name = "Focused Phase Cannon Chip crate"
	base_chance_to_spawn = 40
	min_amount_to_stock = 1
	max_amount_to_stock = 1
	chance_modifiers = list("Weaponry" = 60)
	cost_modifiers = list("Weaponry")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/item/weapon_chip/laser_focused)

/datum/supply_pack/weapon_chip/heavy
	name = "Heavy Phase Cannon Chip"
	group = "Weapon Chips"
	cost = 6000
	access = ACCESS_CE
	crate_name = "Heavy Phase Cannon Chip crate"
	base_chance_to_spawn = 40
	min_amount_to_stock = 1
	max_amount_to_stock = 1
	chance_modifiers = list("Weaponry" = 60)
	cost_modifiers = list("Weaponry")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/item/weapon_chip/laser_heavy)

/datum/supply_pack/weapon_chip/gatling
	name = "Gatling Phase Cannon Chip"
	group = "Weapon Chips"
	cost = 10000
	access = ACCESS_CE
	crate_name = "Gatling Phase Cannon Chip crate"
	base_chance_to_spawn = 10
	min_amount_to_stock = 1
	max_amount_to_stock = 1
	chance_modifiers = list("Weaponry" = 40)
	cost_modifiers = list("Weaponry")
	crate_type = /obj/structure/closet/crate/secure
	contains = list(/obj/item/weapon_chip/laser_gatling)


//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Gas Canisters ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/gas
	group = "Gas Canisters"
	crate_name = "gas canister crate"
	base_chance_to_spawn = 20
	chance_modifiers = list("Atmos" = 50)
	cost_modifiers = list("Atmos", "Engineering")
	min_amount_to_stock = 1
	max_amount_to_stock = 5

/datum/supply_pack/gas/o2
	name = "O2 Canister"
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen)

/datum/supply_pack/gas/n2
	name = "N2 Canister"
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrogen)

/datum/supply_pack/gas/air
	name = "Air Canister"
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/air)
	min_amount_to_stock = 5
	max_amount_to_stock = 25

/datum/supply_pack/gas/water_vapor
	name = "Water Vapor"
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/water_vapor)

/datum/supply_pack/gas/plasma
	name = "Plasma Canister"
	cost = 3000
	chance_modifiers = list("Atmos" = 25, "Science" = 25)
	cost_modifiers = list("Atmos", "Science")
	contains = list(/obj/machinery/portable_atmospherics/canister/toxins)
	sensitivity = 1
	crate_type = /obj/structure/closet/crate/secure
	access = ACCESS_ENGINE

/datum/supply_pack/gas/co2
	name = "CO2 Canister"
	cost = 5000
	contains = list(/obj/machinery/portable_atmospherics/canister/carbon_dioxide)
	sensitivity = 1
	crate_type = /obj/structure/closet/crate/secure
	access = ACCESS_ATMOSPHERICS

/datum/supply_pack/gas/n2o
	name = "N2O Canister"
	cost = 2000
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrous_oxide)
	sensitivity = 2
	crate_type = /obj/structure/closet/crate/secure
	access = ACCESS_ATMOSPHERICS

/datum/supply_pack/gas/hydrogen
	name = "Hydrogen Canister"
	cost = 3000
	contains = list(/obj/machinery/portable_atmospherics/canister/hydrogen)
	sensitivity = 1
	crate_type = /obj/structure/closet/crate/secure
	access = ACCESS_ENGINE

//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Miscellaneous ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/misc
	group = "Miscellaneous Supplies"

/datum/supply_pack/misc/minerkit
	name = "Shaft Miner Starter Kit"
	cost = 2500
	chance_modifiers = list("Cargo" = 25)
	cost_modifiers = list("Cargo")
	access = ACCESS_QM
	contains = list(/obj/item/pickaxe/mini,
			/obj/item/clothing/glasses/meson,
			/obj/item/device/t_scanner/adv_mining_scanner/lesser,
			/obj/item/device/radio/headset/headset_cargo/mining,
			/obj/item/storage/bag/ore,
			/obj/item/clothing/suit/hooded/explorer,
			/obj/item/clothing/mask/gas/explorer)
	crate_name = "shaft miner starter kit"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/mule
	name = "MULEbot Crate"
	cost = 2000
	chance_modifiers = list("Cargo" = 25)
	cost_modifiers = list("Cargo")
	contains = list(/mob/living/simple_animal/bot/mulebot)
	crate_name = "\improper MULEbot Crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/misc/trekuniforms
	name = "Outdated Uniforms"
	cost = 750
	chance_modifiers = list("Clothing" = 75)	//please god fuck get these off our hands we'll do anything to get rid of them
	contains = list(/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/captrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/greytrek)
	crate_name= "Surplus Uniforms"

/datum/supply_pack/misc/conveyor
	name = "Conveyor Assembly Crate"
	cost = 1500
	chance_modifiers = list("Cargo" = 25)
	cost_modifiers = list("Cargo")
	contains = list(/obj/item/conveyor_construct,
					/obj/item/conveyor_construct,
					/obj/item/conveyor_construct,
					/obj/item/conveyor_construct,
					/obj/item/conveyor_construct,
					/obj/item/conveyor_construct,
					/obj/item/conveyor_switch_construct,
					/obj/item/paper/guides/conveyor)
	crate_name = "conveyor assembly crate"

/datum/supply_pack/misc/watertank
	name = "Water Tank Crate"
	cost = 600
	chance_modifiers = list("Emergency" = 20, "Hydroponics" = 30)
	contains = list(/obj/structure/reagent_dispensers/watertank)
	crate_name = "water tank crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/misc/hightank
	name = "High-Capacity Water Tank Crate"
	cost = 1200
	chance_modifiers = list("Emergency" = 10, "Hydroponics" = 20)
	contains = list(/obj/structure/reagent_dispensers/watertank/high)
	crate_name = "high-capacity water tank crate"
	crate_type = /obj/structure/closet/crate/large


/datum/supply_pack/misc/lasertag
	name = "Laser Tag Crate"
	cost = 1500
	base_chance_to_spawn = 5
	chance_modifiers = list("Toys" = 70)
	cost_modifiers = list("Toys")
	contains = list(/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/redtag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/gun/energy/laser/bluetag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/redtag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/suit/bluetag,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/redtaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm,
					/obj/item/clothing/head/helmet/bluetaghelm)
	crate_name = "laser tag crate"

/datum/supply_pack/misc/lasertag/pins
	name = "Laser Tag Firing Pins Crate"
	cost = 3000
	contraband = TRUE
	contains = list(/obj/item/storage/box/lasertagpins)
	crate_name = "laser tag crate"

/datum/supply_pack/misc/clownpin
	name = "Hilarious Firing Pin Crate"
	cost = 5000
	contraband = TRUE
	contains = list(/obj/item/device/firing_pin/clown)
	// It's /technically/ a toy. For the clown, at least.
	crate_name = "toy crate"

/datum/supply_pack/misc/religious_supplies
	name = "Religious Supplies Crate"
	cost = 4000	// it costs so much because the Space Church is ran by Space Jews  :thonking:
	contains = list(/obj/item/reagent_containers/food/drinks/bottle/holywater,
					/obj/item/reagent_containers/food/drinks/bottle/holywater,
					/obj/item/storage/book/bible/booze,
					/obj/item/storage/book/bible/booze,
					/obj/item/clothing/suit/hooded/chaplain_hoodie,
					/obj/item/clothing/suit/hooded/chaplain_hoodie,
					/obj/item/clothing/under/burial,
					/obj/item/clothing/under/burial)
	crate_name = "religious supplies crate"

/datum/supply_pack/misc/book_crate
	name = "Book Crate"
	cost = 1500
	contains = list(/obj/item/book/codex_gigas,
					/obj/item/book/manual/random/,
					/obj/item/book/manual/random/,
					/obj/item/book/manual/random/,
					/obj/item/book/random/triple)

/datum/supply_pack/misc/paper
	name = "Bureaucracy Crate"
	cost = 1500
	contains = list(/obj/structure/filingcabinet/chestdrawer/wheeled,
					/obj/item/device/camera_film,
					/obj/item/hand_labeler,
					/obj/item/hand_labeler_refill,
					/obj/item/hand_labeler_refill,
					/obj/item/paper_bin,
					/obj/item/pen/fourcolor,
					/obj/item/pen/fourcolor,
					/obj/item/pen,
					/obj/item/pen/fountain,
					/obj/item/pen/blue,
					/obj/item/pen/red,
					/obj/item/folder/blue,
					/obj/item/folder/red,
					/obj/item/folder/yellow,
					/obj/item/clipboard,
					/obj/item/clipboard,
					/obj/item/stamp,
					/obj/item/stamp/denied)
	crate_name = "bureaucracy crate"

/datum/supply_pack/misc/fountainpens
	name = "Calligraphy Crate"
	cost = 700
	contains = list(/obj/item/storage/box/fountainpens)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/toner
	name = "Toner Crate"
	cost = 1000
	contains = list(/obj/item/device/toner,
					/obj/item/device/toner,
					/obj/item/device/toner,
					/obj/item/device/toner,
					/obj/item/device/toner,
					/obj/item/device/toner)
	crate_name = "toner crate"

/datum/supply_pack/misc/janitor
	name = "Janitorial Supplies Crate"
	cost = 1000
	contains = list(/obj/item/reagent_containers/glass/bucket,
					/obj/item/reagent_containers/glass/bucket,
					/obj/item/reagent_containers/glass/bucket,
					/obj/item/mop,
					/obj/item/caution,
					/obj/item/caution,
					/obj/item/caution,
					/obj/item/storage/bag/trash,
					/obj/item/reagent_containers/spray/cleaner,
					/obj/item/reagent_containers/glass/rag,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner,
					/obj/item/grenade/chem_grenade/cleaner)
	crate_name = "janitorial supplies crate"

/datum/supply_pack/misc/janitor/janicart
	name = "Janitorial Cart and Galoshes Crate"
	cost = 2000
	contains = list(/obj/structure/janitorialcart,
					/obj/item/clothing/shoes/galoshes)
	crate_name = "janitorial cart crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/misc/janitor/janitank
	name = "Janitor Backpack Crate"
	cost = 1000
	access = ACCESS_JANITOR
	contains = list(/obj/item/watertank/janitor)
	crate_name = "janitor backpack crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/janitor/lightbulbs
	name = "Replacement Lights"
	cost = 1000
	contains = list(/obj/item/storage/box/lights/mixed,
					/obj/item/storage/box/lights/mixed,
					/obj/item/storage/box/lights/mixed)
	crate_name = "replacement lights"

/datum/supply_pack/misc/noslipfloor
	name = "High-traction Floor Tiles"
	cost = 2000
	contains = list(/obj/item/stack/tile/noslip/thirty)
	crate_name = "high-traction floor tiles crate"

/datum/supply_pack/misc/plasmaman
	name = "Plasmaman Supply Kit"
	cost = 2000
	chance_modifiers = list("Atmos" = 25, "Clothing" = 25)
	cost_modifiers = list("Clothing")
	contains = list(/obj/item/clothing/under/plasmaman,
					/obj/item/clothing/under/plasmaman,
					/obj/item/tank/internals/plasmaman/belt/full,
					/obj/item/tank/internals/plasmaman/belt/full,
					/obj/item/clothing/head/helmet/space/plasmaman,
					/obj/item/clothing/head/helmet/space/plasmaman)
	crate_name = "plasmaman supply kit"

/datum/supply_pack/misc/costume
	name = "Standard Costume Crate"
	cost = 1000
	chance_modifiers = list("Clothing" = 25)
	access = ACCESS_THEATRE
	contains = list(/obj/item/storage/backpack/clown,
					/obj/item/clothing/shoes/clown_shoes,
					/obj/item/clothing/mask/gas/clown_hat,
					/obj/item/clothing/under/rank/clown,
					/obj/item/bikehorn,
					/obj/item/clothing/under/rank/mime,
					/obj/item/clothing/shoes/sneakers/black,
					/obj/item/clothing/gloves/color/white,
					/obj/item/clothing/mask/gas/mime,
					/obj/item/clothing/head/beret,
					/obj/item/clothing/suit/suspenders,
					/obj/item/reagent_containers/food/drinks/bottle/bottleofnothing,
					/obj/item/storage/backpack/mime)
	crate_name = "standard costume crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/costume_original
	name = "Original Costume Crate"
	cost = 1000
	chance_modifiers = list("Clothing" = 25)
	contains = list(/obj/item/clothing/head/snowman,
					/obj/item/clothing/suit/snowman,
					/obj/item/clothing/head/chicken,
					/obj/item/clothing/suit/chickensuit,
					/obj/item/clothing/mask/gas/monkeymask,
					/obj/item/clothing/suit/monkeysuit,
					/obj/item/clothing/head/cardborg,
					/obj/item/clothing/suit/cardborg,
					/obj/item/clothing/head/xenos,
					/obj/item/clothing/suit/xenos,
					/obj/item/clothing/suit/hooded/ian_costume,
					/obj/item/clothing/suit/hooded/carp_costume,
					/obj/item/clothing/suit/hooded/bee_costume)
	crate_name = "original costume crate"

/datum/supply_pack/misc/wizard
	name = "Wizard Costume Crate"
	cost = 2000
	chance_modifiers = list("Clothing" = 25)
	contains = list(/obj/item/staff,
					/obj/item/clothing/suit/wizrobe/fake,
					/obj/item/clothing/shoes/sandal,
					/obj/item/clothing/head/wizard/fake)
	crate_name = "wizard costume crate"

/datum/supply_pack/misc/randomised
	name = "Collectable Hats Crate!"
	cost = 20000
	var/num_contained = 3 //number of items picked to be contained in a randomised crate
	base_chance_to_spawn = 10
	chance_modifiers = list("Toys" = 50, "Nanotrasen" = 25)
	cost_modifiers = list("Toys", "Nanotrasen")
	///obj/item/clothing/head/collectable/XO,// Broken type path, removed for now

	contains = list(/obj/item/clothing/head/collectable/chef,
					/obj/item/clothing/head/collectable/paper,
					/obj/item/clothing/head/collectable/tophat,
					/obj/item/clothing/head/collectable/captain,
					/obj/item/clothing/head/collectable/beret,
					/obj/item/clothing/head/collectable/welding,
					/obj/item/clothing/head/collectable/flatcap,
					/obj/item/clothing/head/collectable/pirate,
					/obj/item/clothing/head/collectable/kitty,
					/obj/item/clothing/head/collectable/rabbitears,
					/obj/item/clothing/head/collectable/wizard,
					/obj/item/clothing/head/collectable/hardhat,
					/obj/item/clothing/head/collectable/HoS,
					/obj/item/clothing/head/collectable/XO,
					/obj/item/clothing/head/collectable/thunderdome,
					/obj/item/clothing/head/collectable/swat,
					/obj/item/clothing/head/collectable/slime,
					/obj/item/clothing/head/collectable/police,
					/obj/item/clothing/head/collectable/slime,
					/obj/item/clothing/head/collectable/xenom,
					/obj/item/clothing/head/collectable/petehat)
	crate_name = "collectable hats crate"

/datum/supply_pack/misc/randomised/fill(obj/structure/closet/crate/C)
	var/list/L = contains.Copy()
	for(var/i in 1 to num_contained)
		var/item = pick_n_take(L)
		new item(C)

/datum/supply_pack/misc/bigband
	contains = list(/obj/item/device/instrument/violin,
					/obj/item/device/instrument/guitar,
					/obj/item/device/instrument/glockenspiel,
					/obj/item/device/instrument/accordion,
					/obj/item/device/instrument/saxophone,
					/obj/item/device/instrument/trombone,
					/obj/item/device/instrument/recorder,
					/obj/item/device/instrument/harmonica,
					/obj/structure/piano)
	name = "Big band instrument collection"
	cost = 5000
	crate_name = "Big band musical instruments collection"

/datum/supply_pack/misc/randomised/contraband
	name = "Contraband Crate"
	contraband = TRUE
	cost = 3000
	num_contained = 5
	contains = list(/obj/item/poster/random_contraband,
					/obj/item/storage/fancy/cigarettes/cigpack_shadyjims,
					/obj/item/storage/fancy/cigarettes/cigpack_midori,
					/obj/item/seeds/ambrosia/deus,
					/obj/item/clothing/neck/necklace/dope)
	crate_name = "crate"

/datum/supply_pack/misc/randomised/toys
	name = "Toy Crate"
	cost = 5000 // or play the arcade machines ya lazy bum
	// TODO make this actually just use the arcade machine loot list
	num_contained = 5
	contains = list(/obj/item/toy/spinningtoy,
	                /obj/item/toy/sword,
	                /obj/item/toy/foamblade,
	                /obj/item/toy/talking/AI,
	                /obj/item/toy/talking/owl,
	                /obj/item/toy/talking/griffin,
	                /obj/item/toy/nuke,
	                /obj/item/toy/minimeteor,
	                /obj/item/toy/carpplushie,
	                /obj/item/coin/antagtoken,
	                /obj/item/stack/tile/fakespace/loaded,
	                /obj/item/gun/ballistic/shotgun/toy/crossbow,
	                /obj/item/toy/redbutton,
					/obj/item/toy/redbutton/blue,
					/obj/item/toy/eightball)
	crate_name = "toy crate"

/datum/supply_pack/misc/trekuniforms
	name = "Outdated Uniforms"
	cost = 1000
	chance_modifiers = list("Clothing" = 25)
	contains = list(/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/captrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/hostrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/greytrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/comttrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/medtrek,
					/obj/item/clothing/under/trek/greytrek)
	crate_name= "Surplus Uniforms"



/datum/supply_pack/misc/autodrobe
	name = "Autodrobe Supply Crate"
	cost = 1500
	contains = list(/obj/item/vending_refill/autodrobe,
					/obj/item/vending_refill/autodrobe)
	crate_name = "autodrobe supply crate"

/datum/supply_pack/misc/formalwear
	name = "Formalwear Crate"
	chance_modifiers = list("Clothing" = 25)
	cost = 3000 //Lots of very expensive items. You gotta pay up to look good!
	contains = list(/obj/item/clothing/under/blacktango,
					/obj/item/clothing/under/assistantformal,
					/obj/item/clothing/under/assistantformal,
					/obj/item/clothing/under/lawyer/bluesuit,
					/obj/item/clothing/suit/toggle/lawyer,
					/obj/item/clothing/under/lawyer/purpsuit,
					/obj/item/clothing/suit/toggle/lawyer/purple,
					/obj/item/clothing/under/lawyer/blacksuit,
					/obj/item/clothing/suit/toggle/lawyer/black,
					/obj/item/clothing/accessory/waistcoat,
					/obj/item/clothing/neck/tie/blue,
					/obj/item/clothing/neck/tie/red,
					/obj/item/clothing/neck/tie/black,
					/obj/item/clothing/head/bowler,
					/obj/item/clothing/head/fedora,
					/obj/item/clothing/head/flatcap,
					/obj/item/clothing/head/beret,
					/obj/item/clothing/head/that,
					/obj/item/clothing/shoes/laceup,
					/obj/item/clothing/shoes/laceup,
					/obj/item/clothing/shoes/laceup,
					/obj/item/clothing/under/suit_jacket/charcoal,
					/obj/item/clothing/under/suit_jacket/navy,
					/obj/item/clothing/under/suit_jacket/burgundy,
					/obj/item/clothing/under/suit_jacket/checkered,
					/obj/item/clothing/under/suit_jacket/tan,
					/obj/item/lipstick/random)
	crate_name = "formalwear crate"

/datum/supply_pack/misc/foamforce
	name = "Foam Force Crate"
	cost = 1000
	base_chance_to_spawn = 25
	chance_modifiers = list("Toys" = 50)
	cost_modifiers = list("Toys")
	contains = list(/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy,
					/obj/item/gun/ballistic/shotgun/toy)
	crate_name = "foam force crate"

/datum/supply_pack/misc/foamforce/bonus
	name = "Foam Force Pistols Crate"
	contraband = TRUE
	cost = 4000
	chance_modifiers = list("Toys" = 25)
	contains = list(/obj/item/gun/ballistic/automatic/toy/pistol,
					/obj/item/gun/ballistic/automatic/toy/pistol,
					/obj/item/ammo_box/magazine/toy/pistol,
					/obj/item/ammo_box/magazine/toy/pistol)
	crate_name = "foam force crate"

/datum/supply_pack/misc/artsupply
	name = "Art Supplies"
	cost = 800
	contains = list(/obj/structure/easel,
					/obj/structure/easel,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/toy/crayon/rainbow,
					/obj/item/toy/crayon/rainbow)
	crate_name = "art supply crate"

/datum/supply_pack/misc/bsa
	name = "Bluespace Artillery Parts"
	cost = 15000
	special = TRUE
	base_chance_to_spawn = 0
	contains = list(/obj/item/circuitboard/machine/bsa/front,
					/obj/item/circuitboard/machine/bsa/middle,
					/obj/item/circuitboard/machine/bsa/back,
					/obj/item/circuitboard/computer/bsa_control
					)
	crate_name= "bluespace artillery parts crate"

/datum/supply_pack/misc/dna_vault
	name = "DNA Vault Parts"
	cost = 12000
	special = TRUE
	base_chance_to_spawn = 0
	contains = list(
					/obj/item/circuitboard/machine/dna_vault,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe
					)
	crate_name= "dna vault parts crate"

/datum/supply_pack/misc/dna_probes
	name = "DNA Vault Samplers"
	cost = 3000
	special = TRUE
	base_chance_to_spawn = 0
	contains = list(/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe,
					/obj/item/device/dna_probe
					)
	crate_name= "dna samplers crate"


/datum/supply_pack/misc/shield_sat
	name = "Shield Generator Satellite"
	cost = 3000
	special = TRUE
	base_chance_to_spawn = 0
	contains = list(
					/obj/machinery/satellite/meteor_shield,
					/obj/machinery/satellite/meteor_shield,
					/obj/machinery/satellite/meteor_shield
					)
	crate_name= "shield sat crate"


/datum/supply_pack/misc/shield_sat_control
	name = "Shield System Control Board"
	cost = 5000
	special = TRUE
	base_chance_to_spawn = 0
	contains = list(
					/obj/item/circuitboard/machine/computer/sat_control
					)
	crate_name= "shield control board crate"

/datum/supply_pack/misc/bicycle
	name = "Bicycle"
	cost = 1000000
	chance_modifiers = list("Toys" = 50)	// no, we're not giving discounts on bicycles.
	contains = list(/obj/vehicle/bicycle)
	crate_name = "Bicycle Crate"
	crate_type = /obj/structure/closet/crate/large
	crate_name= "art supply crate"

/datum/supply_pack/misc/space_yellow_pages
	name = "Space Yellow Pages"
	cost = 800
	base_chance_to_spawn = 100
	min_amount_to_stock = -1
	contains = list(/obj/item/book/space_catalog)
	crate_name = "space catalog crate"
/*
/datum/supply_pack/misc/civilian
	name = "Civilian Cryocrew"
	cost = 600
	contains = list(/obj/effect/mob_spawn/human/purchasable/civilian)
	crate_name = "Cryo-crate"

/datum/supply_pack/misc/engineer
	name = "Engineer Cryocrew"
	cost = 1200
	contains = list(/obj/effect/mob_spawn/human/purchasable/engineer)
	crate_name = "Cryo-crate"

/datum/supply_pack/misc/secofficer
	name = "Security Cryocrew"
	cost = 2000
	contains = list(/obj/effect/mob_spawn/human/purchasable/security)
	crate_name = "Cryo-crate"

/datum/supply_pack/misc/doctor
	name = "Medical Cryocrew"
	cost = 900
	contains = list(/obj/effect/mob_spawn/human/purchasable/medical)
	crate_name = "Cryo-crate"
*/
/datum/supply_pack/delivery_mission
	group = "Mission Items"
	cost = 0 // Free
	sensitivity = 0
	var/datum/objective/ftl/delivery/objective
	min_amount_to_stock = 1

/datum/supply_pack/delivery_mission/fill(obj/structure/closet/crate/C)
	..()
	for(var/obj/O in C)
		objective.delivery_item = O
	objective.has_purchased_item = 1
