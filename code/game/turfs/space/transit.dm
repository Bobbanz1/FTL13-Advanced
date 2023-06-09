/turf/open/space/transit
	icon_state = "mapping_speedspace"
	dir = SOUTH
	baseturf = /turf/open/space/transit
	no_shuttle_move = 1
	flags_1 = NOJAUNT_1 //This line goes out to every wizard that ever managed to escape the den. I'm sorry.
	var/noop = 0

/turf/open/space/transit/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	. = ..()
	underlay_appearance.icon_state = "speedspace_ns_[get_transit_state(asking_turf)]"
	underlay_appearance.transform = turn(matrix(), get_transit_angle(asking_turf))

/turf/open/space/transit/south
	dir = SOUTH

/turf/open/space/transit/north
	dir = NORTH

/turf/open/space/transit/horizontal
	dir = WEST
	baseturf = /turf/open/space/transit/horizontal

/turf/open/space/transit/horizontal/reverse
	dir = EAST
	baseturf = /turf/open/space/transit/horizontal/reverse

/turf/open/space/transit/noop
	noop = 1
	baseturf = /turf/open/space/transit/noop

/turf/open/space/transit/horizontal/noop
	noop = 1
	baseturf = /turf/open/space/transit/horizontal/noop

/turf/open/space/transit/west
	dir = WEST

/turf/open/space/transit/east
	dir = EAST

/turf/open/space/transit/Entered(atom/movable/AM, atom/OldLoc)
	throw_atom(AM)

/turf/open/space/transit/proc/throw_atom(atom/movable/AM)
	set waitfor = FALSE
	if(noop || !AM || istype(AM, /obj/docking_port))
		return
	if(AM.loc != src) //Multi-tile objects are "in" multiple locs but its loc is it's true placement.
		return
	if(locate(/obj/structure/lattice) in contents) //you can stand on lattice
		return

	var/max = world.maxx-TRANSITIONEDGE
	var/min = 1+TRANSITIONEDGE

	var/list/possible_transtitons = list()
	var/k = 1
	var/list/config_list = SSmapping.config.transition_config
	for(var/a in config_list)
		if(config_list[a] == CROSSLINKED) // Only pick z-levels connected to station space
			possible_transtitons += k
		k++
	if(possible_transtitons.len == 0)
		possible_transtitons += 1
	var/_z = pick(possible_transtitons)

	//now select coordinates for a border turf
	var/_x
	var/_y
	switch(dir)
		if(SOUTH)
			_x = rand(min,max)
			_y = max
		if(WEST)
			_x = max
			_y = rand(min,max)
		if(EAST)
			_x = min
			_y = rand(min,max)
		else
			_x = rand(min,max)
			_y = min

	var/turf/T = locate(_x, _y, _z)
	AM.forceMove(T)

/turf/open/space/transit/CanBuildHere()
	return SSshuttle.is_in_shuttle_bounds(src)


/turf/open/space/transit/Initialize()
	..()
	update_icon()
	for(var/atom/movable/AM in src)
		throw_atom(AM)

/turf/open/space/transit/proc/update_icon()
	icon_state = "speedspace_ns_[get_transit_state(src)]"
	transform = turn(matrix(), get_transit_angle(src))

/proc/get_transit_state(turf/T)
	var/p = 9
	. = 1
	switch(T.dir)
		if(NORTH)
			. = ((-p*T.x+T.y) % 15) + 1
			if(. < 1)
				. += 15
		if(EAST)
			. = ((T.x+p*T.y) % 15) + 1
		if(WEST)
			. = ((T.x-p*T.y) % 15) + 1
			if(. < 1)
				. += 15
		else
			. = ((p*T.x+T.y) % 15) + 1

/proc/get_transit_angle(turf/T)
	. = 0
	switch(T.dir)
		if(NORTH)
			. = 180
		if(EAST)
			. = 90
		if(WEST)
			. = -90
