/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

/* Script created by Jason Olsen. If it does not work, this is probably why */

/* Open the stats menu dialog */
RPP_fnc_openStatsMenu =
{
    private ["_h"];
    
    if (!isNull(findDisplay 700)) exitWith
    {
        /* Do nothing */
    };
    
    _h = createDialog "RPP_Dlg_Stats";
    
    [] call RPP_fnc_loadStatsMenu;
};

RPP_var_admins = 
[
    "Unforgiven", "Jason", "Weed", "Keefygeorge", "Ddog-nz-"
];

RPP_fnc_loadStatsMenu = 
{
    lbClear 10;
    lbAdd[10, "Mission Information"];
    lbAdd[10, format["Name: %1", localize "STRM_MISSION_NAME"]];
    lbAdd[10, format["Version: %1", RPP_Mission_Version]];
    lbAdd[10, format["Mission Start: %1/%2/%3  %4:%5", missionStart select 1, missionStart select 2, missionStart select 0, missionStart select 3, missionStart select 4]];
    lbAdd[10, format["Time: %1:%2", date select 3, date select 4]];
    lbAdd[10, format["Date: %1/%2/%3", date select 1, date select 2, date select 0]];
    
    lbAdd[10, ""];
    lbAdd[10, "Player Information"];
    lbAdd[10, format["Username: %1", name player]];
    lbAdd[10, format["ID: %1", getPlayerUID player]];
    lbAdd[10, format["Hunger: %1", "Hunger" call RPP_fnc_getDynamicVal]];
    lbAdd[10, format["Thirst: %1", "Thirst" call RPP_fnc_getDynamicVal]];

    lbAdd[10, ""];
    lbAdd[10, "Licenses"];
    {
        lbAdd[10, _x call RPP_fnc_getLicenseName];
    } forEach RPP_var_playerLicenses;
    
    if (count RPP_var_playerLicenses <= 0) then
    {
        lbAdd[10, "None!"];
    };
    
    lbAdd[10, ""];
    
    lbAdd[10, "Skills"];
    {
        _id = (_x select 0);
        _name = _id call RPP_fnc_getSkillName;
        _exp = (_x select 1);
        _level = _exp call RPP_fnc_calculateLevel;
        
        lbAdd[10, format["(%1) Level: %2, Experience: %3", _name, _level, _exp]];
    } forEach RPP_var_userSkills;
   
    lbClear 12;
    _numAdded = 0;
    {
        if (_x in RPP_var_admins) then
        {
            lbAdd[12, _x];
            _numAdded = _numAdded + 1;
        };
    } forEach ([] call RPP_fnc_getOnlinePlayers);
    
    if (_numAdded == 0) then
    {
        lbAdd[12, "None available"];
    };
    
    lbClear 13;
    lbAdd[13, format["Time: %1:%2 | Date: %3/%4/%5", date select 3, date select 4, date select 1, date select 2, date select 0]];
    
    _currentWeatherImage = ((RPP_var_currentWeather select 2) select 0);
    _currentWeatherText = ((RPP_var_currentWeather select 2) select 1);
    _forecastText = ((RPP_var_forcastWeather select 2) select 1);
    
    lbAdd[13, format["Current Weather: %1", _currentWeatherText]];
    lbAdd[13, format["12 Hour Forecast: %1", _forecastText]];
    ctrlSetText[9, format["%1", _currentWeatherImage]];
    

};  