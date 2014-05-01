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

	//clean the input msg
	if(!msg)	return
	msg = sanitize_russian(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)	return
	var/original_msg = msg
	if(!mob)	return						//this doesn't happen

	var/ref_mob = "\ref[mob]"
	msg = "\blue <b><font color='red'>HELP: </font>[key_name(src, 1)] (<A HREF='?_src_=holder;adminmoreinfo=[ref_mob]'>?</A>) (<A HREF='?_src_=holder;adminplayeropts=[ref_mob]'>PP</A>) (<A HREF='?_src_=vars;Vars=[ref_mob]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=[ref_mob]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservejump=[ref_mob]'>JMP</A>) (<A HREF='?_src_=holder;check_antagonist=1'>CA</A>):</b> [msg]"

	//send this msg to all admins
	for(var/client/X in admins)
		if((R_ADMIN|R_MOD) & X.holder.rights)
			if(X.prefs.toggles & SOUND_ADMINHELP)
				X << 'sound/effects/adminhelp.ogg'
			X << msg

	//show it to the person adminhelping too
	src << "<font color='blue'>PM to-<b>Admins</b>: [original_msg]</font>"
	feedback_add_details("admin_verb","AH") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return
