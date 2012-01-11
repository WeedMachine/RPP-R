RPP_fnc_trading_open = 
{
    private ["_unit"];
    _unit = _this;

    createDialog "RPP_Dlg_Trade";
    
    if (count RPP_var_inventory <= 0) exitWith { closeDialog 0; localize "STRS_trading_noInventory" call RPP_fnc_hint; }; 
    
    ((findDisplay 1200) displayCtrl 1203) ctrlSetStructuredText parseText format["Trading with %1", name _unit];
    buttonSetAction[1602, format["%1 call RPP_fnc_trading_add;", _unit]];
    buttonSetAction[1603, format["%1 call RPP_fnc_trading_remove;", _unit]];
    buttonSetAction[1600, format["%1 call RPP_fnc_trading_sendItems;", _unit]];
    
    player setVariable ["trading", [], false];
    _unit call RPP_fnc_trading_load;
};

RPP_fnc_trading_load = 
{
    private ["_unit"];
    _unit = _this;
    
    lbClear 1500;
    {
        private ["_class", "_name", "_amount", "_mass", "_totalMass", "_index"];
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _mass = _class call RPP_fnc_itemGetMass;
        _totalMass = _mass * _amount;
        if (_class call RPP_fnc_itemGetCanDrop) then
        {
            _index = lbAdd[1500, format["%1, %2x, %3/%4 sz", _name, _amount, _mass, _totalMass]];
            lbSetData[1500, _index, str[_class]];
        };
    } forEach RPP_var_inventory;
    
    lbClear 1501;
    {
        _class = (_x select 0);
        _amount = (_x select 1);
        _name = _class call RPP_fnc_itemGetName;
        
        _index = lbAdd[1501, format["%1, %2x", _name, _amount]];
        lbSetData[1501, _index, str[_class]];
    } forEach (player getVariable "trading");
    
    /* Update description */
    ((findDisplay 1200) displayCtrl 1204) ctrlSetStructuredText parseText format
    ["You are trading with %1, you can give him items by selecting the item you want to send in your inventory and using the add button, when you are finished adding all the items you wish to send then use the send button.<br/>Items giving size %2sz.<br/>Your inventory size is %3sz<br/>
    ", name _unit, (player getVariable "trading") call RPP_fnc_trading_getSendWeight, [] call RPP_fnc_getInvSize];
};

RPP_fnc_trading_clientReceiveItems = 
{
    private ["_to", "_from", "_items"];
    _to = _this select 0;
    _from = _this select 1;
    _items = _this select 2;
    
    if (player != _to) exitWith {};
    
    _invSize = [] call RPP_fnc_getInvSize;
    _itemSize = _items call RPP_fnc_trading_getSendWeight;
    
    if ((_invSize + _itemSize) > RPP_var_inventorySize) exitWith
    {
        (format[localize "STRS_trading_receivedfull", name _from]) call RPP_fnc_hint;
        ["RPP_fnc_trading_rejected", [_from]] call RPP_fnet_execPublic;
    };
    
    {
        [(_x select 0), (_x select 1)] call RPP_fnc_addInventoryItem;
    } forEach _items;
    
    (format[localize "STRS_trading_received", name _from]) call RPP_fnc_hint;
    ["RPP_fnc_trading_accepted", [_from, _items]] call RPP_fnet_execPublic;

};

RPP_fnc_trading_rejected = 
{
    private ["_unit"];
    _unit = _this select 0;
    
    if (player != _unit) exitWith {};
    
    localize "STRS_trading_rejected" call RPP_fnc_hint;
};

RPP_fnc_trading_accepted = 
{
    private ["_unit", "_items"];
    _unit = _this select 0;
    _items = _this select 1;
    
    if (player != _unit) exitWith {};
    
    localize "STRS_trading_accepted" call RPP_fnc_hint;
    
    {
        [(_x select 0), -(_x select 1)] call RPP_fnc_addInventoryItem;
    } forEach _items;
};

RPP_fnc_trading_sendItems = 
{
    private ["_unit", "_items"];
    _unit = _this;
    _items = player getVariable "trading";
    
    if (count _items <= 0) exitWith { closeDialog 0; };
    
    if (alive _unit && (_unit distance player <= 7)) then
    {
        ["RPP_fnc_trading_clientReceiveItems", [_unit, player, _items]] call RPP_fnet_execPublic;
    }
    else
    {
        //Too far or not alive
        localize "STRS_trading_tooFar" call RPP_fnc_hint;
    };

    closeDialog 0;
};

RPP_fnc_trading_getSendWeight = 
{
    private ["_size", "_array"];
    _size = 0;
    _array = _this;
    
    {
        _class = _x select 0;
        _amount = _x select 1;
		_mass = _class call RPP_fnc_itemGetMass;

		if (_mass > 0) then { 
        	_size = _size + ((_class call RPP_fnc_itemGetMass) * (_amount));
		};
    } forEach (_array);

    _size
};

RPP_fnc_trading_remove = 
{
    //TODO: Add a addTradingItem function to remove duplicate code.
    private ["_unit", "_data", "_amount", "_class", "_itemAmount", "_giving"];
    _unit = _this;
    _data = (call compile lbData[1500, lbCurSel 1500]);
    _amount = parseNumber ctrlText 1400;
    _class = _data select 0;
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
    
    if (_amount == 0) exitWith
    {
        _unit call RPP_fnc_trading_load;
    };
    
    _giving = player getVariable "trading";
    {
        _itemClass = _x select 0;
        _itemAmount = _x select 1;
        
        if (_itemClass == _class) exitWith
        {
            if (_itemAmount >= _amount) then
            {
                _x set[1, _itemAmount-_amount];
                //[_class, (_amount)] call RPP_fnc_addInventoryItem;
                
                if ((_x select 1) <= 0) then
                {
                    _giving set[_forEachIndex, "REMOVE"];
                };
            };
            _found = true;          
        };
    } forEach _giving;
    _giving = _giving - ["REMOVE"];
    
    player setVariable ["trading", _giving, false];

    _unit call RPP_fnc_trading_load;
};

RPP_fnc_trading_add = 
{
    private ["_unit", "_data", "_amount", "_class", "_itemAmount", "_giving", "_found"];
    _unit = _this;
    _data = (call compile lbData[1500, lbCurSel 1500]);
    _amount = parseNumber ctrlText 1400;
    _class = _data select 0;
    
    if (_amount < 0) then
    {
        _amount = abs(_amount);
    };
    
    _itemAmount = _class call RPP_fnc_itemGetAmount;
    
    if ((_itemAmount < _amount) || (_amount == 0)) exitWith
    {
        _unit call RPP_fnc_trading_load;
    };
    
    _giving = player getVariable "trading";
    _found = false;
    {
        _itemClass = _x select 0;
        _itemAmount = _x select 1;
        
        if (_itemClass == _class) exitWith
        {
            _x set[1, _itemAmount+_amount];
            _found = true;
            
                   
        };
    } forEach _giving;
    
    if !(_found) then
    {
        _giving set[(count _giving), [_class, _amount]];
    };
    
    player setVariable ["trading", _giving, false];
   // [_class, -(_amount)] call RPP_fnc_addInventoryItem;
    
    _unit call RPP_fnc_trading_load;
};