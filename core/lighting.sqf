RPP_fnc_activateLights = {
	private ["_brightness", "_color", "_typeOfLights", "_nearestLights"];
	_brightness = 0.2;
	_color = [ 0.35, 0.35, 0.35];
	_typeOfLights = ["MAP_lampa_sidl", "MAP_lampa_sidl_2", "MAP_lampa_ind", "MAP_lampa_sidl_3", "Land_Lamp_Small_EP1"];
	_nearestLights = nearestObjects[player, _typeOfLights, 45000];
	RPP_var_lightSources = [];
	

	{
		_obj = _x;
		_light = "#lightpoint" createVehicleLocal getpos _obj;
		_light lightAttachObject [_obj, [0,0,3]]; 
		_light setLightBrightness _brightness;
		_light setLightAmbient    _color;
		_light setLightColor      _color;
		RPP_var_lightSources set[(count RPP_var_lightSources), _light];
	} forEach _nearestLights;
};

RPP_fnc_deactivateLights = {
	if (isNil "RPP_var_lightSources") exitWith {};

	{
		deleteVehicle _x;
	} forEach RPP_var_lightSources;

	RPP_var_lightSources = [];
};