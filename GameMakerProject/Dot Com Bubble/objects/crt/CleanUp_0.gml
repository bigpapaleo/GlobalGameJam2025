/// @description Free video memory

if surface_exists(my_game_surface) {
	surface_free(my_game_surface);
}
if surface_exists(monitor_surface) {
	surface_free(monitor_surface);
}