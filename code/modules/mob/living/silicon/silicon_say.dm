/mob/living/proc/robot_talk(message)
	log_talk(message, LOG_SAY, tag="binary")
	var/desig = "Default Cyborg" //ezmode for taters
	if(issilicon(src))
		var/mob/living/silicon/S = src
		desig = trim_left(S.designation + " " + S.job)
	var/message_a = say_quote(message)
	var/rendered = "Robotic Talk, [span_name("[name]")] [span_message("[message_a]")]"
	for(var/mob/M in GLOB.player_list)
		if(M.binarycheck())
			if(isAI(M))
				var/renderedAI = span_binarysay("Robotic Talk, <a href='byond://?src=[REF(M)];track=[html_encode(name)]'>[span_name("[name] ([desig])")]</a> [span_message("[message_a]")]")
				to_chat(M, renderedAI)
			else
				to_chat(M, span_binarysay("[rendered]"))
		if(isobserver(M))
			var/following = src
			// If the AI talks on binary chat, we still want to follow
			// it's camera eye, like if it talked on the radio
			if(isAI(src))
				var/mob/living/silicon/ai/ai = src
				following = ai.eyeobj
			var/link = FOLLOW_LINK(M, following)
			to_chat(M, span_binarysay("[link] [rendered]"))

/mob/living/silicon/binarycheck()
	return 1

/mob/living/silicon/lingcheck()
	return 0 //Borged or AI'd lings can't speak on the ling channel.

/mob/living/silicon/radio(message, list/message_mods = list(), list/spans, language)
	. = ..()
	if(. != 0)
		return .
	if(message_mods[MODE_HEADSET])
		if(radio)
			radio.talk_into(src, message, , spans, language, message_mods)
		return REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] in GLOB.radiochannels)
		if(radio)
			radio.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

	return 0
