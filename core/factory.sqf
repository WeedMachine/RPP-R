/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_RPP_var_itemFactory = 
[
    ["Pump", ["manufacture", 1, 280]],
	["Pickaxe", ["manufacture", 1, 280]],
    ["Hatchet", ["manufacture", 1, 280]],
	["Pump", ["manufacture", 20, 980]],
	["Shovel", ["manufacture", 1, 280]],
	["RepairKit", ["manufacture", 30, 1400]],
	["Can", ["manufacture", 1, 280]],
	["Harpoon", ["manufacture", 25, 1240]],
	["Fishing_net", ["manufacture", 20, 980]],
	["ACRE_PRC148_UHF", ["manufacture", 20, 980]],
    ["Fishing_rod", ["manufacture", 15, 900]]
];

_ALR_var_carFactory = 
[
	//Cars
	["Skoda", ["manufacture", 8, 750]],
	["SkodaRed", ["manufacture", 8, 750]],
	["SkodaBlue", ["manufacture", 8, 750]],
	["SkodaGreen", ["manufacture", 8, 750]],
	["VWGolf", ["manufacture", 15, 900]],
	["car_hatchback", ["manufacture", 10, 820]],
	["car_sedan", ["manufacture", 10, 820]],
	["Lada1_TK_CIV_EP1", ["manufacture", 10, 820]],
	["Lada2_TK_CIV_EP1", ["manufacture", 10, 820]],
	["Volha_1_TK_CIV_EP1", ["manufacture", 10, 820]],
	["Volha_2_TK_CIV_EP1", ["manufacture", 10, 820]]
];

_ALR_var_bikeFactory = 
[	
	//Bikes
	["Old_bike_TK_CIV_EP1", ["manufacture", 1, 280]],
	["MMT_Civ", ["manufacture", 1, 280]],
	["Old_moto_TK_Civ_EP1", ["manufacture", 1, 280]],
	["M1030", ["manufacture", 1, 280]],
	["TT650_Civ", ["manufacture", 1, 280]],
	["TT650_Gue", ["manufacture", 1, 280]],
	["TT650_TK_CIV_EP1", ["manufacture", 1, 280]],
	["ATV_US_EP1", ["manufacture", 5, 400]]
	
];

_ALR_var_truckFactory = 
[	
	//Trucks
	["Kamaz", ["manufacture", 40, 1650]],
	["KamazOpen", ["manufacture", 40, 1650]],
	["UralCivil", ["manufacture", 30, 1400]],
	["UralCivil2", ["manufacture", 30, 1400]],
	["UralOpen_INS", ["manufacture", 30, 1400]],
	["MTVR", ["manufacture", 45, 2250]],
	["V3S_Salvage_TK_GUE_EP1", ["manufacture", 30, 1400]],
	
	//Pickups
	["datsun1_civil_1_open", ["manufacture", 20, 980]],
	["datsun1_civil_2_covered", ["manufacture", 20, 980]],
	["datsun1_civil_3_open", ["manufacture", 20, 980]],
	["hilux1_civil_1_open", ["manufacture", 25, 1240]],
	["hilux1_civil_2_covered", ["manufacture", 25, 1240]],
	["hilux1_civil_3_open", ["manufacture", 25, 1240]],
	["LandRover_CZ_EP1", ["manufacture", 20, 980]],
	["LandRover_TK_CIV_EP1", ["manufacture", 20, 980]]
	
];

_ALR_var_manufacturingPlant =
[
	["Tyre", ["manufacture", 20, 980]],
	["RefuelCan", ["manufacture", 20, 980]],
	["AdvChipset", ["manufacture", 40, 1650]],
	["ElecComp", ["manufacture", 20, 980]],
	["Plank", ["manufacture", 1, 280]],
	["Beam", ["manufacture", 5, 400]]
];

_ALR_var_airFactory =
[
	["usec_bell206_2", ["manufacture", 70, 4250]],
	["qantas_C130", ["manufacture", 60, 6500]],
	["airnz_C130", ["manufacture", 55, 4200]],
	["usec_bell206_1", ["manufacture", 70, 8000]],
	["GNT_C185F", ["manufacture", 45, 2250]]
];

