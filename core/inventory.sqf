/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_inventory = [ ["Keychain", 1] ];
RPP_var_inventorySize = 150;

/* Open the inventory dialog */
RPP_fnc_openInventory =
{
    private ["_h"];
    
    if (!isNull(findDisplay 200)) exitWith
    {
        closeDialog 0;
    };
    
    _h = createDialog "RPP_Dlg_Inventory";
    
    
    [] call RPP_fnc_invSelChanged;
    lbSetCurSel[2,0];
};

/* New inventory item selected, do not call manually outside of inventory */
RPP_fnc_invSelChanged = 
{
    private ["_index", "_data", "_itemClass", "_itemDesc", "_itemName", "_amount"];
    _index = lbCurSel 2;
    
    if (_index < 0) exitWith
    {
        2 call RPP_fnc_populateInventory;
    };
    
    _data = call compile (lbData [2, _index]);
    _itemClass = _data select 0;
    _itemDesc = _itemClass call RPP_fnc_itemGetDesc;
    _itemName = _itemClass call RPP_fnc_itemGetName;
    _amount = _itemClass call RPP_fnc_itemGetAmount;
    _invSize = [] call RPP_fnc_getInvSize;
    
 
    
    2 call RPP_fnc_populateInventory;
   ((findDisplay 200) displayCtrl 3) ctrlSetStructuredText parseText format["<t size='0.96'>Description of %3</t><br/>%1<br/>You have: %2x", _itemDesc, _amount, _itemName];
   ((findDisplay 200) displayCtrl 5) ctrlSetStructuredText parseText format["<t color='#4876FF'>Inventory Size: %1/%2 sz</t>", _invSize, RPP_var_inventorySize];
};

RPP_fnc_removeIllegalItems = 
{
    {
        _class = _x select 0;
        _amount = _x select 1;
        _illegal = _class call RPP_fnc_itemGetIllegal;
        
        if (_illegal) then
        {
            [_class,-(_amount)] call RPP_fnc_addInventoryItem;
        };
    } forEach RPP_var_inventory;
};

