
// see code/module/crafting/table.dm

////////////////////////////////////////////////EGG RECIPE's////////////////////////////////////////////////

/datum/crafting_recipe/food/friedegg
	name = "Fried egg"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/blackpepper = 1,
		/obj/item/reagent_containers/food/snacks/egg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/friedegg
	subcategory = CAT_EGG

/datum/crafting_recipe/food/omelette
	name = "Omelette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/omelette
	subcategory = CAT_EGG

/datum/crafting_recipe/food/chocolateegg
	name = "Chocolate egg"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chocolateegg
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggsbenedict
	name = "Eggs benedict"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/friedegg = 1,
		/obj/item/food/meat/steak = 1,
		/obj/item/food/breadslice/plain = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/benedict
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggbowl
	name = "Egg bowl"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/corn = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/eggbowl
	subcategory = CAT_EGG

/datum/crafting_recipe/food/eggrolls
	name = "Eggrolls"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/friedegg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggrolls
	subcategory = CAT_EGG

/datum/crafting_recipe/food/wrap
	name = "Wrap"
	reqs = list(
		/datum/reagent/consumable/soysauce = 10,
		/obj/item/reagent_containers/food/snacks/friedegg = 1,
		/obj/item/food/grown/cabbage = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/eggwrap
	category = CAT_EGG

/datum/crafting_recipe/food/chawanmushi
	name = "Chawanmushi"
	reqs = list(
		/datum/reagent/water = 5,
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/reagent_containers/food/snacks/boiledegg = 2,
		/obj/item/food/grown/mushroom/chanterelle = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chawanmushi
	category = CAT_EGG
