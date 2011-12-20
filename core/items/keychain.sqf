/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (!isNull(findDisplay 1000)) exitWith
{
    closeDialog 0;
};

_dlg = createDialog "RPP_Dlg_KeyChain";
[] call RPP_fnc_loadKeyChain;