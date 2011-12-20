_class = _this select 0;
_amount = _this select 1;
_fillThirst = 0;
_text = "";
_addItem = "";
_addItemAmount = 0;

if (_class call RPP_fnc_itemGetAmount < _amount) exitWith 
{
    localize "STRS_drink_notEnough" call RPP_fnc_hint;
};

closeDialog 0;

_drinkArray =
[
    ["Low_bottleWater", 5, "You drink from the bottled water(s)", ["Bottle",_amount]],
    ["High_bottleWater", 10, "You drink from the bottled water(s)", ["Bottle",_amount]]
    //["ClayPotM", 100, "You drink from the clay pot(s)", ["ClayPot",_amount]]
];

{
    if (_x select 0 == _class) exitWith
    {
        _fillThirst = _x select 1;
        _text = _x select 2;
        _addItem = (_x select 3) select 0;
        _addItemAmount = (_x select 3) select 1;
    };
} forEach _drinkArray;

["Thirst", _fillThirst * _amount] call RPP_fnc_increaseDynamic;

if ("Thirst" call RPP_fnc_getDynamicVal > 100) then
{
    ["Thirst", 100] call RPP_fnc_setDynamic;
};

format["%1", _text] call RPP_fnc_hint;
[_class, -(_amount)] call RPP_fnc_addInventoryItem;

if (_addItem != "") then
{
    [_addItem, (_addItemAmount)] call RPP_fnc_addInventoryItem;
};