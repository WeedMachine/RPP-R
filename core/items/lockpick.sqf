/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;
_vcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];

closeDialog 0;

if (count _nearestObjects >= 2) then
{
    _vcl = (_nearestObjects select 1);
};

if (_vcl == empty) exitWith
{
    localize "STRS_item_lockpick_noVehicle" call RPP_fnc_hint;
};

if (player != vehicle player) exitWith
{
    localize "STRS_item_lockpick_alreadyIn" call RPP_fnc_hint;
};

if (_vcl in RPP_var_keyChain) exitWith
{
    localize "STRS_item_lockpick_yourVehicle" call RPP_fnc_hint;
};

_chance = 35;
_roll = random 100;

if (_roll <= _chance) then /* Success */
{
    localize "STRS_item_lockpick_success" call RPP_fnc_hint;
    [{(_this select 0) lock false}, [_vcl]] call RPP_fnet_execPublic;
    [_class, -1] call RPP_fnc_addInventoryItem;

}
else /* Fail */
{
    localize "STRS_item_lockpick_broken" call RPP_fnc_hint;
    [{ if (player distance (_this select 0) <= 20) then { (_this select 0) say3D "SndCarAlarm"; }; }, [_vcl]] call RPP_fnet_execPublic;
    [_class, -1] call RPP_fnc_addInventoryItem;
};
