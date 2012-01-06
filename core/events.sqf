RPP_fnc_event_onPlayerConnect =
{
    private ["_id", "_name", "_uid"];
    _id = _this select 0;
    _name = _this select 1;
    _uid = _this select 2;

};

RPP_fnc_event_onPlayerDisconnect = 
{
    private ["_id", "_name", "_uid"];
    _id = _this select 0;
    _name = _this select 1;
    _uid = _this select 2;
    
};

RPP_fnc_event_onVehicleEnter = 
{
    private ["_vehicle", "_position", "_unit"];
    _vehicle = _this select 0;
    _position = _this select 1;
    _unit = _this select 2;
    
    if (vehicle player == _vehicle) then
    {
        /* Player entered vehicle */
        if (_unit != player) then
        {
            format[localize "STRS_event_vcl_entered", name _unit] call RPP_fnc_hint;
        };
    };
};

RPP_fnc_event_onVehicleExit =
{
    private ["_vehicle", "_position", "_unit"];
    _vehicle = _this select 0;
    _position = _this select 1;
    _unit = _this select 2;
    
    if (vehicle player == _vehicle) then
    {
        /* Player left vehicle */
        if (_unit != player) then
        {
            format[localize "STRS_event_vcl_left", name _unit] call RPP_fnc_hint;
        };
    };
    
    if (_unit == player) then
    {
        if (player getVariable ["seatbelt", false]) then
        {
            [] call RPP_fnc_toggleSeatbelt;
        };
        
        if !(player call RPP_fnc_medical_isAlive) then
        {
            sleep 1;
            ["RPP_fnc_serverSwitchAnimation", [player, "AdthPercMstpSlowWrf_beating"]] call RPP_fnet_execPublic;  
        };
    };
};

RPP_fnc_event_onVehicleEngine = 
{
    private ["_vehicle", "_state"];
    _vehicle = _this select 0;
    _state = _this select 1;
    
    if (_state) then /* Engine on */
    {
        
    }
    else /* Engine off */
    {
    
    };
    
};

