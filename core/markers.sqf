/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_fnc_setupMarkers = 
{
    {
        _unit = _x;
        
        _marker = createMarkerLocal [format["marker_%1", _x], [0,0,0]];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerTypeLocal "DOT";
        _marker setMarkerColorLocal "ColorBlue";
        _marker setMarkerSizeLocal [0.50, 0.50]; 
    } forEach RPP_var_cops;
};

RPP_fnc_displayMarkers = 
{
    while {true} do
    {
        {
            _unit = call compile _x;
            _marker = format["marker_%1", _x];
            
            if (alive _unit) then
            {
                _marker setMarkerPosLocal position _unit;
                _marker setMarkerTextLocal name _unit;
            }
            else
            {
                _marker setMarkerPosLocal [0,0,0];
                _marker setMarkerTextLocal "";
            };
        } forEach RPP_var_cops;
        
        sleep 1;
    };
};