/obj/item/pod_parts
	parent_type = /obj/item/mecha_parts
	icon = 'goon/icons/pods/pod_parts.dmi'

/obj/item/pod_parts/core
	name="Space Pod Core"
	icon_state = "core"
	flags_1 = CONDUCT_1
	origin_tech = "programming=2;materials=3;bluespace=2;engineering=3"

/obj/item/pod_parts/pod_frame
	name = "Space Pod Frame"
	icon_state = ""
	flags_1 = CONDUCT_1
	density = 0
	anchored = 0
	var/link_to = null
	var/link_angle = 0

/obj/item/pod_parts/pod_frame/proc/find_square()
	/*
	each part, in essence, stores the relative position of another part
	you can find where this part should be by looking at the current direction of the current part and applying the link_angle
	the link_angle is the angle between the part's direction and its following part, which is the current part's link_to
	the code works by going in a loop - each part is capable of starting a loop by checking for the part after it, and that part checking, and so on
	this 4-part loop, starting from any part of the frame, can determine if all the parts are properly in place and aligned
	it also checks that each part is unique, and that all the parts are there for the spacepod itself
	*/
	var/neededparts = list(/obj/item/pod_parts/pod_frame/aft_port, /obj/item/pod_parts/pod_frame/aft_starboard, /obj/item/pod_parts/pod_frame/fore_port, /obj/item/pod_parts/pod_frame/fore_starboard)
	var/turf/T
	var/obj/item/pod_parts/pod_frame/linked
	var/obj/item/pod_parts/pod_frame/pointer
	var/connectedparts =  list()
	neededparts -= src
	//log_admin("Starting with [src]")
	linked = src
	for(var/i = 1; i <= 4; i++)
		T = get_turf(get_step(linked, turn(linked.dir, -linked.link_angle))) //get the next place that we want to look at
		if(locate(linked.link_to) in T)
			pointer = locate(linked.link_to) in T
			//log_admin("Looking at [pointer.type]")
		if(istype(pointer, linked.link_to) && pointer.dir == linked.dir && pointer.anchored)
			if(!(pointer in connectedparts))
				connectedparts += pointer
			linked = pointer
			pointer = null
	//log_admin("Parts left: [neededparts.len]") //len not working
	for(var/i = 1; i <=4; i++)
		var/obj/item/pod_parts/pod_frame/F = connectedparts[i]
		if(F.type in neededparts) //if one of the items can be founded in neededparts
			neededparts -= F.type
			log_admin("Found [F.type]")
		else //because neededparts has 4 distinct items, this must be called if theyre not all in place and wrenched
			return 0
	return connectedparts

