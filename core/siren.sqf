RPP_fsiren_getValues =
{
    private ["_car", "_array", "_return"];
    _car = _this;
    _array = [];
    _return = [];

    if (typeName _car == "OBJECT") then
    {
        _car = typeOf _car;
    };

    _array = (_car call RPP_fnc_itemGetSiren);

    if (count _array < 2) then
    {
        _return = [];
    }
    else
    {
        _return = _array;
    };


    _return
};

RPP_fssiren_toggleHandle =
{
    private ["_this", "_car", "_state", "_type", "_sirens", "_index", "_i"];
    _car = _this select 0;
    _state = _this select 1;
    _type = _this select 2;

    if (_state == 2) then
    {
        _car call RPP_fssiren_removeFromArray;
    }
    else
    {
        _sirens = _sirens + [(server getVariable "RPP_siren_active")];
        _index = count _sirens;
        _i = 0;
        {
            if ((_x select 0) == _car) exitWith
            {
                _index = _i;
            };
            _i = _i + 1;
        } forEach _sirens;

        _sirens set [_index, [_car, _state, _type]];
        server setVariable ["RPP_siren_active", _sirens, true];
    };
};

RPP_fssiren_removeFromArray =
{
    private ["_car", "_index", "_i", "_sirens"];
    _car = _this;

    _index = -1;
    _i = 0;
    _sirens = _sirens + [(server getVariable "RPP_siren_active")];
    {
        if ((_x select 0) == _car) exitWith
        {
                _index = _i;
        };
        _i = _i + 1;
    } forEach _sirens;

    if (_index != -1) then
    {
        _sirens set [_index, ">REMOVE<"];
        _sirens = _sirens - [">REMOVE<"];

        server setVariable ["RPP_siren_active", _sirens, true];
    };
};

RPP_fsiren_toggle =
{
    private ["_car", "_params", "_state"];
    _car = _this;
    _params = _car call RPP_fsiren_getValues;

    if ((player == driver _car) && (_car getVariable "RPP_siren_mounted")) then
    {
        _state = _car getVariable "RPP_siren_state";

        [
            compile format ['
                if (isServer) then
                {		
                    ["%1", %2, "%3"] call RPP_fssiren_toggleHandle;
                };
            ', _car, _state, _params select 1]
        ] spawn RPP_fnet_execPublic;

        switch (_state) do
        {
            case 0: //Turn on the lights
            {
                    //["Lights on!"] call TNL_fextHint_Hint;
                localize "STRS_siren_lights" call RPP_fnc_hint;
                _car setVariable ["RPP_siren_state", 1, true];
                [{[(_this select 0), (_this select 1)] spawn RPP_fsiren_lights;}, [_car, _params select 1]] call RPP_fnet_execPublic; 
            };
            case 1: //Turn on the sound
            {
                    //["Sounds on!"] call TNL_fextHint_Hint;
                localize "STRS_siren_siren" call RPP_fnc_hint;
                _car setVariable ["RPP_siren_state", 2, true];
                [{[(_this select 0), (_this select 1)] spawn RPP_fsiren_sounds;}, [_car, _params select 1]] call RPP_fnet_execPublic; 
            };
            case 2: //Turn off
            {
                localize "STRS_siren_off" call RPP_fnc_hint;
                _car setVariable ["RPP_siren_state", 0, true];
            };
        };
    };
};

RPP_fsiren_lights =
{
    private ["_car", "_type", "_params"];
    _car = _this select 0;
    _type = _this select 1;

    _params = ((_car call RPP_fsiren_getValues) select 2) select 0;

    while {_car getVariable "RPP_siren_state" != 0} do
    {
        if (!alive _car) exitWith
        {
            _car setVariable ["RPP_siren_state", 0, true];
        };


        switch (toLower _type) do
        {
            case "singleblue":
            {
                private ["_light", "_size"];
                if (dayTime > 7 && dayTime < 17) then
                {
                    _size = 3;
                }
                else
                {
                    _size = 0.5;
                };
                
                _light = "#lightpoint" createVehicleLocal (_car modelToWorld (_params select 0));
                _light setLightBrightness (_params select 2);
                _light setLightAmbient (_params select 1);
                _light setLightColor (_params select 1);
                _light lightAttachObject [_car, (_params select 0)];

                _ps = "#particlesource" createVehicleLocal (_car modelToWorld (_params select 0));
                _ps setParticleCircle [0, velocity _car];
                _ps setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
                _ps setParticleParams ["Ca\Data\kouleSvetlo.p3d", "", "Billboard", 1, 0.05, (_params select 0), (velocity _car), 0, 1.275, 1, 0, [_size], [[0,0,1,1]], [0,0,0], 0, 0, "", "", _car];
                _ps setDropInterval 0.05;

                sleep 0.25;
                deleteVehicle _light;
                deleteVehicle _ps;
                sleep 0.25;
            };
        };
    };
};

RPP_fsiren_sounds =
{
    private ["_car", "_type", "_params"];
    _car = _this select 0;
    _type = _this select 1;

    _params = ((_car call RPP_fsiren_getValues) select 2) select 0;
    
    player groupchat format["Car: %1  Type: %2", _car, _type];

    while {_car getVariable "RPP_siren_state" == 2} do
    {
        if (!alive _car) exitWith
        {
            _car setVariable ["RPP_siren_state", 0, true];
        };

        switch (toLower _type) do
        {
            case "singleblue":
            {
                if (vehicle player distance _car < 700) then
                {
                    if ((speed _car > -3) && (speed _car < 3)) then
                    {
                        sleep 1;
                    }
                    else
                    {
                        if (speed _car <= 45) then
                        {
                            _car say["SndSirenShort", 1];
                            sleep 0.64;
                           
                        }
                        else
                        {
                            _car say["SndSirenLong", 1];
                            sleep 4.92; 
                        };
                    };
                }
                else
                {
                    sleep 5;
                };
            };
        };
    };
};