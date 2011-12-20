/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;

_repairVcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];
_repairTime = 25;

closeDialog 0;

if (isNil "RPP_var_isRepairing") then
{
    RPP_var_isRepairing = false;
};

if (vehicle player != player) exitWith
{
    localize "STRS_item_repairKit_inVehicle" call RPP_fnc_hint;
};

if (count _nearestObjects >= 2) then
{
    _repairVcl = (_nearestObjects select 1);
};

if (_repairVcl == empty) exitWith
{
    //Message no vehicle
    localize "STRS_item_repairKit_noVehicle" call RPP_fnc_hint;
};

if (RPP_var_isRepairing) exitWith
{
    localize "STRS_item_repairKit_repairAlready" call RPP_fnc_hint;
    //Already repairing
};

RPP_var_isRepairing = true;

//Public animation
[{(_this select 0) switchMove "ActsPercSnonWnonDnon_carFixing";}, [player]] call RPP_fnet_execPublic;
		
_counter = 1;
_failure = false;
_dmg = getDammage _repairVcl;

while {_counter <= _repairTime} do
{
    if (!alive player) exitWith
    {
        _failure = true;
    };

    if (!alive _repairVcl) exitWith
    {
        _failure = true;
        localize "STRS_item_repairKit_destroyed" call RPP_fnc_hint;
    };

    if (player != vehicle player) exitWith
    {
        _failure = true;
        localize "STRS_item_repairKit_gotInVehicle" call RPP_fnc_hint;
    };

    if (player distance getpos(_repairVcl) >= 5) exitWith
    {
        _failure = true;
        localize "STRS_item_repairKit_moved" call RPP_fnc_hint;
    };

    _animState = animationState player;
    if (_animState != "ActsPercSnonWnonDnon_carFixing") exitWith
    {
        _failure = true;
        localize "STRS_item_repairKit_stop" call RPP_fnc_hint;
    };

    titleText [format["Repairing... time remaining: %1", (_repairTime - _counter)], "PLAIN"];

    sleep 2;
    _repairVcl say3D "SndRepair";
    _counter = _counter + 2;
};

if (!(_failure)) then
{
    localize "STRS_item_repairKit_done" call RPP_fnc_hint;
    [{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon";}, [player]] call RPP_fnet_execPublic;
    [_class, -1] call RPP_fnc_addInventoryItem;
    _repairVcl setDamage 0;
};
			
	

RPP_var_isRepairing = false;

