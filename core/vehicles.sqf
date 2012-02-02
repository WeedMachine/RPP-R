/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_vehicleSpeed = 
[
    ["rpp_360", 1.006, 190]
];


if (isServer) then /* Init server stuff */
{
    server setVariable ["vehicles", [], true];
    
    /* Create server checker */
    [] spawn
    {
        while {true} do
        {
            _vehicles = server getVariable "vehicles";
            
            {
                _veh = _x;

                if (not alive _veh) then
                {
                    if (isNull _veh) then
                    {
                    
                    }
                    else
                    {
                        [_veh, 60] spawn RPP_fnc_serverDelVehicle;
                    };
                };
            } forEach _vehicles;
            sleep 5;
        };
    };
};

RPP_var_positionStore = [];
RPP_fnc_freezeObject = 
{
    private ["_obj"];
    _obj = _this;
    
    sleep 5;
    
    if (surfaceIsWater (getPos _obj)) then
    {
        RPP_var_positionStore set[(count RPP_var_positionStore), [_obj,(getPosASL _obj),getDir _obj]];
    }
    else
    {
        RPP_var_positionStore set[(count RPP_var_positionStore), [_obj,(getPosATL _obj),getDir _obj]];
    };

    _obj addEventHandler ["handledamage", {0}];
    _obj disableAI "ANIM";
    _obj disableAI "MOVE";
};

ALR_fnc_unflip = 
{
	private ["_vehicle", "_ok"];
	_obj = _this select 0;
	_ok = true;
	
	if (typeName _obj == "STRING") then
    {
        _obj = _obj call RPP_fnc_findVehicle;    
    };
    
    if (_obj in RPP_var_keyChain) then
    {
        _ok = true;
    }
    else
    {
        _ok = false;
    };
	
	if ((count crew _obj) > 0) then
    {
        _ok = false;
		localize "STRS_unflip_empty" call RPP_fnc_hint;
    }
    else
    {
        _ok = true;
    };
	
	if (_ok) then
	{
			_obj setvectorup [0.001,0.001,1];
			localize "STRS_unflip_complete" call RPP_fnc_hint;	
	}
	else
	{
		localize "STRS_unflip_notPossible" call RPP_fnc_hint;
	};
};	

RPP_fnc_toggleSeatbelt = 
{
    _seatbelt = player getVariable ["seatbelt", false];
                        
    if (_seatbelt) then
    {
        localize "STRS_vehicle_seatbelt_off" call RPP_fnc_hint;
    }
    else
    {
        localize "STRS_vehicle_seatbelt_on" call RPP_fnc_hint;
    };

    player setVariable ["seatbelt", !_seatbelt];
};

RPP_fnc_getNearestVehicle = 
{
    private ["_nearest"];
    _nearest = empty;
    
    {
        _vcl = _x;
        
        if (_vcl distance player < (_nearest distance player)) then
        {
            _nearest = _x;
        };
    } forEach RPP_var_keyChain;
    
    _nearest
};

RPP_fnc_freezeLoop = 
{
    while {true} do
    {
        {
            _obj = _x select 0;
            _pos = _x select 1;
            _dir = _x select 2;
            
            if (_obj distance _pos >= 5) then
            {
                _obj setPos _pos;  
                
                if (getDir _obj != _dir) then
                {
                    _obj setDir _dir;
                };
            };
            
            
                
        } forEach RPP_var_positionStore;
    sleep 1;
    };
};

RPP_fnc_addVehicleToServer = 
{
    private ["_vcl", "_vehicles"];
    _vcl = _this;
    _vehicles = server getVariable "vehicles";   
    _vehicles set[(count _vehicles), _vcl];
    server setVariable ["vehicles", _vehicles, true];
};

RPP_fnc_findVehicle = 
{
    private ["_vcl", "_vehicles", "_return"];
    _vcl = _this;
    _return = empty;
    
    _vehicles = nearestObjects[vehicle player, ["ALL"], 25];
    {
        if (format["%1",_x] == _vcl) exitWith
        {
            _return = _x;
        };
    } foreach _vehicles;  

    _return
};

