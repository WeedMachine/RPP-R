RPP_fnc_monitor = 
{
    if (isNil "RPP_var_speed") then
    {
        RPP_var_speed = [];
        RPP_var_height = 0;
    };
    
    waitUntil {alive player};
    _ticks = 0;
    while {true} do
    {
        RPP_var_speed = speed vehicle player;

		{
			_class = (_x select 0);
			_amount = (_x select 1);
			_name = _class call RPP_fnc_itemGetClass;

			if (_name == "Null") then {
				[_class, -_amount] call RPP_fnc_addInventoryItem;
				diag_log format["Removed %1 null items!", _amount];
			};
		} forEach RPP_var_inventory;

        
        if (_ticks % 2 == 0) then
        {
            _velocity = velocity player;
            _fallingRate = _velocity select 2;
            
            if (_fallingRate <= -1.0) then
            {
            
            }
            else
            {
                RPP_var_height = (getPosATL player) select 2;
            };
        };
    
        _ticks = _ticks + 1;
        sleep 1;
    };

};

