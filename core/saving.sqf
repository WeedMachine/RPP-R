/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (count (server getVariable [format["saved_vars_%1", getPlayerUID player], []]) == 0) then
{
    server setVariable [format["saved_vars_%1", getPlayerUID player], [], true];
};

RPP_fnc_saving_loadVar = 
{
    private ["_var", "_return", "_load"];
    _var = _this;
    _return = [];
    
    _load = server getVariable [format["saved_vars_%1", getPlayerUID player], []];
    {
        if (_x select 0 == _var) exitWith
        {
            _return = (_x select 1);
            diag_log format["Client loaded variable %1 - %2", _var, (_x select 1)];
        };
    
    } forEach (_load);
    
    _return
};

RPP_var_saving_saveVar = 
{
    private ["_var", "_data", "_found", "_return", "_load"];
    _var = _this select 0;
    _data = _this select 1;
    _found = false;
    _return = [];
    
    _load = server getVariable [format["saved_vars_%1", getPlayerUID player], []];
    {
        if (_x select 0 == _var) exitWith
        {
            _return = (_x select 1);
            _found = true;
            
            diag_log format["Client updating variable %1 - %2", _var, _data];
            _x set[1, _data];
        };
    } forEach _load;

    if !(_found) then
    {
        _load set[(count _load), [_var,_data]];
        diag_log format["Client saving variable %1 - %2", _var, _data];
    };

    server setVariable [format["saved_vars_%1", getPlayerUID player], _load, true];
};