// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

// Base type. Subtypes are found in /grown dir. Lavaland-based subtypes can be found in mining/ash_flora.dm
/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/obj/hydroponics/harvest.dmi'
	name = "fresh produce" // so recipe text doesn't say 'snack'
	var/obj/item/seeds/seed = null // type path, gets converted to item on New(). It's safe to assume it's always a seed item.
	var/plantname = ""
	var/bitesize_mod = 0
	var/splat_type = /obj/effect/decal/cleanable/food/plant_smudge
	// If set, bitesize = 1 + round(reagents.total_volume / bitesize_mod)
	dried_type = -1
	// Saves us from having to define each stupid grown's dried_type as itself.
	// If you don't want a plant to be driable (watermelons) set this to null in the time definition.
	resistance_flags = FLAMMABLE
	var/dry_grind = FALSE //If TRUE, this object needs to be dry to be ground up
	var/can_distill = TRUE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/wine_flavor //If NULL, this is automatically set to the fruit's flavor. Determines the flavor of the wine if distill_reagent is NULL.
	var/wine_power = 10 //Determines the boozepwr of the wine if distill_reagent is NULL.

/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	if(!tastes)
		tastes = list("[name]" = 1)

	if(new_seed)
		seed = new_seed.Copy()
	else if(ispath(seed))
		// This is for adminspawn or map-placed growns. They get the default stats of their seed type.
		seed = new seed()
		seed.adjust_potency(50-seed.potency)
	else if(!seed)
		stack_trace("Grown object created without a seed. WTF")
		return INITIALIZE_HINT_QDEL

	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

	if(dried_type == -1)
		dried_type = src.type

	if(seed)
		for(var/datum/plant_gene/trait/trait in seed.genes)
			trait.on_new_plant(src, loc)
		seed.prepare_result(src)
		transform *= TRANSFORM_USING_VARIABLE(seed.potency, 100) + 0.5 //Makes the resulting produce's sprite larger or smaller based on potency!
		add_juice()



/obj/item/reagent_containers/food/snacks/grown/proc/add_juice()
	if(reagents)
		if(bitesize_mod)
			bitesize = 1 + round(reagents.total_volume / bitesize_mod)
		return 1
	return 0

/obj/item/reagent_containers/food/snacks/grown/examine(user)
	. = ..()
	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			if(T.examine_line)
				. += T.examine_line

/obj/item/reagent_containers/food/snacks/grown/attackby(obj/item/O, mob/user, params)
	..()
	if (istype(O, /obj/item/plant_analyzer))
		var/msg = "This is \a [span_name("[src]")].\n"
		if(seed)
			msg += "[seed.get_analyzer_text()]\n"
		var/reag_txt = ""
		if(seed)
			for(var/reagent_id in seed.reagents_add)
				var/datum/reagent/R  = GLOB.chemical_reagents_list[reagent_id]
				var/amt = reagents.get_reagent_amount(reagent_id)
				reag_txt += "[span_info("- [R.name]: [amt]")]\n"

		if(reag_txt)
			msg += reag_txt
		to_chat(user, boxed_message(msg))
	else
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_attackby(src, O, user)
//Ghetto Seed Extraction
	switch(O.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts digging into \the [src]."), span_notice("You start digging into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts digging into \the [src]."), span_notice("You start digging into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_WIRECUTTER)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts nipping into \the [src]."), span_notice("You start nipping into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You nip into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_CROWBAR)
			playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts splitting \the [src]."), span_notice("You dig into \the [src] and start to split it..."), span_hear("You hear the sound of a sharp object digging into some plant matter."))
			if(do_after(user, 20, target = src))
				to_chat(user, span_notice("You split apart the [src]! Sadly you put too much force and it's remains are unusable, but hey, you got your seeds!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_WRENCH)
			playsound(loc, 'sound/misc/splort.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts whacking \the [src]."), span_notice("You start whacking \the [src]..."), span_hear("You hear the sound of a plant being whacked violently."))
			if(do_after(user, 17, target = src))
				to_chat(user, span_notice("You smash [src]! Sadly there's nothing left of it other than the seeds and some junk."))
				seedify(src, 1, TRUE, TRUE, src, user)
	if(!slice_path)
		if(O.get_sharpness())
			playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts slicing apart \the [src]."), span_notice("You start slicing apart \the [src]..."), span_hear("You hear the sound of a sharp object slicing some plant matter."))
			if(do_after(user, 30, target = src))
				to_chat(user, span_notice("You slice apart the [src]! You went too far and the tiny remaining scraps are worthless!"))
				seedify(src, 1, TRUE, TRUE, src, user)

/obj/item/reagent_containers/food/snacks/grown/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_throw_impact(src, hit_atom)

/obj/item/reagent_containers/food/snacks/grown/On_Consume()
	if(iscarbon(usr))
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_consume(src, usr)
	..()

/obj/item/reagent_containers/food/snacks/grown/generate_trash(atom/location)
	if(trash && (ispath(trash, /obj/item/grown) || ispath(trash, /obj/item/reagent_containers/food/snacks/grown)))
		. = new trash(location, seed)
		trash = null
		return
	return ..()

/obj/item/reagent_containers/food/snacks/grown/grind_requirements()
	if(dry_grind && !dry)
		to_chat(usr, span_warning("[src] needs to be dry before it can be ground up!"))
		return
	return TRUE

/obj/item/reagent_containers/food/snacks/grown/on_grind()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(grind_results&&grind_results.len)
		for(var/i in 1 to grind_results.len)
			grind_results[grind_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

/obj/item/reagent_containers/food/snacks/grown/on_juice()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(juice_results&&juice_results.len)
		for(var/i in 1 to juice_results.len)
			juice_results[juice_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

/obj/item/reagent_containers/food/snacks/grown/proc/get_tgui_info()
	var/list/data = list()
	var/datum/reagent/product_distill_reagent = distill_reagent
	data["distill_reagent"] = initial(product_distill_reagent.name)
	data["juice_result"] = list()
	for(var/datum/reagent/reagent as anything in juice_results)
		data["juice_result"] += initial(reagent.name)
	return data

/*
 * Attack self for growns
 *
 * Spawns the trash item at the growns drop_location()
 *
 * Then deletes the grown object
 *
 * Then puts trash item into the hand of user attack selfing, or drops it back on the ground
 */
/obj/item/reagent_containers/food/snacks/grown/shell/attack_self(mob/user)
	var/obj/item/T
	if(trash)
		T = generate_trash(drop_location())
		//Delete grown so our hand is free
		qdel(src)
		//put trash obj in hands or drop to ground
		user.put_in_hands(T, user.active_hand_index, TRUE)
		to_chat(user, span_notice("You open [src]\'s shell, revealing \a [T]."))