/* Populate inventory dialog, do not call manually outside of inventory */
RPP_fnc_populateInventory = 
{
    private ["_idc"];
    _idc = _this;
    _curSel = lbCurSel 2;
    
    lbClear 2;
    {
        private ["_class", "_name", "_amount", "_mass", "_totalMass", "_index"];
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = _mass * _amount;
        _index = lbAdd[_idc, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
        lbSetData[_idc, _index, str[_class]];
    } forEach RPP_var_inventory;
    
    if (count RPP_var_inventory <= 0) exitWith {}; 
};

/* Use button in inventory */
RPP_fnc_inventoryUse =
{
    private ["_data", "_itemClass", "_itemDesc", "_itemName", "_amount", "_playerAmount"];
    _data = call compile (lbData [2,lbCurSel 2]);
    _itemClass = _data select 0;
    _itemDesc = _itemClass call RPP_fnc_itemGetDesc;
    _itemName = _itemClass call RPP_fnc_itemGetName;
    _amount = round(parseNumber(ctrlText 4));
    _playerAmount = _itemClass call RPP_fnc_itemGetAmount;
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
    
    if (_playerAmount >= _amount) then
    {
        closeDialog 0;
        [_itemClass, _amount] call RPP_fnc_useInventoryItem;
    }
    else
    {
        (format["<t color='#4876FF'>Inventory</t><br/>You only have %1x of <t color='#009900'>%2</t> and cannot use %3x of it.", _playerAmount, _itemName, _amount]) call RPP_fnc_hint;
    };
};

/* Drop inventory item */
RPP_fnc_inventoryDrop = 
{
    private ["_data", "_itemClass", "_itemDesc", "_itemName", "_amount", "_playerAmount"];
    _data = call compile (lbData [2,lbCurSel 2]);
    _itemClass = _data select 0;
    _itemDesc = _itemClass call RPP_fnc_itemGetDesc;
    _itemName = _itemClass call RPP_fnc_itemGetName;
    _amount = round(parseNumber(ctrlText 4));
    _playerAmount = _itemClass call RPP_fnc_itemGetAmount;
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
    
    if (_playerAmount >= _amount) then
    {
        if (_itemClass call RPP_fnc_itemGetCanDrop) then
        {
            closeDialog 0;
            
            if (vehicle player == player) then
            {
                ["RPP_fnc_serverSwitchAnimation", [player, "AinvPknlMstpSlayWrflDnon_AmovPercMstpSnonWnonDnon"]] call RPP_fnet_execPublic;
            };
            (format[localize "STRS_inventory_drop", _amount, _itemName]) call RPP_fnc_hint;
            [_itemClass, -_amount] call RPP_fnc_addInventoryItem;
            [[[_itemClass, _amount]], position (vehicle player)] spawn RPP_fnc_dropItem;
        }
        else
        {
            "<t color='#4876FF'>Inventory</t><br/>This item is not droppable." call RPP_fnc_hint;
        };
    }
    else
    {
        (format["<t color='#4876FF'>Inventory</t><br/>You only have %1x of <t color='#009900'>%2</t> and cannot drop %3x of it.", _playerAmount, _itemName, _amount]) call RPP_fnc_hint;
    };
};

/* Use inventory item */
RPP_fnc_useInventoryItem =
{
    private ["_class", "_amount", "_script"];
    _class = _this select 0;
    _amount = _this select 1;
    _script = _class call RPP_fnc_itemGetScript;

    [_class, _amount] execVM _script;
};

/* Add inventory item to player if not over weight */
RPP_fnc_addInventoryItem = 
{
    private ["_class", "_amount", "_exists", "_return", "_invSize", "_itemSize", "_totalSize"];
    _class = _this select 0;
    _amount = _this select 1;
    _exists = false;
    _return = false;
    _invSize = [] call RPP_fnc_getInvSize;
    _itemSize = _class call RPP_fnc_itemGetMass;
    _totalSize = ((_amount * _itemSize)+_invSize);

    if (_totalSize > RPP_var_inventorySize) exitWith
    {  
        _return
    };
 
    _index = 0;
    {
        if ((_x select 0) == _class) exitWith
        {
            _exists = true;
            _x set[1, ((_x select 1) + _amount)];
            _return = true;
            
            if (_x select 1 <= 0) then
            {
                RPP_var_inventory set[_index, "REMOVE"];
                RPP_var_inventory = RPP_var_inventory - ["REMOVE"];
                _return = true;
            };
        };
        _index = _index + 1;
    } forEach RPP_var_inventory;
    
    if (not _exists) then 
    {
        RPP_var_inventory set[(count RPP_var_inventory), [_class,_amount]];
        _return = true;
    };
    
    ["RPP_var_inventory", RPP_var_inventory] call RPP_var_saving_saveVar;
    _return
};

/* Get sum of all inventory items mass */
RPP_fnc_getInvSize = 
{
    private ["_size", "_class", "_amount"];
    _size = 0; 
    {
        _class = _x select 0;
        _amount = _x select 1;
        
        if (_amount > 0) then
        {
            _mass = _class call RPP_fnc_itemGetMass;
            _totalMass = _mass * _amount;

            _size = _size + _totalMass;
        };
    } forEach RPP_var_inventory;

    _size
};

RPP_fnc_dropItem = 
{
    private ["_items", "_class", "_position", "_trunk", "_vcl"];
    _items = _this select 0;
    _class = "Suitcase";
    _position = _this select 1;
    _trunk = _items;
    _vcl = empty;
    _text = "<t size='0.65' color='#4876FF'>Items</t><br/><t size='0.45'>(Press F to open)</t><br/>";
    _id = [] call RPP_fnc_generateID;
       
    call compile format
    ['
        _vcl = "%1" createVehicle %2;
        _vcl setVehicleInit "this setVehicleVarName ""%3"";

        [this, ""%4"", %6] spawn
        {
            if (isNil ""RPP_fnc_create3DText"") then
            {
                _script = [] execVM ""core\text3D.sqf"";
                waitUntil {scriptDone _script};
            };

            [(_this select 2), (_this select 1), (_this select 0), 0.8, 5, true] spawn RPP_fnc_create3DText;
        };

        _vcl = this;
        _vcl setVariable [""hasActions"", true, false];
        ";
        player reveal _vcl;
        
        _vcl setpos %2;

        _vcl setVariable ["locked", false, true];
        _vcl setVariable ["trunk",  %5, true];
        _vcl setVariable ["maxSize", 0, true];
        _vcl setVariable ["isPublic", true, true];
        _vcl setpos %2;
        _vcl setPos (vehicle player modelToWorld [0,1,0]);

        processInitCommands; 
    ', _class, _position, [] call RPP_fnc_generateRegistration, _text, _trunk, _id];
    
    ["RPP_fnc_serverItemManager", [_vcl, 3000, _id]] spawn RPP_fnet_execPublic;
};

RPP_fnc_serverItemManager = 
{
    if (not isServer) exitWith {};
    
    _this spawn
    {
        private ["_vcl", "_despawnTime", "_ticks", "_id"];
        _vcl = (_this select 0);
        _despawnTime = (_this select 1);
        _id = (_this select 2);

        _ticks = 0;
        while {alive _vcl} do
        {
            _trunk = _vcl getVariable "trunk";

            if ((_ticks >= _despawnTime) || (count _trunk <= 0)) then /* Delete storage */
            {
                /* Disable text */
                _id call RPP_fnc_disable3DText;
                [_vcl, 0] call RPP_fnc_serverDelVehicle;
            };

            _ticks = _ticks + 1;
            sleep 1;
        };
    };
};