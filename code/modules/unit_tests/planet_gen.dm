/datum/unit_test/planet_gen/Run()
	var/datum/map_zone/mapzone = SSmapping.create_map_zone("Planet Generation Testing Zone")
	for(var/planet_name as anything in SSmapping.planet_types)
		var/datum/planet_type/planet_type = SSmapping.planet_types[planet_name]
		var/datum/map_generator/mapgen = new planet_type.mapgen

		log_test("Loading [planet_name]")
		var/timer = REALTIMEOFDAY

		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
			planet_name,
			list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = planet_type.default_baseturf),
			mapzone,
			OCTODRANT_MAP_SIZE,
			OCTODRANT_MAP_SIZE,
			ALLOCATION_OCTODRANT,
			OCTODRANT_MAP_SIZE
		)
		mapgen.generate_turfs(vlevel.get_unreserved_block())
		mapgen.populate_turfs(vlevel.get_unreserved_block())

		log_test(" - Generating [planet_name] took [(REALTIMEOFDAY - timer) / 10] seconds")
		timer = REALTIMEOFDAY

		vlevel.clear_reservation()
		qdel(vlevel)

		log_test(" - Deleting [planet_name] took [(REALTIMEOFDAY - timer) / 10] seconds")
	qdel(mapzone)
