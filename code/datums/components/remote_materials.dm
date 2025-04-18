/*
This component allows machines to connect remotely to a material container
(namely an /obj/machinery/ore_silo) elsewhere. It offers optional graceful
fallback to a local material storage in case remote storage is unavailable, and
handles linking back and forth.
*/

/datum/component/remote_materials
	// Three possible states:
	// 1. silo exists, materials is parented to silo
	// 2. silo is null, materials is parented to parent
	// 3. silo is null, materials is null
	var/obj/machinery/ore_silo/silo
	var/datum/component/material_container/mat_container
	var/category
	var/allow_standalone
	var/local_size = INFINITY

/datum/component/remote_materials/Initialize(category, mapload, allow_standalone = TRUE)
	if (!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	src.category = category
	src.allow_standalone = allow_standalone

	RegisterSignal(parent, COMSIG_OBJ_DECONSTRUCT, PROC_REF(OnDeconstruct))
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, PROC_REF(OnAttackBy))
	RegisterSignal(parent, COMSIG_ATOM_MULTITOOL_ACT, PROC_REF(OnMultitool))

	if (allow_standalone)
		_MakeLocal()

/datum/component/remote_materials/Destroy()
	if (silo)
		silo.connected -= src
		silo.updateUsrDialog()
		silo = null
		mat_container = null
	mat_container = null
	return ..()

/datum/component/remote_materials/proc/OnDeconstruct(disassembled)
	SIGNAL_HANDLER
	if(!silo && mat_container)
		// specify explicitly in case the other component is deleted first
		var/atom/P = parent
		mat_container.retrieve_all(P.drop_location())

/datum/component/remote_materials/proc/_MakeLocal()
	silo = null

	var/static/list/allowed_mats = list(
		/datum/material/iron,
		/datum/material/glass,
		/datum/material/silver,
		/datum/material/gold,
		/datum/material/diamond,
		/datum/material/plasma,
		/datum/material/uranium,
		/datum/material/hellstone,
		/datum/material/titanium,
		/datum/material/bluespace,
		/datum/material/plastic,
		/datum/material/sulfur,
		/datum/material/silicon,
		/datum/material/carbon,
		/datum/material/copper,
		/datum/material/lead,
		/datum/material/quartz,
		)

	mat_container = parent.AddComponent(/datum/component/material_container, allowed_mats, local_size, allowed_types=/obj/item/stack)

/datum/component/remote_materials/proc/set_local_size(size)
	local_size = size
	if (!silo && mat_container)
		mat_container.max_amount = size

// called if disconnected by ore silo UI or destruction
/datum/component/remote_materials/proc/disconnect_from(obj/machinery/ore_silo/old_silo)
	if (!old_silo || silo != old_silo)
		return
	silo = null
	mat_container = null
	if (allow_standalone)
		_MakeLocal()

/datum/component/remote_materials/proc/OnAttackBy(datum/source, obj/item/I, mob/user)
	SIGNAL_HANDLER

	if (!silo || !istype(I, /obj/item/stack))
		return

	if (silo.remote_attackby(parent, user, I))
		return COMPONENT_NO_AFTERATTACK

/datum/component/remote_materials/proc/OnMultitool(datum/source, mob/user, obj/item/I)
	SIGNAL_HANDLER

	if(!I.multitool_check_buffer(user, I))
		return COMPONENT_BLOCK_TOOL_ATTACK
	var/obj/item/multitool/M = I
	if (!QDELETED(M.buffer) && istype(M.buffer, /obj/machinery/ore_silo))
		if (silo == M.buffer)
			to_chat(user, span_warning("[parent] is already connected to [silo]!"))
			return COMPONENT_BLOCK_TOOL_ATTACK
		if (silo)
			silo.connected -= src
			silo.updateUsrDialog()
		else if (mat_container)
			mat_container.retrieve_all()
			qdel(mat_container)
		silo = M.buffer
		silo.connected += src
		silo.updateUsrDialog()
		mat_container = silo.GetComponent(/datum/component/material_container)
		to_chat(user, span_notice("You connect [parent] to [silo] from the multitool's buffer."))
		return COMPONENT_BLOCK_TOOL_ATTACK

/datum/component/remote_materials/proc/on_hold()
	return silo && silo.holds["[get_area(parent)]/[category]"]

/datum/component/remote_materials/proc/silo_log(obj/machinery/M, action, amount, noun, list/mats)
	if (silo)
		silo.silo_log(M || parent, action, amount, noun, mats)

/datum/component/remote_materials/proc/format_amount()
	if (mat_container)
		return "[mat_container.total_amount] / [mat_container.max_amount == INFINITY ? "Unlimited" : mat_container.max_amount] ([silo ? "remote" : "local"])"
	else
		return "0 / 0"
