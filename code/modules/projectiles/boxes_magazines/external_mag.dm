


///////////EXTERNAL MAGAZINES////////////////

/obj/item/ammo_box/magazine/m10mm
	name = "pistol magazine (10mm)"
	desc = "A gun magazine."
	icon_state = "9x19p"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m10mm/rifle
	name = "rifle magazine (10mm)"
	desc = "A well-worn magazine fitted for the surplus rifle."
	icon_state = "75-8"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	if(ammo_count())
		icon_state = "75-8"
	else
		icon_state = "75-0"


/obj/item/ammo_box/magazine/m10mm/fire
	name = "pistol magazine (10mm incendiary)"
	icon_state = "9x19pI"
	desc = "A gun magazine. Loaded with rounds which ignite the target."
	ammo_type = /obj/item/ammo_casing/c10mm/fire

/obj/item/ammo_box/magazine/m10mm/hp
	name = "pistol magazine (10mm HP)"
	icon_state = "9x19pH"
	desc= "A gun magazine. Loaded with hollow-point rounds, extremely effective against unarmored targets, but nearly useless against protective clothing."
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	name = "pistol magazine (10mm AP)"
	icon_state = "9x19pA"
	desc= "A gun magazine. Loaded with rounds which penetrate armour, but are less effective against normal targets"
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/m45
	name = "handgun magazine (.45)"
	icon_state = "45-8"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/m45/update_icon()
	..()
	icon_state = "45-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/wt550m9
	name = "wt550 magazine (4.6x30mm)"
	icon_state = "46x30mmt-20"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 20

/obj/item/ammo_box/magazine/wt550m9/update_icon()
	..()
	icon_state = "46x30mmt-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "wt550 magazine (Armour Piercing 4.6x30mm)"
	icon_state = "46x30mmtA-20"
	ammo_type = /obj/item/ammo_casing/c46x30mmap

/obj/item/ammo_box/magazine/wt550m9/wtap/update_icon()
	..()
	icon_state = "46x30mmtA-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/wt550m9/wttx
	name = "wt550 magazine (Toxin Tipped 4.6x30mm)"
	icon_state = "46x30mmtT-20"
	ammo_type = /obj/item/ammo_casing/c46x30mmtox

/obj/item/ammo_box/magazine/wt550m9/wttx/update_icon()
	..()
	icon_state = "46x30mmtT-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "wt550 magazine (Incindiary 4.6x30mm)"
	icon_state = "46x30mmtI-20"
	ammo_type = /obj/item/ammo_casing/c46x30mminc

/obj/item/ammo_box/magazine/wt550m9/wtic/update_icon()
	..()
	icon_state = "46x30mmtI-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/uzim9mm
	name = "uzi magazine (9mm)"
	icon_state = "uzi9mm-32"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 32

/obj/item/ammo_box/magazine/uzim9mm/update_icon()
	..()
	icon_state = "uzi9mm-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/xmg80/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/36, 1)*36]"

/obj/item/ammo_box/magazine/ak922
	name = "AK-922 magazine (7.62x39)"
	icon_state = "akmag"
	origin_tech = "combat=3"
	ammo_type = /obj/item/ammo_casing/a762x39
	caliber = "7.62x39"
	max_ammo = 30

/obj/item/ammo_box/magazine/ak922/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/aks74
	name = "AKS-740u Magazine (5.45x39mm)"
	icon_state = "aks74"
	origin_tech = "combat=4"
	ammo_type = /obj/item/ammo_casing/a545
	caliber = "a545"
	max_ammo = 30

/obj/item/ammo_box/magazine/aks74/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/30, 1)*30]"

/obj/item/ammo_box/magazine/luger
	name = "P057A Luger Magazine (.357)"
	icon_state = "luger"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = ".357"
	max_ammo = 10

/obj/item/ammo_box/magazine/luger/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/c05r
	name = "C05-R magazine (.45 ACP)"
	icon_state = "c05r"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 12

/obj/item/ammo_box/magazine/c05r/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/12, 1)*12]"

/obj/item/ammo_box/magazine/m44
	name = "handgun magazine (.44 AMP)"
	icon_state = "44"
	ammo_type = /obj/item/ammo_casing/c44
	caliber = ".44"
	max_ammo = 7

/obj/item/ammo_box/magazine/m44/update_icon()	//Shamelessly copied M1911 magazine sprites
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/7, 1)*7]"

