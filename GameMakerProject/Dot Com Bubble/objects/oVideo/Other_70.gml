var _type = async_load[? "type"];

if (_type == "video_start") {
	video_ready = true;

/*
	customVideoSkipToPoint();
	
	var game_manager = instance_find(oGameManager, 0);
	if(game_manager != noone) {
		game_manager.should_clear_chosen_option = true;
	}
	*/
	
    loadAudioTrack(current_video_name);
} else if (_type == "video_end") {
	if(current_video_name == global.video_level1) {
		with(oTypingManager) {
			state = TYPING_STATE.TYPING;
		}
		
		instance_create_layer(1995, 723, "Instances", oStickyNote, {
			sticky_note_text : "Purchase domains having to do with \"dairy\""
		});
		
		instance_create_layer(480, 384, "Instances", oStockGraph);
		instance_create_layer(2509, 1075, "Hands", oHand);
		instance_create_layer(2002, 1075, "Hands", oHand, {
			image_xscale : -1.0
		});
		
		with(oClock) {
			active = true;
		}
	} else if(current_video_name == global.video_level2) {
		with(oTypingManager) {
			state = TYPING_STATE.TYPING;
		}
		
		instance_create_layer(480, 384, "Instances", oStockGraph);
		instance_create_layer(2509, 1075, "Hands", oHand);
		instance_create_layer(2002, 1075, "Hands", oHand, {
			image_xscale : -1.0
		});
		
		with(oMoneyTickerManager) {
			startLevel2();
		}
	} else if(current_video_name == global.video_level3) {
		with(oTypingManager) {
			state = TYPING_STATE.TYPING;
		}
		
		instance_create_layer(480, 384, "Instances", oStockGraph);
		instance_create_layer(2509, 1075, "Hands", oHand);
		instance_create_layer(2002, 1075, "Hands", oHand, {
			image_xscale : -1.0
		});
		
		with(oMoneyTickerManager) {
			startLevel3();
		}
	} else if(current_video_name == global.video_ending_naughty) {
		game_restart();
	} else if(current_video_name == global.video_ending_good) {
		game_restart();
	} else if(current_video_name == global.video_ending_good2) {
		game_restart();
	}
	current_video_name = "";
}