/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_fnc_hungerOnDepleted = 
{
    player setDamage 1;
};

RPP_var_dynamicVars = 
[
    ["Hunger", 100, 100, 4, 90, RPP_fnc_hungerOnDepleted, 10, "You are getting hungry, eat something."],
    ["Thirst", 100, 100, 3, 90, RPP_fnc_hungerOnDepleted, 10, "You are getting thirsty, drink something."]
];

RPP_fnc_dynamicValLoop = 
{
    _ticks = 0;
    while {true} do
    {
        {
            _val = (_x select 0);
            _currentVal = (_x select 1);
            _amount = (_x select 3);
            _timer = (_x select 4);
            _onDepleted = (_x select 5);
            _depleting = (_x select 6);
            _msgOnDepleting = (_x select 7);
            if (_ticks % _timer == 0) then /* Decrease value */
            {
                _decreaseBy = -(round(random _amount));
                
                if (_currentVal + _decreaseBy < _depleting) then
                {
                    cutText [_msgOnDepleting, "PLAIN DOWN"];
                };
                
                if (_currentVal + _decreaseBy <= 0) then
                {
                    [] call _onDepleted;
                };

                [_val, _decreaseBy] call RPP_fnc_increaseDynamic;
            };
        } forEach RPP_var_dynamicVars;
        
        _ticks = _ticks + 1;
        sleep 1;
    };
};

RPP_fnc_setDynamic = 
{
    private ["_val", "_amount"];
    _val = _this select 0;
    _amount = _this select 1;
    
    {
        if (_x select 0 == _val) exitWith
        {    
            _x set[1, _amount];
        };
    } forEach RPP_var_dynamicVars;
};

RPP_fnc_increaseDynamic = 
{
    private ["_val", "_amount"];
    _val = _this select 0;
    _amount = _this select 1;
    
    {
        if (_x select 0 == _val) exitWith
        {    
            _x set[1, (_x select 1)+_amount];
        };
    } forEach RPP_var_dynamicVars;
};

RPP_fnc_getDynamicVal = 
{
    private ["_val", "_return"];
    _val = _this;
    _return = 0;
    
    {
        if (_x select 0 == _val) exitWith
        {
            _return = (_x select 1);
        };
    
    } forEach RPP_var_dynamicVars;

    _return
};