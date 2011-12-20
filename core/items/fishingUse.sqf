/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;

if ((_class in RPP_var_fishing_items) && (not (RPP_var_isFishing))) then
{
    [_class] spawn RPP_fnc_startFishing;
}
else
{
    localize "STRS_fishing_alreadyFishing" call RPP_fnc_hint;
};
