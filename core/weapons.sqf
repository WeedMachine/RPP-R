/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_fnc_getMagazineCount =
{
    private ["_type", "_obj", "_count"];
    _type = _this select 0;
    _obj = _this select 1;
    _count = 0;

    {
        _mag = _x;
        _magType = (_mag call RPP_fnc_itemGetType2);
       
        if (_magType == _type) then
        {
            _count = _count + 1;
        };
    } forEach (magazines _obj);

    _count
};

RPP_fnc_getMagazineAmount = 
{
    private ["_type", "_obj", "_count"];
    _type = _this select 0;
    _obj = _this select 1;
    _count = 0;

    {
        _mag = _x;
        
        if (_mag == _type) then
        {
            _count = _count + 1;
        };
    } forEach (magazines _obj);
    
    _count
};

RPP_fnc_createWeaponsArray =
{
    private ["_weapons", "_arr"];
    _weapons = _this select 0;
    _arr = [];

    {
        _weapon = _x;
        _inArr = false;

        {
            if (_weapon == (_x select 0)) then
            {
                _x set[1, ((_x select 1)+1)];
                _inArr = true;
            };
        } forEach _arr;

        if (!_inArr) then
        {
            _arr set[(count _arr),[_weapon,1]];
        };
    } forEach _weapons;

    _arr
};

RPP_fnc_hasWeaponType = 
{
    private ["_obj", "_hasWeapon", "_type"];
    _obj = _this select 0;
    _type = _this select 1;
    _hasWeapon = false;

    {
        _weapon = _x;
   
        _weaponType = (_weapon call RPP_fnc_itemGetType2);

        if (_weaponType == _type) then
        {
            _hasWeapon = true;
        };
    } forEach (weapons _obj);

    _hasWeapon
};

RPP_fnc_hasWeaponClass =
{
    private ["_object", "_class", "_has"];
    _object = _this select 0;
    _class = _this select 1;
    _has = false;
    
    {
        if (_x == _class) exitWith
        {
            _has = true; 
        };
    } forEach (weapons _object);
    
    _has
};

RPP_fnc_hasMagazineClass =
{
    private ["_object", "_class", "_has"];
    _object = _this select 0;
    _class = _this select 1;
    _has = false;
    
    {
        if (_x == _class) exitWith
        {
            _has = true; 
        };
    } forEach (magazines _object);
    
    _has
};

RPP_fnc_findWeaponOfType =
{
    private ["_type", "_player", "_return"];
    _type = _this select 0;
    _player = _this select 1;
    _return = "";
    
     {
        _weapon = _x;
   
        _weaponType = (_weapon call RPP_fnc_itemGetType2);

        if (_weaponType == _type) then
        {
            _return = _weapon;
        };
    } forEach (weapons _player);

    _return
};

RPP_fnc_hasWeapon = 
{
    private ["_hasWeapon", "_object"];
    _hasWeapon = false;
    _object = _this;

    if (([_object,"RIFLE"] call RPP_fnc_hasWeaponType) or ([_object,"PISTOL"] call RPP_fnc_hasWeaponType)) then
    {
        _hasWeapon = true;
    };

    _hasWeapon
};

