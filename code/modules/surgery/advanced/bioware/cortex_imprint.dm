/datum/surgery/advanced/bioware/cortex_imprint
	name = "Cortex Imprint"
	desc = "A surgical procedure which modifies the cerebral cortex into a redundant neural pattern, making the brain able to bypass damage caused by minor brain traumas."
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/imprint_cortex,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_HEAD)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	bioware_target = BIOWARE_LIGAMENTS

/datum/surgery/advanced/bioware/cortex_imprint/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return ..()

/datum/surgery_step/imprint_cortex
	name = "imprint cortex"
	accept_hand = TRUE
	time = 125
	experience_given = MEDICAL_SKILL_ADVANCED

/datum/surgery_step/imprint_cortex/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You start carving [target]'s outer cerebral cortex into a self-imprinting pattern."),
		span_notice("[user] starts carving [target]'s outer cerebral cortex into a self-imprinting pattern."),
		span_notice("[user] begins to perform surgery on [target]'s brain."))

/datum/surgery_step/imprint_cortex/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(user, target, span_notice("You reshape [target]'s outer cerebral cortex into a self-imprinting pattern!"),
		span_notice("[user] reshapes [target]'s outer cerebral cortex into a self-imprinting pattern!"),
		span_notice("[user] completes the surgery on [target]'s brain."))
	new /datum/bioware/cortex_imprint(target)
	return ..()

/datum/surgery_step/imprint_cortex/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_results(user, target, span_warning("You screw up, damaging the brain!"),
			span_warning("[user] screws up, damaging the brain!"),
			span_notice("[user] completes the surgery on [target]'s brain."))
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
		target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	else
		user.visible_message(span_warning("[user] suddenly notices that the brain [user.p_they()] [user.p_were()] working on is not there anymore."), span_warning("You suddenly notice that the brain you were working on is not there anymore."))
	return FALSE

/datum/bioware/cortex_imprint
	name = "Cortex Imprint"
	desc = "The cerebral cortex has been reshaped into a redundant neural pattern, making the brain able to bypass damage caused by minor brain traumas."
	mod_type = BIOWARE_CORTEX
	can_process = TRUE

/datum/bioware/cortex_imprint/process(seconds_per_tick)
	owner.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)

