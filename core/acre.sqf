ALR_acre_radios =
{
	_ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;
	
	if (side player==west) then 
	{
		player addweapon "ACRE_PRC119";
		{
			_ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;
			["ACRE_PRC119", [80.000, 80.025, 80.050, 80.075, 80.100, 80.125] ] call acre_api_fnc_setDefaultChannels;
			["ACRE_PRC119", [50000, 50000] ] call acre_api_fnc_setDefaultPowers;
		} forEach _ALR_var_acre_radio;
	} 
	else
	{
		player addweapon "ACRE_PRC148";
		{
			_ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;
			["ACRE_PRC148", [45.000, 14.025, 34.050, 41.075, 57.100, 64.125] ] call acre_api_fnc_setDefaultChannels;
			["ACRE_PRC148", [50000, 50000] ] call acre_api_fnc_setDefaultPowers;
		} forEach _ALR_var_acre_radio;
	};
	sleep 1;

	
	_ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;	
	player removeweapon (_ALR_var_acre_radio select 0);
};