/obj/item/ammo_box/magazine/smgm9mm
	name = "SMG magazine (9mm)"
	icon_state = "smg9mm-42"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 21

/obj/item/ammo_box/magazine/smgm9mm/update_icon()
	..()
	icon_state = "smg9mm-[ammo_count() ? "42" : "0"]"

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "SMG magazine (Armour Piercing 9mm)"
	ammo_type = /obj/item/ammo_casing/c9mmap

/obj/item/ammo_box/magazine/smgm9mm/toxin
	name = "SMG magazine (Toxin Tipped 9mm)"
	ammo_type = /obj/item/ammo_casing/c9mmtox

/obj/item/ammo_box/magazine/smgm9mm/fire
	name = "SMG Magazine (Incindiary 9mm)"
	ammo_type = /obj/item/ammo_casing/c9mminc

/obj/item/ammo_box/magazine/pistolm9mm
	name = "pistol magazine (9mm)"
	icon_state = "9x19p-8"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 15

/obj/item/ammo_box/magazine/pistolm9mm/update_icon()
	..()
	icon_state = "9x19p-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/smgm45
	name = "SMG magazine (.45)"
	icon_state = "c20r45-24"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/c45nostamina
	caliber = ".45"
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm45/update_icon()
	..()
	icon_state = "c20r45-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/tommygunm45
	name = "drum magazine (.45)"
	icon_state = "drum45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 50

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50ae)"
	icon_state = "50ae"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/a50
	caliber = ".50"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_box/magazine/m75
	name = "specialized magazine (.75)"
	icon_state = "75"
	ammo_type = /obj/item/ammo_casing/caseless/a75
	caliber = "75"
	multiple_sprites = 2
	max_ammo = 8

/obj/item/ammo_box/magazine/m556
	name = "toploader magazine (5.56mm)"
	icon_state = "5.56m"
	origin_tech = "combat=5;syndicate=1"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30
	multiple_sprites = 2

/obj/item/ammo_box/magazine/carbine
	name = "carbine magazine (4.6x30mm)"
	icon_state = "oldrifle"
	origin_tech = "combat=5"
	ammo_type = /obj/item/ammo_casing/c46carbine
	caliber = "4.6x30mm"
	max_ammo = 32

/obj/item/ammo_box/magazine/m12g
	name = "shotgun magazine (12g taser slugs)"
	desc = "A drum magazine."
	icon_state = "m12gs"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug
	origin_tech = "combat=3;syndicate=1"
	caliber = "shotgun"
	max_ammo = 8

/obj/item/ammo_box/magazine/m12g/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(0)/8, 1)*8]"

/obj/item/ammo_box/magazine/m12g/buckshot
	name = "shotgun magazine (12g buckshot slugs)"
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/magazine/m12g/slug
	name = "shotgun magazine (12g slugs)"
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g/dragon
	name = "shotgun magazine (12g dragon's breath)"
	icon_state = "m12gf"
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary/dragonsbreath

/obj/item/ammo_box/magazine/m12g/bioterror
	name = "shotgun magazine (12g bioterror)"
	icon_state = "m12gt"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g/breach
	name = "shotgun magazine (12g breacher slugs)"
	icon_state = "m12gbc"
	ammo_type = /obj/item/ammo_casing/shotgun/breaching


//// SNIPER MAGAZINES

/obj/item/ammo_box/magazine/sniper_rounds
	name = "sniper rounds (.50)"
	icon_state = ".50mag"
	origin_tech = "combat=6;syndicate=2"
	ammo_type = /obj/item/ammo_casing/point50
	max_ammo = 6
	caliber = ".50"

/obj/item/ammo_box/magazine/sniper_rounds/update_icon()
	if(ammo_count())
		icon_state = "[initial(icon_state)]-ammo"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/ammo_box/magazine/sniper_rounds/soporific
	name = "sniper rounds (Zzzzz)"
	desc = "Soporific sniper rounds, designed for happy days and dead quiet nights..."
	icon_state = "soporific"
	origin_tech = "combat=6;syndicate=3"
	ammo_type = /obj/item/ammo_casing/soporific
	max_ammo = 3
	caliber = ".50"

