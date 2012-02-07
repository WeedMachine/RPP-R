/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_time_updateClients = 60;
RPP_var_time_timeChange = 120;
RPP_var_time_increaseDay = 15;
RPP_var_time_increaseNight = 30;

RPP_fnc_timeLoop = 
{
    _ticks = 0;
    while {true} do
    {
        if (_ticks % RPP_var_time_updateClients == 0) then
        {
            ["RPP_fnc_syncClientsTime", [date]] call RPP_fnet_execPublic;
        };
        
        if (_ticks % RPP_var_time_timeChange == 0) then
        {
            [] call RPP_fnc_serverUpdateTime;
        };
       
        _ticks = _ticks + 1;
        sleep 1;
    };
};

RPP_fnc_isDay = 
{
     ((dayTime >= 20) || (dayTime <= 6)) 
};

RPP_fnc_isNight = 
{
    ((dayTime > 6) || (dayTime < 20))
};

RPP_fnc_serverUpdateTime = 
{
    private ["_increaseTime"];
    _increaseTime = 0;
   
    if ([] call RPP_fnc_isDay) then
    {
        _increaseTime = RPP_var_time_increaseDay;
    }
    else
    {
        _increaseTime = RPP_var_time_increaseNight;
    };
    
    setDate[date select 0, date select 1, date select 2, date select 3, ((date select 4)+_increaseTime)];
    
    /* Sync clients */
    ["RPP_fnc_syncClientsTime", [date]] call RPP_fnet_execPublic;
};

RPP_fnc_syncTime = {
	if !(isServer) exitWith {};
	["RPP_fnc_syncClientsTime", [date]] call RPP_fnet_execPublic;
};

RPP_fnc_syncClientsTime = 
{
    private ["_date"];
    _date = _this select 0;
    
    if (isServer) exitWith {};
    
    [_date] call RPP_fnc_clientSetTime;
};

RPP_fnc_clientSetTime = 
{
    private ["_date"];
    _date = _this select 0;
    
    setDate _date;
};