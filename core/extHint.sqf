/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/


/* It got a bit messy after I did a workaround for shops... */
RPP_fnc_hint = 
{
    private ["_tohint", "_completeHint", "_id", "_amount", "_type", "_edit", "_name", "_found", "_index"];
    _toHint = _this;
    _completeHint = "";
    _id = "";
    _amount = 0;
    _type = "";
    _edit = false;
    _name = "";
    
    if (isNil "RPP_var_extHints") then
    {
        RPP_var_extHints = [];
        [] spawn
        {
            while {true} do
            {
                [] spawn RPP_fnc_hintRefresh;
                sleep 2;
            };
        };
    };
    
    if (typeName _this == "ARRAY") then
    {
        _edit = true;
        _toHint = "";
        _id = _this select 0;
        _amount = _this select 1;
        _type = _this select 2;
        _name = _this select 3;
        _price = _this select 4;
    };
    
    _found = false;
    _index = 0;
    if (_edit) then
    {
        {
            if ((_x select 2 == _id) && (_x select 4 == _type)) exitWith
            {
                _found = true;
                _index = _forEachIndex;
                _amount = (_x select 3);
            };
        
        } forEach RPP_var_extHints;
        
        if (_type == "BUY") then
        {
            _toHint = format[localize "STRS_shop_purchasedItem", _name, _price * _amount, _amount];
        }
        else
        {
            _toHint = format[localize "STRS_shop_soldItem", _name, _price * _amount, _amount];
        };
    };
    
    
    
    if (_toHint != "") then
    {
        if (_edit && _found) then
        {
            
            (RPP_var_extHints select _index) set[1, 8];
            (RPP_var_extHints select _index) set[3, _amount + 1];
            (RPP_var_extHints select _index) set[0, _toHint];
        }
        else
        {
            if !(_edit) then
            {
                RPP_var_extHints = RPP_var_extHints + [ [_toHint, 8, _id, _amount, _type] ];
            }
            else
            {
                RPP_var_extHints = RPP_var_extHints + [ [_toHint, 8, _id, _amount+1, _type] ];
            };
        };
    };

    {
        if ((_x select 0) != "") then
        {
            _completeHint = _completeHint + (_x select 0) + "<br/><br/>";
        };
    } foreach RPP_var_extHints;
    
    hintSilent parseText _completeHint;
};

RPP_fnc_hintRefresh = 
{
    {
        _hint = (_x select 0);
        _timeLeft = (_x select 1);

        if (_timeLeft <= 0) then
        {
            if (_hint != "") then
            {
                _x set[0, ""];
                "" spawn RPP_fnc_hint;
                
                RPP_var_extHints set[_forEachIndex, "REMOVE"];
                RPP_var_extHints = RPP_var_extHints - ["REMOVE"];
            };
        }
        else
        {
            _x set[1, _timeLeft - 1];
        };
    } foreach RPP_var_extHints;	
};