/obj/item/pod_parts/pod_frame/attackby(var/obj/O, mob/user)
	if(istype(O, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = O
		var/list/linkedparts = find_square()
		if(!linkedparts)
			to_chat(user, "<span class='rose'>You cannot assemble a pod frame because you do not have the necessary assembly.</span>")
			return
		var/obj/structure/spacepod_frame/pod = new /obj/structure/spacepod_frame(src.loc)
		pod.dir = src.dir
		to_chat(user, "<span class='notice'>You strut the pod frame together.</span>")
		R.use(10)
		for(var/obj/item/pod_parts/pod_frame/F in linkedparts)
			if(1 == turn(F.dir, -F.link_angle)) //if the part links north during construction, as the bottom left part always does
				//log_admin("Repositioning")
				pod.loc = F.loc
			qdel(F)
		playsound(get_turf(src), 'sound/items/ratchet.ogg', 50, 1)
	if(istype(O, /obj/item/wrench))
		to_chat(user, "<span class='notice'>You [!anchored ? "secure \the [src] in place."  : "remove the securing bolts."]</span>")
		anchored = !anchored
		density = anchored
		playsound(get_turf(src), 'sound/items/ratchet.ogg', 50, 1)

/obj/item/pod_parts/pod_frame/verb/rotate()
	set name = "Rotate Frame"
	set category = "Object"
	set src in oview(1)
	if(anchored)
		to_chat(usr, "\The [src] is securely bolted!")
		return 0
	src.dir = turn(src.dir, -90)
	return 1

/obj/item/pod_parts/pod_frame/attack_hand()
	src.rotate()

/obj/item/pod_parts/pod_frame/fore_port
	name = "fore port pod frame"
	icon_state = "pod_fp"
	desc = "A space pod frame component. This is the fore port component."
	link_to = /obj/item/pod_parts/pod_frame/fore_starboard
	link_angle = 90

/obj/item/pod_parts/pod_frame/fore_starboard
	name = "fore starboard pod frame"
	icon_state = "pod_fs"
	desc = "A space pod frame component. This is the fore starboard component."
	link_to = /obj/item/pod_parts/pod_frame/aft_starboard
	link_angle = 180

/obj/item/pod_parts/pod_frame/aft_port
	name = "aft port pod frame"
	icon_state = "pod_ap"
	desc = "A space pod frame component. This is the aft port component."
	link_to = /obj/item/pod_parts/pod_frame/fore_port
	link_angle = 0

/obj/item/pod_parts/pod_frame/aft_starboard
	name = "aft starboard pod frame"
	icon_state = "pod_as"
	desc = "A space pod frame component. This is the aft starboard component."
	link_to = /obj/item/pod_parts/pod_frame/aft_port
	link_angle = 270

/obj/item/pod_parts/armor
	name = "civilian pod armor"
	icon = 'goon/icons/pods/pod_parts.dmi'
	icon_state = "pod_armor_civ"
	desc = "Spacepod armor. This is the civilian version. It looks rather flimsy."
	var/armor_max_health = 240
	var/armor_health = 240
	var/pod_desc = "A sleek civilian space pod."
	var/pod_icon_state = "pod_civ"

/obj/item/pod_parts/armor/mining
	name = "mining pod armor"
	icon_state = "pod_armor_mining"
	desc = "Mining spacepod armor. Design for use in mining conditions."
	armor_max_health = 290
	armor_health = 290
	pod_desc = "A spacepod designed for mining."
	pod_icon_state = "pod_mining"

/obj/item/pod_parts/armor/security
	name = "security pod armor"
	icon_state = "pod_armor_mil"
	desc = "Security spacepod armor. Designed for space combat"
	armor_max_health = 390
	armor_health = 390
	pod_desc = "An armed security spacepod with reinforced armor plating."
	pod_icon_state = "pod_mil"

/obj/item/pod_parts/armor/black
	name = "black pod armor"
	icon_state = "pod_armor_black"
	desc = "Spacepod armor. It is black, and has no identifications."
	pod_desc = "An all black space pod with no insignias."
	pod_icon_state = "pod_black"

/obj/item/pod_parts/armor/synd
	name = "syndicate pod armor"
	icon_state = "pod_armor_synd"
	desc = "Spacepod armor used by syndicate spacepods."
	armor_max_health = 340
	armor_health = 340
	pod_desc = "A menacing military space pod with \"Fuck NT\" stenciled onto the side."
	pod_icon_state = "pod_synd"

/obj/item/pod_parts/armor/gold
	name = "gold pod armor"
	icon_state = "pod_armor_gold"
	desc = "Spacepod armor made out of gold. It looks extremely weak"
	armor_max_health = 90
	armor_health = 90
	pod_desc = "A civilian space pod with a gold body, must have cost somebody a pretty penny"
	pod_icon_state = "pod_gold"

/obj/item/pod_parts/armor/industrial
	name = "industrial pod armor"
	icon_state = "pod_armor_industrial"
	desc = "Spacepod armor, meant for industrial spacepods"
	armor_max_health = 290
	armor_health = 290
	pod_desc = "A rough looking space pod meant for industrial work"
	pod_icon_state = "pod_industrial"