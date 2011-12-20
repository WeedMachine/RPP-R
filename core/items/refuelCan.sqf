/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;
_refuelVcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];

closeDialog 0;

if (isNil "RPP_var_isRefueling") then
{
    RPP_var_isRefueling = false;
};

if (vehicle player != player) exitWith
{
    localize "STRS_item_refuel_inVehicle" call RPP_fnc_hint;
};

if (count _nearestObjects >= 2) then
{
    _refuelVcl = (_nearestObjects select 1);
};

if (_refuelVcl == empty) exitWith
{
    //Message no vehicle
    localize "STRS_item_refuel_noVehicle" call RPP_fnc_hint;
};

if (RPP_var_isRefueling) exitWith
{
    localize "STRS_item_refuel_refuelAlready" call RPP_fnc_hint;
};

_fuel = fuel _refuelVcl;
_refuelAmount = 0.20;
_maxFuel = 0.50;

if (_fuel > _maxFuel) exitWith
{
    format[localize "STRS_item_refuel_cantRefuel", _maxFuel, _fuel] call RPP_fnc_hint;
};

if ((_fuel + _refuelAmount) > _maxFuel) then
{
    _fuel = _maxFuel;
    _refuelAmount = 0;
};

_refuelVcl setFuel (_fuel + _refuelAmount);

RPP_var_isRefueling = true;

localize "STRS_item_refuel_refuelDone" call RPP_fnc_hint;

[{(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}, [player]] call RPP_fnet_execPublic;
[_class, -1] call TNL_finv_addInventoryItem;

sleep 5;
RPP_var_isRefueling = false;