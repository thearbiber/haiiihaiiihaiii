/obj/item/clothing/under/rank/command
	desc = "A standard command jumpsuit."
	name = "command jumpsuit"
	icon = 'icons/obj/clothing/under/command.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/command.dmi'
	roll_sleeves = TRUE
	icon_state = "cmd"
	item_state = "w_suit"

/obj/item/clothing/under/rank/command/skirt
	desc = "A standard command jumpskirt."
	name = "command jumpskirt"
	icon_state = "cmd_skirt"
	roll_sleeves = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/command/nt
	icon_state = "cmd_nt"
	item_state = "b_suit"
	roll_sleeves = TRUE

/obj/item/clothing/under/rank/command/nt/skirt
	desc = "A standard command jumpskirt."
	name = "command jumpskirt"
	icon_state = "cmd_nt_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

//Captain

/obj/item/clothing/under/rank/command/captain
	desc = "It's a white jumpsuit with some gold markings denoting the rank of \"Captain\"."
	name = "captain's jumpsuit"
	icon_state = "captain"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/command/captain/skirt
	name = "captain's jumpskirt"
	desc = "It's a white jumpskirt with some gold markings denoting the rank of \"Captain\"."
	icon_state = "captain_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/command/captain/suit/skirt
	name = "green suitskirt"
	desc = "A green suitskirt and yellow necktie. Exemplifies authority."
	icon_state = "green_suit_skirt"
	item_state = "dg_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION


//Head of Personnel

/obj/item/clothing/under/rank/command/head_of_personnel
	desc = "It's a jumpsuit worn by someone who works in the position of \"Head of Personnel\"."
	name = "head of personnel's jumpsuit"
	icon_state = "hop"
	roll_sleeves = TRUE

/obj/item/clothing/under/rank/command/head_of_personnel/skirt
	name = "head of personnel's jumpskirt"
	desc = "It's a jumpskirt worn by someone who works in the position of \"Head of Personnel\"."
	icon_state = "hop_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/command/head_of_personnel/suit
	name = "head of personnel's suit"
	desc = "A teal suit and yellow necktie. An authoritative yet tacky ensemble."
	icon_state = "teal_suit"
	item_state = "g_suit"
	roll_sleeves = FALSE

/obj/item/clothing/under/rank/command/head_of_personnel/suit/skirt
	name = "teal suitskirt"
	desc = "A teal suitskirt and yellow necktie. An authoritative yet tacky ensemble."
	icon_state = "teal_suit_skirt"
	item_state = "g_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION
