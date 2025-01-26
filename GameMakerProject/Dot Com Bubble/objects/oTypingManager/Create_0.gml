enum TYPING_STATE {
	IDLE,
	TYPING,
	SUCCESS,
	FAILURE,
	WAIT_FOR_HR
}

state = TYPING_STATE.IDLE;
domain_name_string = "http://www.";
submitted_domains = [];
max_string_length = 37;

function checkToAcceptUrl(url) {
	if(array_contains(submitted_domains, url)) {
		return "NO DUPLICATES!";
	} else if(url == "http://www.") {
		return "NOT A WEBSITE!";
	} else if(string_count(".com", url) == 0) {
		return "NEEDS .COM!";
	} else if(containsNaughtyWord(url)) {
		return "WAIT FOR HR";
	} else {
		var money_ticker = instance_find(oMoneyTickerManager, 0);
		var found_related_word = false;
		for(var i = 0; i < array_length(money_ticker.related_words); i++) {
			if(string_count(money_ticker.related_words[i], url)) {
				found_related_word = true;
			}
		}
		
		if(!found_related_word) {
			return "NEED A KEYWORD!";
		}
	}
	return "";
}

function submitUrl() {
	array_push(submitted_domains, domain_name_string);
	state = TYPING_STATE.SUCCESS;
	
	with(oMoneyTickerManager) {
		for(var j = 0; j < array_length(related_words); j++) {
			var this_word = related_words[j];
			if(string_count(this_word, other.domain_name_string) > 0) {
				instance_create_layer(300+irandom(100), 350, "Instances", oUrlFlair, {
					url_value : "x"+string(string_count(this_word, other.domain_name_string)),
					flair_color : $66ff66,
					scroll_speed : 3+random(4)
				});
				
				var rate = getRateIndexOfDiscoveredWord(this_word);
				
				instance_create_layer(500+irandom(100), 350, "Instances", oUrlFlair, {
					url_value : "x"+string(rate),
					flair_color : $66ff66,
					scroll_speed : 3+random(4)
				});
			}
		}
	}
	
	instance_create_layer(100+irandom(100), 350, "Instances", oUrlFlair, {
		url_value : "+"+string(string_length(domain_name_string)),
		flair_color : $66ff66,
		scroll_speed : 3+random(4)
	});
	
	alarm[1] = 30;
}

function rejectUrl(reject_reason) {
	state = TYPING_STATE.FAILURE;
	alarm[1] = 30;
	
	instance_create_layer(100+irandom(200), 350, "Instances", oUrlFlair, {
		url_value : reject_reason,
		flair_color : $0000ff
	});
}

function changeHands() {
	var change_chance = random(1);
	if(change_chance < 0.75) {
		with(oHand) {
			var hand_sprite_index = irandom(13);
			if(hand_sprite_index == 0) sprite_index = sHand1;
			if(hand_sprite_index == 1) sprite_index = sHand2;
			if(hand_sprite_index == 2) sprite_index = sHand3;
			if(hand_sprite_index == 3) sprite_index = sHand4;
			if(hand_sprite_index == 4) sprite_index = sHand5;
			if(hand_sprite_index == 5) sprite_index = sHand6;
			if(hand_sprite_index == 6) sprite_index = sHand7;
			if(hand_sprite_index == 7) sprite_index = sHand8;
			if(hand_sprite_index == 8) sprite_index = sHand9;
			if(hand_sprite_index == 9) sprite_index = sHand10;
			if(hand_sprite_index == 10) sprite_index = sHand11;
			if(hand_sprite_index == 11) sprite_index = sHand12;
			if(hand_sprite_index == 12) sprite_index = sHand13;
			if(hand_sprite_index == 13) sprite_index = sHand14;
			
			x = base_position_x - 30 + irandom(60);
			y = base_position_y + irandom(20);
		}
	}
}

typing_bar = false;
alarm[0] = 30;

text_shake_x = 0;
text_shake_y = 0;