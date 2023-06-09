/datum/uplink_item/defender
  boarding_mode = TRUE
  surplus = 1

/datum/uplink_item/defender/weapon
  category = "Firearms"

/datum/uplink_item/defender/weapon/machinegun
	name = "L6 Automatic Weapon"
	desc = "A fully-loaded Aussec Armoury belt-fed machine gun. \
			This deadly weapon has a massive 50-round magazine of devastating 1.95x129mm ammunition."
	item = /obj/item/gun/ballistic/automatic/l6_saw/unrestricted
	cost = 25

/datum/uplink_item/defender/weapon/uzi
  name = "9mm SMG"
  desc = "Lightweitght, burst-fire submachine gun."
  cost = 10
  item = /obj/item/gun/ballistic/automatic/mini_uzi

/datum/uplink_item/defender/weapon/pistol
  name = "Nagant revolver"
  desc = "Ancient belgium revolver, uses 7.62x38mmR ammo."
  item = /obj/item/gun/ballistic/revolver/nagant
  cost = 6

/datum/uplink_item/defender/weapon/revolver
  name = "9mm Pistol"
  desc = "A small, easily concealable handgun that uses 10mm auto rounds in 8-round magazines and is compatible \
      with suppressors."
  item = /obj/item/gun/ballistic/automatic/pistol
  cost = 4

/datum/uplink_item/defender/weapon/bolt_action
  name = "Bolt-action Rifle"
  desc = "A horribly outdated bolt action weapon. You've got to be desperate to use this."
  item = /obj/item/gun/ballistic/shotgun/boltaction
  cost = 2

/datum/uplink_item/defender/weapon/emp
  name = "EMP Grenades and Implanter Kit"
  desc = "A box that contains two EMP grenades and an EMP implant. Useful to disrupt communication, \
      security's energy weapons, and silicon lifeforms when you're in a tight spot."
  item = /obj/item/storage/box/syndie_kit/emp
  cost = 4

/datum/uplink_item/defender/main
	category = "Defence Gear"

/datum/uplink_item/defender/main/sandbag
  name = "Sandbags"
  desc = "Ten bags of sand. Useful for building barriers."
  cost = 2
  item = /obj/item/stack/sheet/mineral/sandbags/ten

/datum/uplink_item/defender/main/barrier_grenade
  name = "Barrier grenade"
  desc = "Grenade inflates security barrier providing good cover.\
        Different inflating modes included!"
  cost = 1
  item = /obj/item/grenade/barrier

/datum/uplink_item/defender/main/at_field
  name = "Anti-Grenade field generator"
  desc = "Disables incoming grenades in a range of 7 tiles.\
    Wrench to floor to make it work."
  cost = 4
  item = /obj/machinery/at_field

/datum/uplink_item/defender/main/shield
  name = "Energy Shield"
  desc = "An incredibly useful personal shield projector, capable of reflecting energy projectiles and defending \
  			against other attacks. Pair with an Energy Sword for a killer combination."
  item = /obj/item/shield/energy
  cost = 8

/datum/uplink_item/defender/main/cutouts //Literally the best item fight me
	name = "Adaptive Cardboard Cutouts"
	desc = "These cardboard cutouts are coated with a thin material that prevents discoloration and makes the images on them appear more lifelike. This pack contains three as well as a \
	crayon for changing their appearances."
	item = /obj/item/storage/box/syndie_kit/cutouts
	cost = 1

// Defence Stuff (Special Offers)
/datum/uplink_item/defender/traps
	category = "Trapping Gear"

/datum/uplink_item/defender/traps/door_charge
	name = "Explosive Airlock Charge"
	desc = "A small, easily concealable device. It can be applied to an open airlock panel, booby-trapping it. \
			The next person to use that airlock will trigger an explosion, knocking them down and destroying \
			the airlock maintenance panel."
	item = /obj/item/device/doorCharge
	cost = 6

/datum/uplink_item/defender/traps/landmine
  name = "Military-grade landmine"
  desc = "Explosive type mine. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 4
  item = /obj/item/mine/explosive

/datum/uplink_item/defender/traps/stunmine
  name = "Stun mine"
  desc = "Very effective stun mechanism. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 2
  item = /obj/item/mine/stun

// /datum/uplink_item/defender/traps/n2o //sleep effects are broke my dude
//   name = "Sleep mine"
//   desc = "360 moles of N2O. Click the button to activate.
//    Triggers on step. No IFF system included."
//   cost = 2
//   item = /obj/item/mine/gas/n2o

/datum/uplink_item/defender/traps/spawn_carp
  name = "Carp mine"
  desc = "Spawns 3 carps on trigger. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 4
  item = /obj/item/mine/spawner/carp

/datum/uplink_item/defender/traps/spawn_soap
  name = "Soap mine"
  desc = "Filled with military-grade soap. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 2
  item = /obj/item/mine/spawner/soap

