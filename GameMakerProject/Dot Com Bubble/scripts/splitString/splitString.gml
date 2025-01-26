function splitString() {
	var s = argument[0], d = argument[1], r;
	if(argument_count >= 3) {
	    r = argument[2];
	    ds_list_clear(r);
	} else {
		r = ds_list_create();
	}

	var p = string_pos(d, s);
	var dl = string_length(d);
	if(dl) {
		while(p) {
		    p -= 1;
		    ds_list_add(r, string_copy(s, 1, p));
		    s = string_delete(s, 1, p + dl);
		    p = string_pos(d, s);
		}
	}
	if(s != "") {
		ds_list_add(r, s);
	}

	if(ds_list_size(r) == 1 && ds_list_find_value(r, 0) == "") {
		// It's an empty list.  We don't want to return a list of size 1 with an empty string.
		ds_list_clear(r);
	}

	return r;


}
