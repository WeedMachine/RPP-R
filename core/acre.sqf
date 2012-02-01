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

		
	{
		_station = _x;
		RPP_var_goods set[(count RPP_var_goods), [str _station, ["WEAPON", "ITEM"], ["ACRE UHF RADIO", "No description"], [1600, 1250], 1, "core\items\noUse.sqf", 0, true, [], false]];
	} forEach _ALR_var_acre_radio;
	
	_ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;	
	player removeweapon (_ALR_var_acre_radio select 0);
};