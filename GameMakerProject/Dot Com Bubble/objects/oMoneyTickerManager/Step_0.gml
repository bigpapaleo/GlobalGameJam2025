var typing_manager = instance_find(oTypingManager, 0);
if(typing_manager != noone) {
	for(var i = 0; i < array_length(typing_manager.submitted_domains); i++) {
		var this_domain = typing_manager.submitted_domains[i];
		for(var j = 0; j < array_length(combined_words); j++) {
			var this_word = combined_words[j];
			if(string_count(this_word, this_domain) > 0) {
				if(!array_contains(discovered_words, this_word) && array_contains(related_words, this_word)) {
					array_push(discovered_words, this_word);
				}
				var length_modifier = (string_length(this_domain)/20);
				var rate = getRateIndexOfDiscoveredWord(this_word);
				if(rate != -1) {
					money_amt += rate * length_modifier * current_level;
				}
			}
		}
	}
}

var money_goal = 0;
if(current_level == 1) money_goal = money_goal_lvl_1;
if(current_level == 2) money_goal = money_goal_lvl_2;
if(current_level == 3) money_goal = money_goal_lvl_3;

if(money_amt > money_goal) {
	clearForNextLevel();
}