RPP_fnc_holsterPistol = 
{
    _hasPistol = [player, "PISTOL"] call RPP_fnc_hasWeaponType;
    _pistolType = "";
    
    if !(RPP_var_holsterAvailable) exitWith
    {
    
    };
    
    RPP_var_holsterAvailable = false;
   
    if (isNil "RPP_var_holstered") then
    {
       RPP_var_holstered = false;
       RPP_var_holsteredWeapon = "";
       RPP_var_holsterAvailable = true;
    };
   
    if (RPP_var_holstered) then /* Unholster*/
    {
        if (_hasPistol) exitWith
        {
            /* Already have pistol */
        };
        
        player addWeapon RPP_var_holsteredWeapon;
        RPP_var_holstered = false;
        
        (format[localize "STRS_holster_unholstered", RPP_var_holsteredWeapon call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        
        if ((vehicle player == player) && (player call RPP_fnc_isCop)) then
        {
            [{(_this select 0) switchmove "AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon_end";}, [player]] call RPP_fnet_execPublic;
        };
    }
    else /* Holster */
    {
        if !(_hasPistol) exitWith
        {
            /* No pistol */
        };
        
        _pistolType = ["PISTOL", player] call RPP_fnc_findWeaponOfType;
        RPP_var_holsteredWeapon = _pistolType;
        RPP_var_holstered = true;
        
        player removeWeapon _pistolType;
        
        (format[localize "STRS_holster_holstered", _pistolType call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        

    };
    
    sleep 3;
    RPP_var_holsterAvailable = true;

};

RPP_fnc_dropWeapons = 
{
    private ["_unit", "_magazines", "_weapons", "_weaponHolder"];
    _unit = _this select 0;
    _magazines = _this select 1;
    _weapons = _this select 2;
    
    _weaponHolder = "WeaponHolder" createVehicle position _unit;

    _weaponHolder setVehicleInit format["this setVehicleVarName ""holder_%1"";", (round time)]; 
    processInitCommands;
    
    {
        _unit removeMagazine _x;
    } forEach _magazines;
    
    {
        if ((_x != "ItemMap") || (_x != "ItemCompass") || (_x != "ItemWatch") || (_x != "ItemRadio") || (_x != "ItemGPS")) then
        {
            _unit removeWeapon _x;
        };
    } forEach _weapons;
    
    [{
        _weaponHolder = (_this select 0);
        _weapons = (_this select 1);
        _magazines = (_this select 2);
        
        {
            if ((_x != "ItemMap") || (_x != "ItemCompass") || (_x != "ItemWatch") || (_x != "ItemRadio") || (_x != "ItemGPS")) then
            {
                _weaponHolder addWeaponCargo[_x,1];
            };
        } forEach (_weapons);
    
        {
            _weaponHolder addMagazineCargo[_x,1];
        } forEach (_magazines);
        
    }, [_weaponHolder, _weapons, _magazines]] call RPP_fnet_execPublic;
    
    
    _weaponHolder setPos getpos _unit;
    [_weaponHolder, 300] spawn RPP_fnc_serverDelVehicle;
};

RPP_fnc_tazed = 
{
    private ["_victim", "_shooter", "_time", "_weaponHolder", "_weapons", "_magazines"];
    _victim = _this select 0;
    _shooter = _this select 1;
    
    closeDialog 0;
    
    if (RPP_var_isTazed) exitWith {};
    if (RPP_var_isRestrained) exitWith {};
    
    RPP_var_isTazed = true;
    
    /* Set animation here */
    if (vehicle player == player) then
    {
        ["RPP_fnc_serverSwitchAnimation", [_victim, "AdthPercMstpSnonWnonDnon_3"]] call RPP_fnet_execPublic;
    };
    
    format[localize "STRS_stun_stunned", name _shooter] call RPP_fnc_hint;
    
    /* Start tazed effect */
    "radialBlur" ppEffectEnable true;
    "radialBlur" ppEffectAdjust[0.2, 0.2, 0, 0];
    "radialBlur" ppEffectCommit 0;
    
    _weapons = weapons _victim;
    _magazines = magazines _victim;
    
    if (RPP_var_holstered) then
    {
        _weapons set[(count _weapons), RPP_var_holsteredWeapon];
        RPP_var_holstered = false;
    };
    
    [_victim, _magazines, _weapons] call RPP_fnc_dropWeapons;
    
    /* Drop weapons and items */
    [position _victim] spawn RPP_fnc_dropInventory;
    
    
    /* Disable player */
    disableUserInput true;
    _time = time;
    while {_time+RPP_var_tazedTime > time} do
    {
        if !(alive _victim) then
        {
            disableUserInput false;
        };
        
        sleep 1;
        cutText ["","WHITE OUT",1];
        sleep 1;
        cutText ["","WHITE IN",1];
    };
    
    cutText ["","WHITE IN", 0.1];
    "radialBlur" ppEffectEnable false;
    "radialBlur" ppEffectCommit 5;
    disableUserInput false; 
    RPP_var_isTazed = false;
    
    if (RPP_var_isRestrained) exitWith {};
    
    if (vehicle player == player) then
    {
        ["RPP_fnc_serverSwitchAnimation", [_victim, "amovppnemstpsnonwnondnon"]] call RPP_fnet_execPublic;
    };
};

RPP_fnc_hit = 
{
    private ["_unit", "_selection", "_damage", "_source", "_projectile"];
    _unit = _this select 0;
    _selection = _this select 1;
    _damage = _this select 2;
    _source = _this select 3;
    _projectile = _this select 4;
    _handled = false;
    _tazer = ["B_9x18_SD"];

    //player groupchat format["%1 %2 %3 %4 %5", _unit, _selection, _damage, _source, _projectile];

    if (RPP_var_isImmortal) exitWith 
    {
        /* Player is immortal and shall not die! */
    };
    
    if (_projectile in _tazer) exitWith
    {
        if (_selection != "body") exitWith
        {
            /* Ignore this one */
        };
        
        if (_projectile == "B_9x18_SD") exitWith
        {
            [_unit, _source] spawn RPP_fnc_tazed;
        };
        
        _handled = true;
    };
    
    if ((_source == vehicle player) && (player != vehicle player)) then //Vehicle accident
    {
        _collisionSpeed = RPP_var_speed;
        
        if !(alive vehicle player) then /* Vehicle on fire */
        {
            
        
        }
        else //Car collision
        {
            if (isNil "RPP_var_lastCollision") then
            {
                RPP_var_lastCollision = 0;
            };

            if (((RPP_var_lastCollision)+2) <= time) then
            {
                _seatbelt = player getVariable ["seatbelt", false];
                
                _damage = 0;

            }
            else
            {

            };
        };
    };
    
    if ((_source == player) && (player == vehicle player)) then 
    {
        if (_selection != "body") exitWith
        {
            
        };
            
        _vcls = nearestObjects[player,["Land"], 5];
        _hitBy = player;
        _speed = 0;
        {
            _speed = speed _x;
            _hasDriver = (!(isNull(driver _x)));
            if ((_speed >= 4) && (_hasDriver)) then
            {
                _hitby = _x;
            };
        } forEach _vcls;
        
        if (_hitBy == player) then /* Fell */
        {
            

        }
        else /* Hit by vehicle */
        {
            
        };
        
    };
    
    if (_projectile != "") then /* Shot */
    {
        
    };
    
    if !(_handled) exitWith
    {
        _playerDamage = damage player;
        
        /*if (_damage + _playerDamage >= 0.9) exitWith
        {
            [] spawn RPP_fnc_medical_dead;
        };*/

        _damage
    };
    

};