RPP_var_factoryDefine = 
[
    [car_factory, "Car Factory", car_factory_storage, _ALR_var_carFactory],
	[bike_factory, "Bike Factory", bike_factory_storage, _ALR_var_bikeFactory],
	[heavy_factory, "Heavy Vechile Factory", heavy_car_factory_storage, _ALR_var_truckFactory],
	[item_factory, "Item Factory", item_factory_storage, _RPP_var_itemFactory],
	[air_factory, "Air Factory", air_factory_storage, _ALR_var_airFactory],
	[manufacturing_plant, "Manufacturing Plant", manufacturing_plant_storage, _ALR_var_manufacturingPlant]
];

RPP_fnc_openFactory =
{
    private ["_dlg", "_obj"];
    _obj = _this;

    if (!isNull(findDisplay 550)) exitWith
    {
        closeDialog 0;
    };
    
    _dlg = createDialog "RPP_Dlg_FactoryManufacturing";
    
    ((findDisplay 550) displayCtrl 1) ctrlSetStructuredText parseText format["%1 - Manufacturing", _obj call RPP_fnc_factoryGetName];
    
    _obj call RPP_fnc_factoryLoadStorage;
    _obj call RPP_fnc_factoryLoadManufacture;
    _obj call RPP_fnc_factoryLoadQue;
    
};

RPP_fnc_factoryGetItemAmount = 
{
    private ["_obj", "_item", "_return"];
    _obj = _this select 0;
    _item = _this select 1;
    _return = 0;
    
    {
        if (_x select 0 == _item) exitWith
        {
            _return = _x select 1;
        };
    
    } forEach (_obj getVariable "stock");
    
    _return
};

RPP_fnc_factoryGetItem = 
{
    private ["_obj", "_item", "_return", "_array"];
    _obj = _this select 0;
    _item = _this select 1;
    _return = [];
    
    _array = _obj call RPP_fnc_factoryGetManufacture;
    {
        if (_x select 0 == _item) exitWith
        {
            _return = _x;
        };
    
    } forEach _array;

    _return
};

RPP_fnc_factory_selectedItem = 
{
    private ["_data", "_item", "_fact", "_reqItems"];
    _data = lbData[7,lbCurSel 7];
    _data = call compile _data;
    _item = _data select 0;
    
    lbClear 13;
    _fact = _item call RPP_fnc_itemGetFactoryCost;
    _reqItems = _fact select 1;
    
    {
        _index = lbAdd[13, format["%1, %2x", (_x select 0) call RPP_fnc_itemGetName, (_x select 1)]];
    } forEach _reqItems;

};

RPP_fnc_factory_transferFrom = 
{
    private ["_data", "_item", "_toTransfer", "_obj", "_storage", "_itemAmount", "_found", "_factory"];
    _data = lbData[12,lbCurSel 12];
    _data = call compile _data;
    
    
    _item = _data select 0;
    _toTransfer = parseNumber ctrlText 6;
    _obj = _data select 1;
    _storage = (_obj call RPP_fnc_factoryGetStorage);
    _itemAmount = [_obj, _item] call RPP_fnc_factoryGetItemAmount;
    
    
    if (_itemAmount <= 0) exitWith
    {
        /* Not enough */
        localize "STRS_factory_transferFail" call RPP_fnc_hint;
    };
    
    if (_toTransfer > _itemAmount) then
    {
        _toTransfer = _itemAmount;
    };
    
    [_obj, _item, -(_toTransfer)] call RPP_fnc_factory_addItem;
    [_storage, _item, (_toTransfer)] call RPP_fnc_addStorageItem;
    
    (format[localize "STRS_factory_transferFrom", _item call RPP_fnc_itemGetName, _toTransfer]) call RPP_fnc_hint;
    
    _obj call RPP_fnc_factoryLoadStorage;
    //_obj call RPP_fnc_factoryLoadManufacture;
    _obj call RPP_fnc_factoryLoadQue;

};