/datum/uplink_item/defender/traps/spawn_banana
  name = "Banana mine"
  desc = "Filled with military-grade banana peels. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 2
  item = /obj/item/mine/spawner/banana

/datum/uplink_item/defender/traps/sound
  name = "HONKmine"
  desc = "Useful for sound signal. Click the button to activate.\
   Triggers on step. No IFF system included."
  cost = 1
  item = /obj/item/mine/sound

/datum/uplink_item/defender/traps/beartrap
  name = "Box of Beartraps"
  desc = "Cheap and cruel solution for building defence \
   against carbon creatures. Comes with 6 beartraps."
  cost = 2
  item = /obj/item/storage/box/beartraps

/datum/uplink_item/defender/ammo
  category = "Ammunition"

/datum/uplink_item/defender/ammo/stechkin
  name = "10mm Handgun Magazine"
  desc = "An additional 8-round 10mm magazine; compatible with the Stechkin Pistol. These subsonic rounds \
      are dirt cheap but are half as effective as .357 rounds."
  item = /obj/item/ammo_box/magazine/m10mm
  cost = 1

/datum/uplink_item/defender/ammo/bolt_action
  name = "Surplus Rifle Clip"
  desc = "A stripper clip used to quickly load bolt action rifles. Contains 5 rounds."
  item = 	/obj/item/ammo_box/a762
  cost = 1

/datum/uplink_item/defender/ammo/revolver
  name = "7.62x38mmR ammo box"
  desc = "A box contains 14 additional 7.62x38mmR rounds; usable with the Nagant revolver. \
      For when you really need a self-defence."
  item = /obj/item/ammo_box/n762
  cost = 2

/datum/uplink_item/defender/ammo/uzi
  name = "9mm SMG Magazine"
  desc = "An additional 32-round 9mm magazine sutable for use with the Uzi submachine gun."
  item = /obj/item/ammo_box/magazine/uzim9mm
  cost = 2

//Survival stuff
/datum/uplink_item/defender/emergency
  category = "Emergency and Special Gear"

/datum/uplink_item/defender/emergency/thermal
  name = "Thermal Imaging Glasses"
  desc = "These goggles can be turned to resemble common eyewears throughout the station. \
      They allow you to see organisms through walls by capturing the upper portion of the infrared light spectrum, \
      emitted as heat and light by objects. Hotter objects, such as warm bodies, cybernetic organisms \
      and artificial intelligence cores emit more of this light than cooler objects like walls and airlocks."
  item = /obj/item/clothing/glasses/thermal/syndi
  cost = 4

/datum/uplink_item/defender/emergency/toolbox
  name = "Full Syndicate Toolbox"
  desc = "The syndicate toolbox is a suspicious black and red. It comes loaded with a full tool set including a \
      multitool and combat gloves that are resistant to shocks and heat."
  item = /obj/item/storage/toolbox/syndicate
  cost = 1

/datum/uplink_item/defender/emergency/magboots
  name = "Blood-Red Magboots"
  desc = "A pair of magnetic boots with a Syndicate paintjob that assist with freer movement in space or on-station \
      during gravitational generator failures. These reverse-engineered knockoffs of Nanotrasen's \
      'Advanced Magboots' slow you down in simulated-gravity environments much like the standard issue variety."
  item = /obj/item/clothing/shoes/magboots/syndie
  cost = 4

/datum/uplink_item/defender/emergency/space_suit
  name = "Syndicate Space Suit"
  desc = "This red and black syndicate space suit is less encumbering than Nanotrasen variants, \
      fits inside bags, and has a weapon slot. Nanotrasen crewmembers are trained to report red space suit \
      sightings, however."
  item = /obj/item/storage/box/syndie_kit/space
  cost = 2

/datum/uplink_item/defender/medical
  category = "Medical Gear"

/datum/uplink_item/defender/medical/surgerybag
  name = "Syndicate Surgery duffelbag"
  desc = "The Syndicate surgery duffelbag is a toolkit containing all surgery tools, surgical drapes, \
      a Syndicate brand MMI, a straitjacket, and a muzzle."
  item = /obj/item/storage/backpack/duffelbag/syndie/surgery
  cost = 2

/datum/uplink_item/defender/medical/medkit
  name = "Syndicate Combat Medic Kit"
  desc = "This first aid kit is a suspicious brown and red. Included is a combat stimulant injector \
      for rapid healing, a medical HUD for quick identification of injured personnel, \
      and other supplies helpful for a field medic."
  item = /obj/item/storage/firstaid/tactical
  cost = 4

/datum/uplink_item/defender/medical/stimpack
  name = "Stimpack"
  desc = "Stimpacks, the tool of many great heroes, make you nearly immune to stuns and knockdowns for about \
      5 minutes after injection."
  item = /obj/item/reagent_containers/syringe/stimulants
  cost = 8
