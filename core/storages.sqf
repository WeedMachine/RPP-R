/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_storages = 
[
    [local_storage1, "Central Local Storage", 0, false],
    [public_storage1, "Central Public Storage", 10000, true],
    [item_factory_storage, "Item Factory Storage", 0, false],
	[car_factory_storage, "Car Factory Storage", 0, false],
	[bike_factory_storage, "Bike Factory Storage", 0, false],
	[manufacturing_plant_storage, "Manufacturing Plant Storage", 0, false],
	[lost_property_lot, "Lost Property Lot", 0, true],
	[air_factory_storage, "Air Factory Storage", 0, false],
	[cop_spawn_local, "Police: Local Storage", 0, false],
	[cop_spawn_public, "Police: Public Storage", 10000, true],
	[heavy_car_factory_storage, "Heavy Storage", 0, false]
];

{
    _obj = (_x select 0);
    _text = (_x select 1);
    _maxSize = (_x select 2);
    _isPublic = (_x select 3);
    
    if (_isPublic) then
    {
        if (isServer) then
        {
            _obj setVariable ["trunk", [], _isPublic];
            _obj setVariable ["maxSize", _maxSize, _isPublic];
            _obj setVariable ["isPublic", _isPublic, _isPublic];
        };
    }
    else
    {
        _obj setVariable ["trunk", [], _isPublic];
        _obj setVariable ["maxSize", _maxSize, _isPublic];
        _obj setVariable ["isPublic", _isPublic, _isPublic];
    };
} forEach RPP_var_storages;

RPP_var_timeSinceLastUsedTrunk = time;
RPP_var_timeUntilCanUseTrunk = 1;

RPP_fnc_openStorage = 
{
    private ["_object", "_dlg"];
    _object = _this select 0;
    
    if (!isNull(findDisplay 500)) exitWith
    {
        /* Do nothing */
    };

	/* Got to add this because people who rob bank just put the money in storage */
	if ((((RPP_var_bankRobTime)+(RPP_var_bankDelay/2.25)) >= time) && (typeName _object != "STRING")) exitWith
	{
		/* Cannot use yet */
		localize "STRS_bank_cannotUse" call RPP_fnc_hint;
	};
    
    if (typeName _object == "STRING") then
    {
        /* We will have to search for the vehicle manually */
        _object = _object call RPP_fnc_findVehicle;  
    };

    if ((_object getVariable ["locked", false])) exitWith
    {
        /* Storage is locked */
        localize "STRS_storage_trunkLocked" call RPP_fnc_hint;
    };
    
    _dlg = createDialog "RPP_Dlg_Storage";
    _object call RPP_fnc_loadStorage;
};

