_class = _this select 0;
_amount = _this select 1;

_fillHunger = 0;
_text = "";

if (_class call RPP_fnc_itemGetAmount < _amount) exitWith 
{
    localize "STRS_food_notEnough" call RPP_fnc_hint;
};

closeDialog 0;


_foodArray =
[
    ["Minnow", 0.25, localize "STRS_food_minnow"],
    ["Bluegill", 6, localize "STRS_food_bluegill"],
    ["Soup", 1, "You eat the Soup(s)"],
    ["Sandwich", 5, "You eat the Sandwich(s)"],
    ["Bread", 10, "You eat the Bread(s)"],
    ["Donut", 3, "You eat the Donut(s)"]
];

{
    if (_x select 0 == _class) exitWith
    {
        _fillHunger = _x select 1;
        _text = _x select 2;
    };
} forEach _foodArray;

["Hunger", _fillHunger * _amount] call RPP_fnc_increaseDynamic;

if (("Hunger" call RPP_fnc_getDynamicVal) > 100) then
{
    ["Hunger", 100] call RPP_fnc_setDynamic;
};

format["%1", _text] call RPP_fnc_hint;
[_class, -(_amount)] call RPP_fnc_addInventoryItem;
