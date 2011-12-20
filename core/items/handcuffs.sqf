_class = _this select 0;
_amount = _this select 1;

closeDialog 0;

if (vehicle player != player) exitWith {};

sleep 0.1;

_curTarget = cursorTarget;

if !(alive _curTarget) exitWith {};

if ((_curTarget getVariable["hasActions", false]) || (str _curTarget in RPP_var_players)) then
{
    if (_curTarget isKindOf "Man") then
    {
        /* Attempt to handcuff/release player */
        ["RPP_fnc_restrain_resClient", [player, _curTarget]] call RPP_fnet_execPublic;
    };
};
