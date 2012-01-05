/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (not (isNil "RPP_fnc_create3DText")) exitWith {};

RPP_var_hideText = false;

RPP_fnc_create3DText = 
{
    private ["_id", "_text", "_position", "_fadeDistance", "_minDistToDisp", "_buildArray", "_target", "_onlyTarget"];
    _id = (_this select 0);
    _text = (_this select 1);
    _target = (_this select 2);
    if (typeName _target == "STRING") then { _target = call compile (_this select 2); };
    _position = position _target;
    _fadeDistance = (_this select 3);
    _minDistToDisp = (_this select 4);
    _onlyTarget = (_this select 5);
    
    _buildArray = [_id, _text, _position, _fadeDistance, _minDistToDisp, _target, _onlyTarget];
    _id cutRsc ["Default", "plain"];   
    _id call RPP_fnc_disable3DText;
    call compile format["RPP_var_3D%1 = %1;", _id];
    _buildArray spawn RPP_fnc_display3DText;
};

RPP_fnc_disable3DText =
{
    private ["_id"];
    _id = _this;
    _id cutRsc ["Default", "plain"];  
    call compile format["RPP_var_3D%1 = -1;", _id];
};

RPP_fnc_display3DText =
{
    private ["_id", "_text", "_position", "_fadeDistance", "_minDistance", "_id", "_display", "_control", "_var", "_target", "_onlyTarget"];
    disableserialization;
    
    waitUntil {alive player};

    _nowTime = time;
    
    _id = (_this select 0);
    _text = (_this select 1);
    _position = (_this select 2);
    _fadeDistance = (_this select 3);
    _minDistance = (_this select 4);
    _target = (_this select 5);
    _onlyTarget = (_this select 6);
    _id cutrsc ["rscDynamicText","plain"];
    _display = uinamespace getvariable "BIS_dynamicText";
    _control = _display displayctrl 9999;
    _var = 0;
    call compile format["_var = RPP_var_3D%1;", _id];
    _control ctrlsetstructuredtext parsetext _text;
    _box = boundingBox _target;
    _w = safezoneW + safezoneX;
    _h = safezoneH + safezoneY;
    while {_var != -1} do
    {
        if (isNull _target) exitWith
        {
            call compile format["_var = -1;", _id];    
             _id cutRsc ["Default", "plain"];  
        };
        
        call compile format["_var = RPP_var_3D%1;", _id];

        _dis = player distance _position;
        _alpha = abs ((_dis / _minDistance) - _fadeDistance);
        _cursor = cursorTarget;
        _position = position _target;
     
        _position = [(_position select 0)+((((_box select 1) select 0))-(((_box select 1) select 0))), (_position select 1)+((((_box select 1) select 1))-(((_box select 1) select 1))), (_position select 2)+((((_box select 1) select 2))-(((_box select 1) select 2)))];
        _commit = 0;//.425;
        
        
        if (visibleMap) then 
        {
            _alpha = 1;
        };
        
        if ((_cursor != _target) && (_onlyTarget)) then //|| ((vehicle player != player) && (not _onlyTarget))) then
        {
            _alpha = 1;
        };
        
        if (RPP_var_hideText) then
        {
            _alpha = 1;
        };

        if (_alpha <= 1) then 
        {
            _pos2D = worldtoscreen _position;

            if (count _pos2D > 0) then 
            {
                _control ctrlsetposition [(_pos2D select 0) - _w/2,(_pos2D select 1) - _h/2,_w,_h];
              
                _control ctrlsetfade (_alpha^3);
                _control ctrlcommit _commit;
            } 
            else 
            {
                _control ctrlsetfade 1;
                _control ctrlcommit _commit;
                //_control ctrlSetPosition [0,0,0,0];
            };
        } 
        else 
        {
            _control ctrlsetfade 1;
            _control ctrlcommit _commit;
            //_control ctrlSetPosition [0,0,0,0];
            sleep 0.001;
        };
        sleep 0.001;
    };         
};

RPP_fnc_generateID = 
{
    if (isNil "RPP_var_textID") then
    {
        RPP_var_textID = 10000;
    };
    
    RPP_var_textID = RPP_var_textID + 1;

    RPP_var_textID
};

