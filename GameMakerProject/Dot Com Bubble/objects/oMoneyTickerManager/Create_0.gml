related_words = [
"dairy", "milk", "cow", "cheese", "yogurt", 
"butter", "skim", "calcium", "cream", "curd", 
"farm", "wisconsin", "udder", "cheddar", "milkshake"
];
helper_words = [];
discovered_words = [];
combined_words = [];

current_level = 1;

money_amt = 0;
money_goal_lvl_1 = 100000; // 1000000;
money_goal_lvl_2 = 500000; // 5000000;
money_goal_lvl_3 = 1000000; // 10000000;

corporate_congratulations = [
  "Performance-based champion!",
  "You're a valued employee!",
  "We're like family!",
  "You're in your wheelhouse!",
  "Great R.O.I.!",
  "Teamwork makes the dream work!",
  "You're a subject matter expert!",
  "Great job leveraging assets!",
  "Great job meeting deliverables!",
  "You're not in trouble!",
  "Pizza party on Friday!",
  "You could be Employee of the Month!",
  "You might get a raise someday!"
];
corporate_congratulation = "";

function getRateIndexOfDiscoveredWord(word) {
	var index_of_discovered_word = -1;
	for(var k = 0; k < array_length(related_words); k++) {
		if(related_words[k] == word) {
			index_of_discovered_word = k+1;
			break;
		}
	}
	return index_of_discovered_word;
}

function startLevel1() {
	current_level = 1;
	money_amt = 0;
	
	for(var i = 0; i < array_length(related_words); i++) {
		array_push(helper_words, related_words[i]);
	}
	combineTotalAndHelperWords();
	
	with(oClock) {
		countdown_time_max = 4000; // 4000;
		countdown_time = countdown_time_max;
	}	
}

function startLevel2() {
	current_level = 2;
	money_amt = 0;
	
	instance_create_layer(2233, 743, "Instances", oStickyNote, {
		sticky_note_text : "Domains must also have to do with \"cats\"..."
	});
	for(var i = 0; i < array_length(related_words); i++) {
		array_push(helper_words, related_words[i]);
	}
	related_words = [
	  "cat", "fur", "kitten", "meow", "pet",
	  "claw", "purr", "litter", "cute", "paw",
	  "animal", "bite", "stray", "feline", "neuter"
	];
	combineTotalAndHelperWords();
	
	with(oClock) {
		countdown_time_max = 7000; // 12000;
		countdown_time = countdown_time_max;
		active = true;
	}
}

function startLevel3() {
	current_level = 3;
	money_amt = 0;
	
	instance_create_layer(2433, 733, "Instances", oStickyNote, {
		sticky_note_text : "Domains also have to do with \"spirtuality\" ?????"
	});
	for(var i = 0; i < array_length(related_words); i++) {
		array_push(helper_words, related_words[i]);
	}
	related_words = [
	  "spirit", "god", "zen", "buddha", "mind",
	  "universal", "peace", "joy", "nirvana", "renew",
	  "meditate", "sati", "harmony", "enlighten", "horoscope"
	];
	combineTotalAndHelperWords();
	
	with(oClock) {
		countdown_time_max = 9000; //18000;
		countdown_time = countdown_time_max;
		active = true;
	}
}

function endGameState() {
}

function combineTotalAndHelperWords() {
	combined_words = [];
	for(var i = 0; i < array_length(related_words); i++) {
		array_push(combined_words, related_words[i]);
	}
	for(var i = 0; i < array_length(helper_words); i++) {
		array_push(combined_words, helper_words[i]);
	}
}

function clearForNextLevel() {
	money_amt = 0;
	
	with(oClock) {
		active = false;
	}
	with(oTypingManager) {
		state = TYPING_STATE.IDLE;
		submitted_domains = [];
	}
	with(oStockGraph) {
		instance_destroy();
	}
	with(oHand) {
		put_away = true;
	}
	
	discovered_words = [];
	corporate_congratulation = corporate_congratulations[irandom(array_length(corporate_congratulations)-1)];
	alarm[0] = 120;
	audio_play_sound(sndLevelWin, 0, false);
}