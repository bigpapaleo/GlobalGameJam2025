y_positions = [];
y_height_max = 100;
stock_graph_array_length_max = 60;
pct_complete = 0;
alarm[0] = 15;

function addPositionToGraph() {
	var money_ticker = instance_find(oMoneyTickerManager, 0);
	var money_goal = 0;
	if(money_ticker.current_level == 1) money_goal = money_ticker.money_goal_lvl_1;
	if(money_ticker.current_level == 2) money_goal = money_ticker.money_goal_lvl_2;
	if(money_ticker.current_level == 3) money_goal = money_ticker.money_goal_lvl_3;
	
	var y_position = y_height_max * (money_ticker.money_amt / money_goal);
	array_push(y_positions, y_position);
	if(array_length(y_positions) > stock_graph_array_length_max) {
		array_delete(y_positions, 0, 1);
	}
	
	pct_complete = (money_ticker.money_amt / money_goal);
}