/obj/item/ammo_box/magazine/sniper_rounds/haemorrhage
	name = "sniper rounds (Bleed)"
	desc = "Haemorrhage sniper rounds, leaves your target in a pool of crimson pain"
	icon_state = "haemorrhage"
	ammo_type = /obj/item/ammo_casing/haemorrhage
	max_ammo = 5
	caliber = ".50"

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "sniper rounds (penetrator)"
	desc = "An extremely powerful round capable of passing straight through cover and anyone unfortunate enough to be behind it."
	ammo_type = /obj/item/ammo_casing/penetrator
	origin_tech = "combat=6;syndicate=3"
	max_ammo = 5

/obj/item/ammo_box/magazine/sniper_rounds/gang
	name = "black market sniper rounds (.50)"
	icon_state = ".50mag"
	origin_tech = "combat=6"
	ammo_type = /obj/item/ammo_casing/point50/gang

/obj/item/ammo_box/magazine/sniper_rounds/gang/sleeper
	name = "illegally modified tranquilizer round"
	icon_state = "soporific"
	origin_tech = "combat=6"
	ammo_type = /obj/item/ammo_casing/point50/gang/sleeper

//// SAW MAGAZINES

/obj/item/ammo_box/magazine/mm195x129
	name = "box magazine (1.95x129mm)"
	icon_state = "a762-50"
	origin_tech = "combat=2"
	ammo_type = /obj/item/ammo_casing/mm195x129
	caliber = "mm195129"
	max_ammo = 50

/obj/item/ammo_box/magazine/mm195x129/bleeding
	name = "box magazine (Bleeding 1.95x129mm)"
	origin_tech = "combat=3"
	ammo_type = /obj/item/ammo_casing/mm195x129/bleeding

/obj/item/ammo_box/magazine/mm195x129/hollow
	name = "box magazine (Hollow-Point 1.95x129mm)"
	origin_tech = "combat=3"
	ammo_type = /obj/item/ammo_casing/mm195x129/hollow

/obj/item/ammo_box/magazine/mm195x129/ap
	name = "box magazine (Armor Penetrating 1.95x129mm)"
	origin_tech = "combat=4"
	ammo_type = /obj/item/ammo_casing/mm195x129/ap

/obj/item/ammo_box/magazine/mm195x129/incen
	name = "box magazine (Incendiary 1.95x129mm)"
	origin_tech = "combat=4"
	ammo_type = /obj/item/ammo_casing/mm195x129/incen

/obj/item/ammo_box/magazine/mm195x129/update_icon()
	..()
	icon_state = "a762-[round(ammo_count()*50/max_ammo,10)]"




////TOY GUN MAGAZINES

/obj/item/ammo_box/magazine/toy
	name = "foam force META magazine"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	caliber = "foam_force"

/obj/item/ammo_box/magazine/toy/smg
	name = "foam force SMG magazine"
	icon_state = "smg9mm-42"
	max_ammo = 20

/obj/item/ammo_box/magazine/toy/smg/update_icon()
	..()
	if(ammo_count())
		icon_state = "smg9mm-42"
	else
		icon_state = "smg9mm-0"

/obj/item/ammo_box/magazine/toy/smg/riot
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/ammo_box/magazine/toy/pistol
	name = "foam force pistol magazine"
	icon_state = "9x19p"
	max_ammo = 8
	multiple_sprites = 2

/obj/item/ammo_box/magazine/toy/pistol/riot
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/ammo_box/magazine/toy/smgm45
	name = "donksoft SMG magazine"
	caliber = "foam_force"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	max_ammo = 20

/obj/item/ammo_box/magazine/toy/smgm45/update_icon()
	..()
	icon_state = "c20r45-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/toy/m762
	name = "donksoft box magazine"
	caliber = "foam_force"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	max_ammo = 50

/obj/item/ammo_box/magazine/toy/m762/update_icon()
	..()
	icon_state = "a762-[round(ammo_count(),10)]"




//// RECHARGEABLE MAGAZINES

/obj/item/ammo_box/magazine/recharge
 	name = "power pack"
 	desc = "A rechargeable, detachable battery that serves as a magazine for laser rifles."
 	icon_state = "oldrifle-20"
 	ammo_type = /obj/item/ammo_casing/caseless/laser
 	caliber = "laser"
 	max_ammo = 20

/obj/item/ammo_box/magazine/recharge/update_icon()
	desc = "[initial(desc)] It has [stored_ammo.len] shot\s left."
	icon_state = "oldrifle-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/recharge/attack_self() //No popping out the "bullets"
 	return
