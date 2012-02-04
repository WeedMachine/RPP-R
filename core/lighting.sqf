
	_object     = _this select 0;
	_brightness = 0.1;
	_color      = [0.5, 0.5, 0.5];
	
	if ((count _this) > 2) then {_brightness = _this select 1;};
	if ((count _this) > 3) then {_color      = _this select 2;};
	
while{true}do

	{	
	
	_light = "#lightpoint" createVehicleLocal getpos _object;
	_light lightAttachObject [_object, [0,0,0]]; 
	_light setLightBrightness _brightness;
	_light setLightAmbient    _color;
	_light setLightColor      _color;
	
	waituntil{!alive power1 and !alive power2};

	deletevehicle _light;

	waituntil{alive power1 and alive power2};

	};