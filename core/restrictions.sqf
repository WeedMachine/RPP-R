RPP_var_restrictions =
[
    ["cop_base", 100, "(not(player call RPP_fnc_isCop))", "cop_exit", "You are not a cop and cannot enter this area."]
];

RPP_fnc_restrictionLoop = 
{
    waitUntil {alive player};
    while {true} do
    {
        {
            _marker = getMarkerPos (_x select 0);
            _distance = (_x select 1);
            _condition = call compile (_x select 2);
            _moveTo = getMarkerPos (_x select 3);
            _msg = (_x select 4);

            if (player distance _marker <= _distance) then
            {
                if (_condition) then
                {
                    vehicle player setPos _moveTo;
                    server globalchat _msg;
                };
            };
        
        } forEach RPP_var_restrictions;
        sleep 1;
    };
};