/*
	CONTENTS
	LINE 10  - BASE MOB
	LINE 43  - SWORD AND SHIELD
	LINE 95  - GUNS
	LINE 136 - MISC
*/


///////////////Base mob////////////

/mob/living/simple_animal/hostile/syndicate
	name = "Syndicate Operative"
	desc = "Death to Nanotrasen."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "syndicate"
	icon_living = "syndicate"
	icon_dead = "syndicate_dead"
	icon_gib = "syndicate_gib"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	stat_attack = 1
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/syndicatesoldier)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("syndicate")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1

///////////////Sword and shield////////////

/mob/living/simple_animal/hostile/syndicate/melee
	melee_damage_lower = 25
	melee_damage_upper = 30
	icon_state = "syndicatemelee"
	icon_living = "syndicatemelee"
	loot = list(/obj/effect/gibspawner/human)
	attacktext = "slashes"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 28
	status_flags = 0
	maxHealth = 170
	health = 170

/mob/living/simple_animal/hostile/syndicate/melee/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(prob(50))
		return ..()
	else
		visible_message("<span class='danger'>[src] blocks [Proj] with its shield!</span>")
		return 0


/mob/living/simple_animal/hostile/syndicate/melee/space
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	icon_state = "syndicatemeleespace"
	icon_living = "syndicatemeleespace"
	name = "Syndicate Commando"
	loot = list(/obj/effect/gibspawner/human)
	speed = 1

/mob/living/simple_animal/hostile/syndicate/melee/space/Process_Spacemove(movement_dir = 0)
	return 1

/mob/living/simple_animal/hostile/syndicate/melee/space/stormtrooper
	icon_state = "syndicatemeleestormtrooper"
	icon_living = "syndicatemeleestormtrooper"
	name = "Syndicate Stormtrooper"
	maxHealth = 340
	health = 340
	loot = list(/obj/effect/mob_spawn/human/corpse/syndicatestormtrooper,
				/obj/item/melee/transforming/energy/sword/saber/red,
				/obj/item/shield/energy)

///////////////Guns////////////

/mob/living/simple_animal/hostile/syndicate/ranged
	ranged = 1
	rapid = 1
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "syndicateranged"
	icon_living = "syndicateranged"
	casingtype = /obj/item/ammo_casing/c45nostamina
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	loot = list(/obj/effect/gibspawner/human)

/mob/living/simple_animal/hostile/syndicate/ranged/space
	icon_state = "syndicaterangedspace"
	icon_living = "syndicaterangedspace"
	name = "Syndicate Commando"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speed = 1
	loot = list(/obj/effect/gibspawner/human)

/mob/living/simple_animal/hostile/syndicate/ranged/space/Process_Spacemove(movement_dir = 0)
	return 1

/mob/living/simple_animal/hostile/syndicate/ranged/space/stormtrooper
	icon_state = "syndicaterangedstormtrooper"
	icon_living = "syndicaterangedstormtrooper"
	name = "Syndicate Stormtrooper"
	maxHealth = 200
	health = 200
	projectilesound = 'sound/weapons/gunshot.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = list(/obj/effect/mob_spawn/human/corpse/syndicatestormtrooper,
				/obj/item/gun/ballistic/automatic/shotgun/bulldog/unrestricted,
				/obj/item/shield/energy)

///////////////Misc////////////

/mob/living/simple_animal/hostile/syndicate/civilian
	name = "Syndicate civilian"
	desc = "An unarmed civilian. Doesn't seem to eager to meet you"
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	var/list/upgrade_options = list(/mob/living/simple_animal/hostile/syndicate = 10, /mob/living/simple_animal/hostile/syndicate/melee = 20, /mob/living/simple_animal/hostile/syndicate/ranged = 15,\
	/mob/living/simple_animal/hostile/syndicate/melee/space = 15, /mob/living/simple_animal/hostile/syndicate/ranged/space = 15,\
	/mob/living/simple_animal/hostile/syndicate/ranged/space/stormtrooper = 2, /mob/living/simple_animal/hostile/syndicate/melee/space/stormtrooper = 2,\
	/mob/living/simple_animal/hostile/syndicate/mecha_pilot = 1) //I can't wait for the inevitable 10 mech roll

/mob/living/simple_animal/hostile/syndicate/civilian/Aggro()
	..()
	summon_backup(15)
	say("GUARDS!!")

/mob/living/simple_animal/hostile/syndicate/civilian/proc/arm_for_balance()
	var/mob/living/simple_animal/hostile/syndicate/S = pickweight(upgrade_options) //Pick a better unit and qdel the civ
	new S(loc)
	qdel(src)

/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASSTABLE
	health = 25
	maxHealth = 25
	melee_damage_lower = 15
	melee_damage_upper = 15
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	attacktext = "cuts"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = list("syndicate")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	mob_size = MOB_SIZE_TINY
	movement_type = FLYING
	limb_destroyer = 1
	speak_emote = list("states")
	bubble_icon = "syndibot"
	gold_core_spawnable = 1
	del_on_death = 1
	deathmessage = "is smashed into pieces!"
