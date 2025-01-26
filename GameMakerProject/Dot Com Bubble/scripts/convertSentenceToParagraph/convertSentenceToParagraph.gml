function convertSentenceToParagraph(sentence, width) {
	var paragraph = ds_list_create();
	var words = ds_list_create();
	splitString(sentence, " ", words);
	
	draw_set_font(fHandwriting);
	var next_word = ds_list_find_value(words, 0);
	var next_line = next_word;
	for(var i = 1; i < ds_list_size(words); i++) {
		next_word = ds_list_find_value(words, i);
		if(string_width(next_line+" "+next_word) < width) {
			next_line = next_line + " " + next_word;
		} else {
			ds_list_add(paragraph, next_line);
			next_line = next_word;
		}
	}
	ds_list_add(paragraph, next_line);
	
	ds_list_destroy(words);
	
	return paragraph;
}