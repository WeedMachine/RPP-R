/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_weather_minTime = 120; /* Minimum time for weather to change */
RPP_var_weather_maxTime = 600; /* Maximum time for weather to change */

/* Fog, Overcast, Rain */
RPP_var_weather_types = 
[
    ["heavy_rain", [0.1, 0.85, 1.0], ["images\weather\darkheavyrain1.paa", "Heavy Rain"]],
    ["medium_rain", [0.1, 0.8, 0.5], ["images\weather\darklightrain1.paa", "Rain"]],
    ["light_rain", [0.1, 0.8, 0.25], ["images\weather\whitelightrain1.paa", "Light Rain"]],
    ["heavy_fog", [0.85, 0.5, 0.0], ["images\weather\sunnycloud1.paa", "Heavy Fog"]],
    ["medium_fog", [0.5, 0.35, 0.0], ["images\weather\sunnycloud1.paa", "Medium Fog"]],
    ["light_fog", [0.25, 0.25, 0.0], ["images\weather\sunnycloud1.paa", "Light Fog"]],
    ["sunny", [0, 0, 0], ["images\weather\sunny.paa", "Sunny"]],
    ["cloudy", [0, 0.2, 0], ["images\weather\sunnycloud1.paa", "Cloudy"]]
];

RPP_var_currentWeather = [];
RPP_var_forcastWeather = [];

RPP_fnc_syncWeather = {
	if !(isServer) exitWith {};

	publicVariable "RPP_var_currentWeather";
	publicVariable "RPP_var_forcastWeather";
};

RPP_fnc_weatherLoop = 
{
    _ticks = 0;
    _randomChange = (RPP_var_weather_minTime + (round(random RPP_var_weather_maxTime)));
    RPP_var_forcastWeather = RPP_var_weather_types select (random(count RPP_var_weather_types-1));
    while {true} do
    {
        if ((_ticks >= _randomChange) || (_ticks == 0)) then
        {
            _forecast = RPP_var_forcastWeather;
            _randomChange = (RPP_var_weather_minTime + (round(random RPP_var_weather_maxTime)));
            RPP_var_forcastWeather = RPP_var_weather_types select (random(count RPP_var_weather_types-1));
            _forecast call RPP_fnc_randomWeather;

            _ticks = 0;
        };
        
        _ticks = _ticks + 1;
        sleep 1;     
    };
};

RPP_fnc_randomWeather = 
{
    private ["_randomWeather", "_fog", "_overcast", "_rain"];
    _randomWeather = _this;
    _fog = ((_randomWeather select 1) select 0);
    _overcast = ((_randomWeather select 1) select 1);
    _rain = ((_randomWeather select 1) select 2);
    
    RPP_var_currentWeather = _randomWeather;
    
    ["RPP_fnc_clientUpdateWeather", [_fog, _overcast, _rain, RPP_var_currentWeather, RPP_var_forcastWeather]] call RPP_fnet_execPublic;
};

RPP_fnc_clientUpdateWeather = 
{
    private ["_fog", "_overcast", "_rain"];
    _fog = _this select 0;
    _overcast = _this select 1;
    _rain = _this select 2;
    _currentWeather = _this select 3;
    _forcastWeather = _this select 4;
    
    RPP_var_currentWeather = _currentWeather;
    RPP_var_forcastWeather = _forcastWeather;
    
    60 setFog _fog;
    60 setOvercast _overcast;
    60 setRain _rain;
};