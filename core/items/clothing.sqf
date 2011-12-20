/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;
_type1 = _class call RPP_fnc_itemGetType1;
_type2 = _class call RPP_fnc_itemGetType2;

if (vehicle player != player) exitWith {};

[_class] spawn RPP_fnc_changeUnit;

[_class, -1] call RPP_fnc_addInventoryItem;
[typeOf player, 1] call RPP_fnc_addInventoryItem;

(format[localize "STRS_item_changeClothes", _class call RPP_fnc_itemGetName]) call RPP_fnc_hint;