RPP_fnc_factory_manufacture = 
{
     private ["_data", "_item", "_fact", "_reqItems", "_numManufactured", "_Manuamount", "_hasMats", "_storage", "_type", "_itemArray", "_skill", "_exp"];
    _data = lbData[7,lbCurSel 7];
    _data = call compile _data;
    _item = _data select 0;
    _obj = _data select 1;
    _ManuAmount = parseNumber ctrlText 5;
    
    _fact = _item call RPP_fnc_itemGetFactoryCost;
    _reqItems = _fact select 1;
    _numManufactured = _fact select 0;
    _hasMats = true;
    _storage = (_obj call RPP_fnc_factoryGetStorage);
    
    _itemArray = [_obj, _item] call RPP_fnc_factoryGetItem;
    _skill = (_itemArray select 1) select 0;
    _exp = (_itemArray select 1) select 2;
    
    if (_amount <= 0) exitWith
    {
        
    };
    
    _itemNotEnough = "";
    {
        _requiredItem = _x select 0;
        _amount = [_obj, _requiredItem] call RPP_fnc_factoryGetItemAmount;
        _itemAmount = (_x select 1) * (_ManuAmount);
        
        if (_amount < (_x select 1)) exitWith
        {
            _itemNotEnough = _requiredItem;
            _hasMats = false;
        };    
    } forEach _reqItems;
    
    if !(_hasMats) exitWith
    {
        (format[localize "STRS_factory_noMaterials", _itemNotEnough call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    };
    
    {
        [_obj, (_x select 0), -(_x select 1) * (_ManuAmount)] call RPP_fnc_factory_addItem;
    } forEach _reqItems;
    
    _type = _item call RPP_fnc_itemGetType1;
    
    if (_type == "VEHICLE") then
    {
        _i = 1;
        while {_i <= (_ManuAmount * (_fact select 0))} do
        {
            [_item, position player] call RPP_fnc_createVehicle;
            _i = _i + 1;
        };
    }
    else
    {
        [_storage, _item, _ManuAmount * (_fact select 0)] call RPP_fnc_addStorageItem;
    };
    
    (format[localize "STRS_factory_manufacture", _ManuAmount * (_fact select 0), _item call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    
    [_skill, (_exp * _ManuAmount)] call RPP_fnc_increaseSkill;
    
    _obj call RPP_fnc_factoryLoadStorage;
    _obj call RPP_fnc_factoryLoadManufacture;
    _obj call RPP_fnc_factoryLoadQue;

};

RPP_fnc_factory_addItem = 
{
    private ["_obj", "_item", "_amount", "_factory", "_found"];
    _obj = _this select 0;
    _item = _this select 1;
    _amount = _this select 2;
    _factory = _obj getVariable "stock";
    _found = false;
    
    {
        if (_x select 0 == _item) exitWith
        {
            _found = true;
            _x set[1, (_x select 1)+_amount];
            
            if (_x select 1 <= 0) then
            {
                _factory set[_forEachIndex, "REMOVE"];
                _factory = _factory - ["REMOVE"];
            };
        };
    } forEach _factory;
    
    if !(_found) then
    {
        _factory set[(count _factory), [_item, _amount]];
    };
    
    _obj setVariable ["stock", _factory, false];
};

RPP_fnc_factory_transferTo =
{
    private ["_data", "_item", "_toTransfer", "_obj", "_storage", "_itemAmount", "_found", "_factory"];
    _data = lbData[11,lbCurSel 11];
    _data = call compile _data;
    
    _item = _data select 0;
    _toTransfer = parseNumber ctrlText 6;
    _obj = _data select 1;
    _storage = (_obj call RPP_fnc_factoryGetStorage);
    _itemAmount = [_storage, _item] call RPP_fnc_getTrunkItemAmount;
    
    if (_itemAmount <= 0) exitWith
    {
        /* Not enough */
        localize "STRS_factory_transferFail" call RPP_fnc_hint;
    };
    
    if (_toTransfer > _itemAmount) then
    {
        _toTransfer = _itemAmount;
    };
    
    _found = false;
    _factory = (_obj getVariable "stock");
    {
        if (_x select 0 == _item) exitWith
        {
            _x set[1, (_x select 1) + _toTransfer];
            _found = true;
        };
    } forEach (_factory);
    
    if !(_found) then
    {
        _factory set[(count _factory), [_item, _toTransfer]];
    };
    
    _obj setVariable ["stock", _factory, false];
    
    [_storage, _item, -(_toTransfer)] call RPP_fnc_addStorageItem;
    
    (format[localize "STRS_factory_transferTo", _toTransfer, _item call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    
    _obj call RPP_fnc_factoryLoadStorage;
    //_obj call RPP_fnc_factoryLoadManufacture;
    _obj call RPP_fnc_factoryLoadQue;
};

RPP_fnc_factoryLoadQue = 
{
    private ["_obj", "_stock"];
    _obj = _this;
    _stock = _obj getVariable "stock";
    
    lbClear 12;
    {
        _index = lbAdd[12, format["%1, %2x", (_x select 0) call RPP_fnc_itemGetName, _x select 1]];
        lbSetData[12, _index, str[(_x select 0), _obj]];
    } forEach _stock;
    lbSetCurSel[12,0];
};

RPP_fnc_factoryLoadManufacture = 
{
    private ["_obj", "_items"];
    _obj = _this;
    _items = _obj call RPP_fnc_factoryGetManufacture;
    
    lbClear 7;
    {
        _item = _x select 0;
        _skill = (_x select 1) select 0;
        _reqLevel = (_x select 1) select 1;
        _exp = (_x select 1) select 2;
        _level = (_skill call RPP_fnc_getExperience) call RPP_fnc_calculateLevel;
        _skillName = _skill call RPP_fnc_getSkillName;
        _details = _item call RPP_fnc_itemGetFactoryCost;
        
        if (_level >= _reqLevel) then
        {
            _index = lbAdd[7, format["%1, %5x - (%2, Level: %4, Exp: %3)", _item call RPP_fnc_itemGetName, _skillName, _exp, _reqLevel, _details select 0]];
            lbSetData[7, _index, str[_item, _obj]];
        };
    } forEach _items;
    lbSetCurSel[7,0];

};

RPP_fnc_factoryLoadStorage = 
{
    private ["_obj", "_storage", "_size"];
    _obj = _this;
    _storage = (_obj call RPP_fnc_factoryGetStorage);
    _size = _storage call RPP_fnc_getTrunkSize;
    
    ((findDisplay 550) displayCtrl 4) ctrlSetStructuredText parseText format["Storage Size: %1sz", _size];
    
    lbClear 11;
    {
        _item = _x select 0;
        _amount = _x select 1;
        _type = _item call RPP_fnc_itemGetType1;
        _canDrop = _item call RPP_fnc_itemGetCanDrop;
        _text = _item call RPP_fnc_itemGetName;
        
        if (_canDrop && (_type == "ITEM")) then
        {
            _index = lbAdd[11, format["%1, %2x", _text, _amount]];
            lbSetData[11, _index, str [_item, _obj]];
        };
    
    } forEach (_storage getVariable "trunk");
    lbSetCurSel[11,0];

};

RPP_fnc_factoryGetArray = 
{
    private ["_obj", "_return"];
    _obj = _this;
    _return = [];
    
    {
        if (_x select 0 == _obj) exitwith
        {
            _return = _x;
        };
    } forEach RPP_var_factoryDefine;
    
    _return
};

RPP_fnc_factoryGetManufacture = 
{
    ((_this call RPP_fnc_factoryGetArray) select 3);
};

RPP_fnc_factoryGetStorage = 
{
    ((_this call RPP_fnc_factoryGetArray) select 2);
};

RPP_fnc_factoryGetName = 
{
    ((_this call RPP_fnc_factoryGetArray) select 1);
};

RPP_fnc_setupFactories = 
{
    {
        _name = _x select 1;
        _id = [] call RPP_fnc_generateID;
        _obj = _x select 0;
        
        _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to Manufacture)<br/></t>", _name];
        _onKeyAccess = "";
        _obj setVariable["stock", [], false];
        
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
                        [33, "%3 call RPP_fnc_openFactory;", false, false, false] spawn RPP_fnc_addKeyAction;
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            [33, false, false, false ] spawn RPP_fnc_remKeyAction;
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
    } forEach RPP_var_factoryDefine
};