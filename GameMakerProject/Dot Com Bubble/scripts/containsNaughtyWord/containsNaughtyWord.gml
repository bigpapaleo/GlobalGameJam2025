function containsNaughtyWord(text_to_examine) {
	var naughty_word_list = [
	 "ass", "bitch", "bastard", "cock", "cunt", "milf",
	 "damn", "fuck", "dammit", "hell", "pussy", "penis",
	 "vagina", "dick", "sex", "anus", "shit", "cocksucker",
	 "xxx", "nude", "topless", "boob", "titty", "titties",
	 "nipple", "taint", "analsex", "oralsex", "yiff", "rimjob",
	 "blowjob", "handjob", "poop", "turd"
	];
	
	for(var i = 0; i < array_length(naughty_word_list); i++) {
		if(string_count(naughty_word_list[i], text_to_examine) > 0) {
			return true;
		}
	}
	return false;
}