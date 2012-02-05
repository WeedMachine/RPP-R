/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

[] spawn
{
    disableSerialization;
    100 cutRsc ["RPP_Dlg_ui", "PLAIN"];
    
    while {true} do
    {
        _money = "Money" call RPP_fnc_itemGetAmount;
        _weight = [] call RPP_fnc_getInvSize;
        _maxWeight = RPP_var_inventorySize;
        _hunger = "Hunger" call RPP_fnc_getDynamicVal;
        _thirst = "Thirst" call RPP_fnc_getDynamicVal;
        _health = ceil(100 - (damage player*100));
        _id = getPlayerUID player;
        ((RPP_display_ui select 0) displayCtrl 1) ctrlSetStructuredText parseText format["<t color='#4876FF'>Money: $%1 - Weight: %2/%3 - Health: %4/100 - Hunger: %6 - Thirst: %7 - ID: %5</t>", _money, _weight, _maxWeight, _health, _id, _hunger, _thirst];
        sleep 3;
    };
};