RPP_fnc_createVehicle = 
{
	private ["_class", "_position", "_registration", "_vcl", "_text", "_name", "_trunk", "_siren", "_hasSiren"];
	_class = _this select 0;
	_position = _this select 1;
        _registration = [] call RPP_fnc_generateRegistration;
        if (count _this >= 4) then
        {
            _registration = (_this select 3);
        };
        _vcl = objNull;
        _name = _class call RPP_fnc_itemGetName;
        _trunk = [];
        _text = format["<t size='0.6' color='#4876FF'>%2</t><br/><t size='0.35' color='#4876FF'>%1</t><br/><t size='0.45'>(Press F to lock/unlock)</t><br/><t size='0.45'>(Press T for Menu)<br/></t><t size='0.45'>(Press B to Pullout)<br/></t><t size='0.45'>(Press U to Unflip)</t>", _registration, _name];
		_damage = 0;
        _fuel = 1;
        _siren = _class call RPP_fnc_itemGetSiren;
        _hasSiren = false;
        
        if (count _siren >= 2) then
        {
            _hasSiren = _siren select 0;
        }
        else
        {
            _hasSiren = false;
        };
        
        
        if (count _this >= 3) then
        {
            _trunk = (_this select 2);
        };
        
        if (count _this >= 5) then
        {
            _fuel = (_this select 4) select 0;
            _damage = (_this select 4) select 1;
        };
        
	call compile format
        ['
	_vcl = "%1" createVehicle %2;
	_vcl setVehicleInit "this setVehicleVarName ""%3"";
        
        [this, ""%4""] spawn
        {
            if (isNil ""RPP_fnc_create3DText"") then
            {
                _script = [] execVM ""core\text3D.sqf"";
                waitUntil {scriptDone _script};
            };

            [[] call RPP_fnc_generateID, (_this select 1), (_this select 0), 0.8, 5, true] spawn RPP_fnc_create3DText;
        };
	_vcl = this;
	_vcl addEventHandler [""GetIn"", {_this spawn RPP_fnc_event_onVehicleEnter;}];
	_vcl addEventHandler [""GetOut"", {_this spawn RPP_fnc_event_onVehicleExit;}];
        _vcl addEventHandler [""Engine"", {_this spawn RPP_fnc_event_onVehicleEngine;}];
        _vcl setVariable [""hasActions"", true, false];
	";
	player reveal _vcl;
	ClearWeaponCargo _vcl;
	ClearMagazineCargo _vcl;
	_vcl setFuelCargo 0;
        _vcl call RPP_fnc_addVehicleToServer;
        _vcl call RPP_fnc_addToKeychain;
        
        _vcl setVariable ["locked", false, true];
        _vcl setVariable ["trunk",  %5, true];
        _vcl setVariable ["maxSize", "%1" call RPP_fnc_itemGetTrunkSize, true];
        _vcl setVariable ["isPublic", true, true];
        _vcl setVariable ["RPP_siren_mounted", %8, true];
		_vcl setVariable ["RPP_siren_state", 0, true];

        _vcl setFuel %7;
        _vcl setDamage %6;
        
	processInitCommands; 
	', _class, _position, _registration, _text, _trunk, _damage, _fuel, _hasSiren];
        
};

RPP_fnc_getVehicleBoost = 
{
    private ["_class", "_return"];
    _class = _this;
    _return = 0;
    
    {
        if (_x select 0 == _class) exitWith
        {
            _return = [_x select 1, _x select 2];
        };
        
    } forEach RPP_var_vehicleSpeed;
    
    _return
};

RPP_fnc_getVehicle = 
{
    private ["_vcl", "_return"];
    _vcl = _this;
    _return = empty;
    
    if (typeName _vcl != "STRING") then
    {
        _vcl = str _vcl;
    };
    
    {
        if (_vcl == str _x) exitWith
        {
            _return = _x;
        };
    
    } forEach RPP_var_keyChain;  

    _return 
};

/* Note: This will delete if already exists */
RPP_fnc_addToKeychain = 
{
    private ["_vcl", "_found"];
    _vcl = _this;
    _found = true;
    
    if (not (_vcl in RPP_var_keyChain)) exitWith
    {
        RPP_var_keyChain set[(count RPP_var_keyChain), _vcl];
        _found = false;
        ["RPP_var_keyChain", RPP_var_keyChain] call RPP_var_saving_saveVar;
    };
    
    
    if (_found) then
    {
        _i = 0;
        {
            if (_x == _vcl) exitWith
            { 
                RPP_var_keyChain set[_i, "REMOVE"];
                RPP_var_keyChain = RPP_var_keyChain - ["REMOVE"];
            };
            _i = _i + 1;
        } forEach RPP_var_keyChain;  
    };
    
    ["RPP_var_keyChain", RPP_var_keyChain] call RPP_var_saving_saveVar;
};

RPP_fnc_serverDelVehicle = 
{
    private ["_vcl", "_deltime"];
    _vcl     = _this select 0;
    _deltime = _this select 1;
    
    [{
        [(_this select 0), (_this select 1)] spawn
        {
            sleep (_this select 1);
            if (not(isNull((_this select 0)))) then
            {
                (_this select 0) setVehicleInit "";
                call compile format["%1 = nil;", (_this select 0)];
                deleteVehicle (_this select 0);			
            };
        };
    }, [_vcl, _delTime]] spawn RPP_fnet_execPublic
};

RPP_fnc_generateRegistration =
{
   private ["_randomStart", "_randomCentre", "_randomEnd", "_unique", "_return"];
   _randomStart = round(random 300);
   _randomCentre = round(random 300);
   _randomEnd = round(random 300);
   _unique = (round(time));
    
   _return = "v" + str _randomStart + "_" + str _randomCentre + "_" + str _randomEnd + "_" + str _unique;
   
   _return
};

RPP_fnc_openVehicleMenu = 
{
    private ["_obj", "_dlg", "_class", "_trunkCapacity", "_health", "_fuel", "_name", "_className"];
    _obj = _this;
    
    if (!isNull(findDisplay 600)) exitWith
    {
        closeDialog 0;
    };
    
    _dlg = createDialog "RPP_Dlg_VehicleMenu";
    
    _class = typeOf _this;
    _trunkCapacity = _class call RPP_fnc_itemGetTrunkSize;
    _health = damage _obj;
    _fuel = fuel _obj;
    _name = str _obj;
    _className = _class call RPP_fnc_itemGetName;
    ((findDisplay 600) displayCtrl 1) ctrlSetStructuredText parseText format["<t size='0.85' color='#4876FF'>Type: %5<br/>License: %1<br/>Trunk size: %2sz<br/>Damage: %3<br/>Fuel: %4<br/></t>", _name, _trunkCapacity, _health, _fuel, _className];
    
    /* Access Trunk */
    buttonSetAction [5, format["[""%1""] call RPP_fnc_openStorage;", _obj]];
    
    /* Trunk lock/unlock */
    buttonSetAction [4, format["[""%1""] call RPP_fnc_lockTrunk;", _obj]];
    
    /* Vehicle pullout */
    buttonSetAction [3, format["[""%2"", %1] execVM ""core\pullout.sqf"";", vehicle player, _obj]];
    
    /* Vehicle lock/unlock */
    buttonSetAction [2, format["[""%1""] call RPP_fnc_lockVehicle;", _obj]];
};

RPP_fnc_lockVehicle = 
{
    private ["_vehicle", "_ok", "_lockStatus"];
    _obj = _this select 0;
    _ok = true;
    
    if (typeName _obj == "STRING") then
    {
        _obj = _obj call RPP_fnc_findVehicle;    
    };
    
    if (_obj in RPP_var_keyChain) then
    {
        _ok = true;
    }
    else
    {
        _ok = false;
    };
    
    _lockStatus = locked _obj;
    
    if (_ok) then
    {
        if (_lockStatus) then
        {
            localize "STRS_vehicle_unlocked" call RPP_fnc_hint;
            [{(_this select 0) lock false}, [_obj]] call RPP_fnet_execPublic;
        }
        else
        {
            localize "STRS_vehicle_locked" call RPP_fnc_hint;
            [{(_this select 0) lock true}, [_obj]] call RPP_fnet_execPublic;
        };
    };
};

RPP_fnc_lockTrunk = 
{
    private ["_obj", "_ok", "_lockStatus"];
    _obj = _this select 0;
    _ok = true;
    
    if (typeName _obj == "STRING") then
    {
        _obj = _obj call RPP_fnc_findVehicle;  
        
        if ((_obj call RPP_fnc_getVehicle) == empty) then
        {
            _ok = false;
        };
    };
    
    _lockStatus = _obj getVariable "locked";
    
    if (not _ok) exitWith {};
    
    if (_lockStatus) then /* Unlock */
    {
       localize "STRS_vehicle_trunkunlocked" call RPP_fnc_hint;
        _obj setVariable ["locked", false, true];
    }
    else /* Lock */
    {
        localize "STRS_vehicle_trunklocked" call RPP_fnc_hint;
        _obj setVariable ["locked", true, true];
    }; 

};

RPP_fnc_loadKeyChain = 
{
	if (count RPP_var_keyChain == 0) exitWith {
		closeDialog 0;
	};

    lbClear 2;
    {
        _vcl = _x;
        
        if (isNull _vcl) then
        {
            _vcl call RPP_fnc_addToKeychain;
        };
        
        _index = lbAdd[2, format["%2, %1", _vcl, (typeOf _vcl) call RPP_fnc_itemGetName]];
        lbSetData[2,_index, str[str _vcl]];
    } forEach RPP_var_keyChain;
    lbSetCurSel[2,0];
    
    lbClear 7;
    {
        _unit = call compile _x;
        
        if ((alive _unit) && (_unit != player)) then
        {
            if (_unit distance player <= 10) then
            {
                _index = lbAdd[7, format["%1, %2", _unit, name _unit]];
                lbSetData[7, _index, str[_unit]];
            };
        };
    
    } forEach RPP_var_players;
    lbSetCurSel[7,0];
};

RPP_fnc_keyChainUpdate = 
{
    private ["_data", "_vcl", "_damage", "_locked", "_trunk", "_type"];
    _data = call compile lbData[2,lbCurSel 2];
    _vcl = _data select 0;
    
    _vcl = _vcl call RPP_fnc_getVehicle;  
    
    _damage = damage _vcl;
    _locked = locked _vcl;
    _trunk = _vcl getVariable "locked";
    _type = (typeOf _vcl) call RPP_fnc_itemGetName;
    
    ((findDisplay 1000) displayCtrl 14) ctrlSetStructuredText parseText format["Type: %1<br/>Locked: %2<br/>Trunk Locked: %3<br/>Damage: %4<br/>",_type, _locked, _trunk, _damage];
};

RPP_fnc_keyDrop =
{
    private ["_data", "_vcl"];
    _data = call compile lbData[2,lbCurSel 2];
    _vcl = _data select 0;
    _vcl = _vcl call RPP_fnc_getVehicle;  
    
    _vcl call RPP_fnc_addToKeychain;
    
    localize "STRS_item_keychain_drop" call RPP_fnc_hint;
    [] call RPP_fnc_loadKeyChain;
};

RPP_fnc_keyTransferClient = 
{
    private ["_vcl", "_unit"];
    _unit = _this select 0;
    _vcl = _this select 1;
    _from = _this select 2;
    
    if (player != _unit) exitWith {};
    
     _vcl call RPP_fnc_addToKeychain;
     
     (format[localize "STRS_item_keychain_receive", name _from]) call RPP_fnc_hint;
};

RPP_fnc_offroad = 
{
    while {true} do
    {
        if (vehicle player != player) then
        {
            if ((speed (vehicle player) >= 5) && (not isOnRoad getpos vehicle player) && (driver vehicle player == player)) then
            {
                if ((vehicle player isKindOf "Ship") || (vehicle player isKindOf "Air") || (typeOf vehicle player == "Tractor")) then
                {
                    /* Do nothing */
                }
                else
                {
                    _damage = damage vehicle player;
                    _speed = speed vehicle player;

                    _doDamage = 0.005 * (_speed / 100);

                    _damage = _damage + _doDamage;

                    if (_damage < 0.90) then
                    {
                        vehicle player setDamage _damage;
                    }
                    else
                    {
                        vehicle player setFuel (fuel vehicle player - 0.1);
                    };
                };
            };
        };
        
        sleep 5;
    };
};

RPP_fnc_keyTransfer = 
{
    private ["_data", "_vcl", "_unitData", "_unit"];
    _data = call compile lbData[2,lbCurSel 2];
    _vcl = _data select 0;
    _vcl = _vcl call RPP_fnc_getVehicle;  
    
    _unitData = call compile lbData[7,lbCurSel 7];
    _unit = _unitData select 0;
    
    if (alive _unit) then
    {
        
        if (_unit distance player <= 10) then
        {
            _vcl call RPP_fnc_addToKeychain;
            ["RPP_fnc_keyTransferClient", [_unit, _vcl, player]] call RPP_fnet_execPublic;
            (format[localize "STRS_item_keychain_transfer", name _unit]) call RPP_fnc_hint;
        }
        else
        {
            localize "STRS_item_keychain_tooFar" call RPP_fnc_hint;
        };
    }
    else
    {
        localize "STRS_item_keychain_noExist" call RPP_fnc_hint;
    };
    
     [] call RPP_fnc_loadKeyChain;
};