/obj/item/wirecutters
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters_map"
	item_state = "cutters"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 6
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=80)
	attack_verb = list("pinched", "nipped")
	hitsound = 'sound/items/wirecutter.ogg'
	usesound = 'sound/items/wirecutter.ogg'
	drop_sound = 'sound/items/handling/wirecutter_drop.ogg'
	pickup_sound =  'sound/items/handling/wirecutter_pickup.ogg'

	tool_behaviour = TOOL_WIRECUTTER
	toolspeed = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	var/random_color = TRUE
	var/static/list/wirecutter_colors = list(
		"blue" = "#8080ff",
		"red" = "#ff666e",
		"pink" = "#fd99ff",
		"brown" = "#b38459",
		"green" = "#9fe3a9",
		"cyan" = "#96ffef",
		"yellow" = "#ffe366"
	)


/obj/item/wirecutters/Initialize()
	. = ..()
	if(random_color) //random colors!
		icon_state = "cutters"
		var/our_color = pick(wirecutter_colors)
		add_atom_colour(wirecutter_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_appearance()

/obj/item/wirecutters/update_overlays()
	. = ..()
	if(!random_color) //icon override
		return
	var/mutable_appearance/base_overlay = mutable_appearance(icon, "cutters_cutty_thingy")
	base_overlay.appearance_flags = RESET_COLOR
	. += base_overlay

/obj/item/wirecutters/get_belt_overlay()
	if(random_color)
		var/mutable_appearance/body = mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "cutters")
		var/mutable_appearance/head = mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "cutters_head")
		body.color = color
		head.add_overlay(body)
		return head
	else
		return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', icon_state)

/obj/item/wirecutters/attack(mob/living/carbon/C, mob/user)
	if(istype(C) && C.handcuffed && istype(C.handcuffed, /obj/item/restraints/handcuffs/cable))
		user.visible_message(span_notice("[user] cuts [C]'s restraints with [src]!"))
		qdel(C.handcuffed)
		return
	else
		..()

/obj/item/wirecutters/abductor
	name = "alien wirecutters"
	desc = "Extremely sharp wirecutters, made out of a silvery-green metal."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "cutters"
	toolspeed = 0.1
	random_color = FALSE

/obj/item/wirecutters/cyborg
	name = "powered wirecutters"
	desc = "Cuts wires with the power of ELECTRICITY. Faster than normal wirecutters."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "wirecutters_cyborg"
	toolspeed = 0.5
	random_color = FALSE

/obj/item/wirecutters/syndie
	icon_state = "cutters_syndie"
	random_color = FALSE

/obj/item/wirecutters/old
	desc = "This cuts wires. It also appears to be slightly rusty..."
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldcutters"