RPP_fnc_loadStorage =
{
    private ["_object", "_trunk", "_storageSize", "_invSize", "_storageMax"];
    _object = _this;
    
    _trunk = _object getVariable "trunk";
    
    /* Add trunk items */
    lbClear 2;
    {
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = _mass * _amount;
        _type = _class call RPP_fnc_itemGetType1;
        
        if (_type == "VEHICLE") then
        {
            _mass = _mass + ([(_x select 2), "weight"] call RPP_fnc_trunkGetParamVar);
        };
        
        _index = lbAdd[2, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
        
        if (_type == "VEHICLE") then
        {
            lbSetData[2, _index, str[_class, str _object, (_x select 2)]];  
        }
        else
        {
            lbSetData[2, _index, str[_class, str _object]]; 
        };
            
    } forEach _trunk;
    lbSetCurSel[2,0];
    
    /* Add Inventory items */
    lbClear 3;
    {
        _idc = 3;
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = _mass * _amount;
        
        if (_class call RPP_fnc_itemGetCanDrop) then
        {
            _index = lbAdd[_idc, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
            lbSetData[_idc, _index, str[_class, str _object]];
        };
    } forEach RPP_var_inventory;
    
    /* Add Weapons & Magazines */
    {
        _idc = 3;
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = _mass * _amount;
        
        if (_class call RPP_fnc_itemGetCanDrop) then
        {
            _index = lbAdd[_idc, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
            lbSetData[_idc, _index, str[_class, str _object]];
        };
    } forEach ([(weapons player) + (magazines player)] call RPP_fnc_createWeaponsArray);
    
    /* Add Vehicles */
    {
        _idc = 3;
        _class = typeOf _x;
        _name = _class call RPP_fnc_itemGetName;
        _amount = 1;
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = (_mass * _amount) + (_x call RPP_fnc_getTrunkSize);

        if (_class call RPP_fnc_itemGetCanDrop && (player distance _x <= 20) && (_object != _x)) then
        {
            _index = lbAdd[_idc, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
            lbSetData[_idc, _index, str[_class, str _object, str _x]];
        };
    } forEach RPP_var_keyChain;
    
    lbSetCurSel[3,0];

    
    _storageSize = _object call RPP_fnc_getTrunkSize;
    _invSize = [] call RPP_fnc_getInvSize;
    _storageMax = _object getVariable "maxSize";
    
    ((findDisplay 500) displayCtrl 5) ctrlSetStructuredText parseText format["<t color='#4876FF'>Storage Size: %1/%2 sz</t>", _storageSize, _storageMax];
    ((findDisplay 500) displayCtrl 4) ctrlSetStructuredText parseText format["<t color='#4876FF'>Inventory Size: %1/%2 sz</t>", _invSize, RPP_var_inventorySize];
};

RPP_fnc_trunkTake = 
{
    private ["_data", "_amount", "_itemClass", "_object", "_maxSize", "_size", "_params", "_type", "_invSize", "_totalSize"];
    _data = call compile (lbData [2,lbCurSel 2]);
    _amount = parseNumber ctrlText 6;
    _itemClass = _data select 0;
    _object = call compile (_data select 1);
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
      
    if (isNil "_object") then
    {
        _object = (_data select 1);
        _object = _object call RPP_fnc_findVehicle;
    };
    
    if (([_object, _itemClass] call RPP_fnc_getTrunkItemAmount) < _amount) exitWith
    {
        _object call RPP_fnc_loadStorage;
    };
    
    _maxSize = _object getVariable "maxSize";
    _size = _itemClass call RPP_fnc_itemGetMass;
    _params = [];
    _type = _itemClass call RPP_fnc_itemGetType1;
    _ok = false;
    
    if (_maxSize <= 0) then
    {
        _maxSize = 999999999;
    };
    
    if (count _data >= 3) then
    {
        _params = _data select 2;
        _size = _size + ([_params, "weight"] call RPP_fnc_trunkGetParamVar);
    };

    if (_type == "WEAPON" or _type == "VEHICLE") then
    {
        _amount = 1;
    };
    
    if (((RPP_var_timeSinceLastUsedTrunk)+RPP_var_timeUntilCanUseTrunk) > time) exitWith
    {
        localize "STRS_storage_alreadyUsing" call RPP_fnc_hint;
    };

    _invSize = [] call RPP_fnc_getInvSize;   
    _totalSize = _invSize + (_size * _amount);
    
    if (_type == "WEAPON" or _type == "VEHICLE" or _type == "MAGAZINE") then
    {
        _totalSize = 0;
    };
    
    if (_totalSize > RPP_var_inventorySize) exitWith
    {
        /* Would be overweight */ 
        (localize "STRS_storage_takeMaxSize") call RPP_fnc_hint;
    };  
    
    if (_type == "VEHICLE") then 
    {
        _ok = false;
        /* First we pull all the variables */
        _vclName = [_params, "name"] call RPP_fnc_trunkGetParamVar;
        _trunk = [_params, "trunk"] call RPP_fnc_trunkGetParamVar;
        _fuel = [_params, "fuel"] call RPP_fnc_trunkGetParamVar;
        _damage = [_params, "damage"] call RPP_fnc_trunkGetParamVar;
        
        /* Search for vehicle in array */
        _storage = _object getVariable "trunk";
        _i = 0;
        {
            if (_x select 0 == _itemClass) then /* Possible match, check name */
            {
                _arr = (_x select 2);
                _foundName = [_arr, "name"] call RPP_fnc_trunkGetParamVar;
                if (_foundName == _vclName) exitWith /* We have a match on the name */
                {
                    _storage set[_i, "REMOVE"]; /* Prep for removal */
                };
            };
            
            _i = _i + 1;
        } forEach _storage;
        _storage = _storage - ["REMOVE"]; /* Remove from array */
        
        /* Update trunk */
        _object setVariable ["trunk", _storage, _object getVariable "isPublic"];
        
        /* Create vehicle */
        [_itemClass, getpos _object, _trunk, _vclName, [_fuel, _damage]] call RPP_fnc_createVehicle;  
        _ok = true;
    };
    
    if (_type == "MAGAZINE") then
    {
        _type2 = _itemClass call RPP_fnc_itemGetType2;
        _count = [_type2, player] call RPP_fnc_getMagazineCount;
        _max = 0;
        _ok = false;
        if (_type2 == "RIFLE") then
        {
            _max = 12;
        }
        else
        {
            _max = 8;
        };
        
        if (_count+_amount > _max) then
        {
            _ok = false;
            localize "STRS_storage_tooManyMags" call RPP_fnc_hint;
        }
        else
        {
            _ok = true;
            
            _i = 0;
            while {_i < _amount} do
            {
                player addMagazine _itemClass;
                _i = _i + 1;
            };
            
            [_object, _itemClass, -_amount] call RPP_fnc_addStorageItem;
        };
    };
    
    if (_type == "WEAPON") then
    {
        _ok = false;
        _type2 = _itemClass call RPP_fnc_itemGetType2;
        
        if ((not([player,"PISTOL"] call RPP_fnc_hasWeaponType)) && _type2 == "PISTOL") then
        {
            _ok = true;
        }
        else
        {
            if ((not([player,"RIFLE"] call RPP_fnc_hasWeaponType)) && _type2 == "RIFLE") then
            {
                _ok = true;
            };
        };

		if (_type2 == "ITEM") then {
			_ok = true;
		};

        if (_ok) then /* Add the weapon to the player */
        {
            player addweapon _itemClass;
            [_object, _itemClass, -_amount] call RPP_fnc_addStorageItem;
        }
        else /* Display reason why player cannot take */
        {
            if (_type2 == "PISTOL") then 
            {
                localize "STRS_storage_pistolAlready" call RPP_fnc_hint;  
            }
            else
            {
                localize "STRS_storage_rifleAlready" call RPP_fnc_hint;  
            };
        };
    };
    
    if (_type == "ITEM") then
    {
        [_itemClass, _amount] call RPP_fnc_addInventoryItem;
        [_object, _itemClass, -_amount] call RPP_fnc_addStorageItem;
        _ok = true;
    };
    
    if (_ok) then /* Display message on success */
    {
        RPP_var_timeSinceLastUsedTrunk = time;
        (format[localize "STRS_storage_takeItem", _amount, _itemClass call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        
        if (vehicle player == player) then
        {
            ["RPP_fnc_serverSwitchAnimation", [player, "AinvPknlMstpSlayWrflDnon_AmovPercMstpSnonWnonDnon"]] call RPP_fnet_execPublic;
        };
    };
    
    
    _object call RPP_fnc_loadStorage;
};

RPP_fnc_trunkGetParamVar = 
{
    private ["_arr", "_var", "_return"];
    _arr = _this select 0;
    _var = _this select 1;
    _return = 0;
    
    {
        if (_x select 0 == _var) exitWith
        {
            _return = (_x select 1);
        };
    } forEach _arr;
    
    
    _return
};

RPP_fnc_trunkDrop = 
{
    private ["_data", "_amount", "_itemClass", "_object", "_vcl", "_maxSize", "_size", "_type"];
    _data = call compile (lbData [3,lbCurSel 3]);
    _amount = parseNumber ctrlText 6;
    _itemClass = _data select 0;
    _object = call compile (_data select 1);
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
    
    if (isNil "_object") then
    {
        _object = (_data select 1);
        _object = _object call RPP_fnc_findVehicle;
    };
    
    if (typeOf _object == "SUITCASE") exitWith
    {
        (localize "STRS_storage_cantDropInto") call RPP_fnc_hint;
    };

    _vcl = player;
    _maxSize = _object getVariable "maxSize";
    _size = _itemClass call RPP_fnc_itemGetMass;
    _ok = false;
    _type = _itemClass call RPP_fnc_itemGetType1;
    
    if (((_itemClass call RPP_fnc_itemGetAmount) < _amount) && (_type == "ITEM")) exitWith
    {
        _object call RPP_fnc_loadStorage;
    };
    
    if (_maxSize <= 0) then
    {
        _maxSize = 999999999;
    };
    
    if (count _data >= 3) then
    {
        _vcl = (_data select 2) call RPP_fnc_getVehicle;
        _size = _size + (_vcl call RPP_fnc_getTrunkSize);
    };
    
    if (_type == "WEAPON" or _type == "VEHICLE") then
    {
        _amount = 1;
    };
    
    if (((RPP_var_timeSinceLastUsedTrunk)+RPP_var_timeUntilCanUseTrunk) > time) exitWith
    {
        localize "STRS_storage_alreadyUsing" call RPP_fnc_hint;
    };
    
    if (_amount < 1) then
    {
        _amount = 1;
    };
    
    _trunkSize = _object call RPP_fnc_getTrunkSize;
    _totalSize = _trunkSize + (_size * _amount);
    
    if (_totalSize > _maxSize) exitWith 
    {
        localize "STRS_storage_maxCapacity" call RPP_fnc_hint;
    };
    
    if (_type == "VEHICLE") then 
    {
        if (player distance _vcl <= 20 && (alive _vcl)) then
        {
            _params = [ ["damage", damage _vcl], ["fuel", fuel _vcl], ["name", str _vcl], ["trunk", _vcl getVariable "trunk"], ["weight", (_vcl call RPP_fnc_getTrunkSize)]  ];

            [_vcl, 0] call RPP_fnc_serverDelVehicle;
            _vcl call RPP_fnc_addToKeychain;

            [_object, _itemClass, _amount, _params] call RPP_fnc_addStorageItem;
            _ok = true;
            
        };
    };
    
    if (_type == "MAGAZINE") then 
    {
        if ([_itemClass, player] call RPP_fnc_getMagazineAmount >= _amount) then 
        {
            _i = 0;
            while {_i < _amount} do
            {
                player removeMagazine _itemClass;
                _i = _i + 1;
            };
            
            [_object, _itemClass, _amount] call RPP_fnc_addStorageItem;
            _ok = true;
        }
        else 
        {
            (format[localize "STRS_storage_notEnough", _itemClass call RPP_fnc_itemGetName, _amount]) call RPP_fnc_hint;
        };
    };
    
    if (_type == "WEAPON") then 
    {
        if ([player, _itemClass] call RPP_fnc_hasWeaponClass) then
        {
            player removeWeapon _itemClass;
            [_object, _itemClass, _amount] call RPP_fnc_addStorageItem;
            _ok = true;
        };
    };
    
    if (_type == "ITEM") then 
    {
        _hasAmount = _itemClass call RPP_fnc_itemGetAmount;
        
        if (_hasAmount >= _amount) then
        {
            [_itemClass, -(_amount)] call RPP_fnc_addInventoryItem;
            [_object, _itemClass, _amount] call RPP_fnc_addStorageItem;
            _ok = true;
        }
        else 
        {
            (format[localize "STRS_storage_notEnough", _itemClass call RPP_fnc_itemGetName, _amount]) call RPP_fnc_hint;
        };
    };
    
    if (_ok) then
    {
         RPP_var_timeSinceLastUsedTrunk = time;
         
         if (vehicle player == player) then
         {
            ["RPP_fnc_serverSwitchAnimation", [player, "AinvPknlMstpSlayWrflDnon_AmovPercMstpSnonWnonDnon"]] call RPP_fnet_execPublic;
         };
        (format[localize "STRS_storage_dropItem", _amount, _itemClass call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    };
    
    _object call RPP_fnc_loadStorage;
};

RPP_fnc_addStorageItem = 
{
    private ["_object", "_itemClass", "_amount", "_params", "_type", "_trunk", "_found", "_skip", "_ok", "_maxSize", "_isPublic"];
    _object = _this select 0;
    
    if (typeName _object == "STRING") then
    {
        _object = _object call RPP_fnc_findVehicle;
    };
    
    _itemClass = _this select 1;
    _amount = _this select 2;
    _params = [];
    _type = _itemClass call RPP_fnc_itemGetType1;
    _ok = false;
    _maxSize = _object getVariable "maxSize";
    
    if (_maxSize <= 0) then
    {
        _maxSize = 999999999;
    };
    
    if (count _this >= 4) then
    {
        _params = (_this select 3);
    };
    
    _trunk = _object getVariable "trunk";
    _found = false;
    _skip = false;
    
    if (_type == "VEHICLE") then
    {
        _skip = true;
    };
    
    if (not _skip) then
    {
        _i = 0;
        _trunkWeight = _object call RPP_fnc_getTrunkSize;
        {
            _class = _x select 0;
            _trunkAmount = _x select 1;
            _itsWeight = _class call RPP_fnc_itemGetMass;
            if (_class == _itemClass) exitWith
            {
                _found = true;
                if (((_itsWeight * _amount)+_trunkWeight) > _maxSize) then
                {
                    _ok = false;
                }
                else
                {
                    _x set[1, (_trunkAmount) + _amount];
                    
                    if ((_x select 1) <= 0) then
                    {
                        _trunk set[_i, "REMOVE"];
                    };
                    _ok = true;
                };
            };
            _i = _i + 1;
        } forEach _trunk;
        _trunk = _trunk - ["REMOVE"];
    };
    
    if (not _found) then
    {
        _trunk set[(count _trunk), [_itemClass, _amount, _params]];
        _ok = true;
    };
    
    _isPublic = (_object getVariable "isPublic");
    
    if ((!(_object isKindOf "AllVehicles")) and (!(typeOf _object in ["Suitcase"]))) then
    {
        if (_isPublic) then
        {
            [RPP_var_saving_tablePublicTrunk, [_object], [ [_trunk, "trunk"] ]] call RPP_fsav_clientRequestSave;
        }
        else
        {
            [RPP_var_saving_tableLocalTrunk, [str _object, RPP_var_acc_login], [ [_trunk, "trunk"] ]] call RPP_fsav_clientRequestSave;
        };
    };
    
    _object setVariable ["trunk", _trunk, (_object getVariable "isPublic")];
    _ok
};

RPP_fnc_getTrunkItemAmount = 
{
    private ["_object", "_class", "_amount"];
    _object = _this select 0;
    _class = _this select 1;
    _amount = 0;
    
    {
        if (_x select 0 == _class) exitWith
        {
            _amount = (_x select 1); 
        };
    } forEach (_object getVariable "trunk");

    _amount
};

RPP_fnc_getTrunkSize = 
{
    private ["_object", "_amount", "_class", "_type", "_size", "_amount", "_arr"];
    _object = _this;
    _amount = 0;
    _arr = [];
    
    if (typeName _object == "OBJECT") then
    {
        _arr = (_object getVariable "trunk");
    }
    else
    {
        _arr = _object;
    };
    
    {
        _class = (_x select 0);
        _type = _class call RPP_fnc_itemGetType1;
        _size = _class call RPP_fnc_itemGetMass;
        _amount = _amount + ((_x select 1) * _size);
        
        if (_type == "VEHICLE") then
        {
            _amount = _amount + (([(_x select 2), "trunk"] call RPP_fnc_trunkGetParamVar) call RPP_fnc_getTrunkSize);
        };
    } forEach _arr;

    _amount
};

RPP_fnc_setupStorages = 
{
    {
        _name = _x select 1;
        _id = [] call RPP_fnc_generateID;
        _obj = _x select 0;
        
        _text = format["<t size='0.55' color='#AA6600'>%1</t><br/><t size='0.4'>(Press F to open)<br/></t>", _name, _price];
        _onKeyAccess = "";
        
        _onAdd = format[
        '
            [%2, "%1", %3, 0.9, 20, false] call RPP_fnc_create3DText;
            [%3] spawn
            {
                _onTarget = false;
                while {player distance (_this select 0) <= 20} do
                {
                    if (cursorTarget == (_this select 0)) then
                    {
                        [33, "[%3] call RPP_fnc_openStorage;", false, false, false] spawn RPP_fnc_addKeyAction;
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            [33, false, false, false] spawn RPP_fnc_remKeyAction;
                        };
                    };
                    sleep 0.001;
                };
                [33, false, false, false ] spawn RPP_fnc_remKeyAction;
            };

        ', _text, _id, _obj];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 20)', _obj], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_storages;
};