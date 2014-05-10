/client/verb/adminhelp(msg as text)
	set category = "Admin"
	set name = "Adminhelp"

	if(say_disabled)	//This is here to try to identify lag problems
		usr << "\red Speech is currently admin-disabled."
		return

	//handle muting and automuting
	if(prefs.muted & MUTE_ADMINHELP)
		src << "<font color='red'>Error: Admin-PM: You cannot send adminhelps (Muted).</font>"
		return
	if(src.handle_spam_prevention(msg,MUTE_ADMINHELP))
		return

	adminhelped = 1 //Determines if they get the message to reply by clicking the name.

	/**src.verbs -= /client/verb/adminhelp

	spawn(1200)
		src.verbs += /client/verb/adminhelp	// 2 minute cool-down for adminhelps
		src.verbs += /client/verb/adminhelp	// 2 minute cool-down for adminhelps//Go to hell
	**/

	//clean the input msg
	if(!msg)	return
	msg = sanitize_russian(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)	return
	var/original_msg = msg
	if(!mob)	return						//this doesn't happen

	msg = "\blue <b><font color=red>HELP: </font>[get_options_bar(mob, 2, 1, 1)]:</b> [msg]"

	//send this msg to all admins
	for(var/client/X in admins)
		if(R_ADMIN & X.holder.rights)
			if(X.prefs.toggles & SOUND_ADMINHELP)
				X << 'sound/effects/adminhelp.ogg'
			X << msg

	//show it to the person adminhelping too
	src << "<font color='blue'>PM to-<b>Admins</b>: [original_msg]</font>"
	feedback_add_details("admin_verb","AH") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return
