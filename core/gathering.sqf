RPP_var_gathering_define = 
[
    ["farm_wheat", 120, "", localize "STRS_gather_startWheat", ["farming", 1, 80], ["Wheat", 45, 1, 4], ["Tractor", 3]]
];

RPP_var_isGathering = false;

RPP_fnc_gatherClientLoop = 
{
    while {true} do
    {
        {
            _marker = _x select 0;
            _distance = _x select 1;
            
            if (vehicle player distance (getMarkerPos _marker) <= _distance) then
            {
                if !(RPP_var_isGathering) then
                {
                    _marker spawn RPP_fnc_startGathering;
                };
            };
        
        } forEach RPP_var_gathering_define;
    
        sleep 10;
    };
};

RPP_fnc_getGatherArray = 
{
    private ["_marker", "_return"];
    _marker = _this;
    _return = [];
    {
        if (_x select 0 == _marker) exitWith
        {
            _return = _x;
        };
    } forEach RPP_var_gathering_define;
    
    _return
};

RPP_fnc_getGatherDistance = 
{
    ((_this call RPP_fnc_getGatherArray) select 1)
};

RPP_fnc_getGatherItem = 
{
    ((_this call RPP_fnc_getGatherArray) select 2)
};

RPP_fnc_getGatherText = 
{
    ((_this call RPP_fnc_getGatherArray) select 3)
};

RPP_fnc_getGatherSkills = 
{
    ((_this call RPP_fnc_getGatherArray) select 4)
};

RPP_fnc_getGatherGain = 
{
    ((_this call RPP_fnc_getGatherArray) select 5)
};

RPP_fnc_getGatherVehicle = 
{
    ((_this call RPP_fnc_getGatherArray) select 6)
};


RPP_fnc_startGathering = 
{
    private ["_marker", "_skills", "_itemGain", "_vehicle", "_text", "_reqItem", "_distance", "_skill", "_reqLevel", "_experience"];
    private ["_level", "_requiresVehicle", "_requiredVehicle", "_requiredSpeed", "_item", "_failChance", "_minGain", "_maxGain"];
    _marker = _this;
    _distance = _marker call RPP_fnc_getGatherDistance;
    _skills = _marker call RPP_fnc_getGatherSkills;
    _itemGain = _marker call RPP_fnc_getGatherGain;
    _vehicle = _marker call RPP_fnc_getGatherVehicle;
    _text = _marker call RPP_fnc_getGatherText;
    _reqItem = _marker call RPP_fnc_getGatherItem;
    
    _skill = _skills select 0;
    _reqLevel = _skills select 1;
    _experience = _skills select 2;
    _level = (_skill call RPP_fnc_getExperience) call RPP_fnc_calculateLevel;
    
    if (_level < _reqLevel) exitWith
    {
        /* Not high enough level */
        (format[localize "STRS_gather_noLevel", _reqLevel, _skill call RPP_fnc_getSkillName]) call RPP_fnc_hint;
    };
    
    _requiresVehicle = (count _vehicle > 0);
    _requiredVehicle = "";
    _requiredSpeed = 0;
    
    if ((_requiresVehicle) && (typeOf vehicle player != (_vehicle select 0))) exitWith 
    {
        /* Not in correct vehicle */
        (format[localize "STRS_gather_notVehicle", (_vehicle select 0) call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    };
    
    if (_reqItem != "" && (_reqItem call RPP_fnc_itemGetAmount <= 0)) exitWith
    {
        (format[localize "STRS_gather_reqItem", _reqItem call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    };
    
    if (_requiresVehicle) then
    {
        _requiredVehicle = _vehicle select 0;
        _requiredSpeed = _vehicle select 1;
    };
    
    _text call RPP_fnc_hint;
    
    RPP_var_isGathering = true;
    
    _item = _itemGain select 0;
    _failChance = _itemGain select 1;
    _minGain = _itemGain select 2;
    _maxGain = _itemGain select 3;
    _failChance = _failChance - ((_level - _reqLevel) * 1.25); 

    while {RPP_var_isGathering} do
    {
        if ((_requiresVehicle) && (typeOf vehicle player != _requiredVehicle)) exitWith 
        {
            /* Not in correct vehicle */
            RPP_var_isGathering = false;
        };
        
        _failChance = _itemGain select 1;
        _failChance = _failChance - ((_level - _reqLevel) * 1.25); 
        
        _canDo = true;
        
        if ((_requiresVehicle) && (speed vehicle player < _requiredSpeed)) then
        {
            (format[localize "STRS_gather_noSpeed", _requiredSpeed]) call RPP_fnc_hint;
            _canDo = false;
        };
        
        if (_reqItem != "" && (_reqItem call RPP_fnc_itemGetAmount <= 0)) exitWith
        {
            RPP_var_isGathering = false;
        };
        
        if (vehicle player distance (getMarkerPos _marker) > _distance) exitWith
        {
            RPP_var_isGathering = false;
        };
        
        if (_canDo) then
        {
            _roll = random 100;
            
            if (_roll > _failChance) then
            {
                _amount = ceil(_minGain + (random (_maxGain-1)));
                
                [_skill, _experience * _amount] call RPP_fnc_increaseSkill;
                
                if ([_item, _amount] call RPP_fnc_addInventoryItem) then
                {
                    (format[localize "STRS_gather_gather", _amount, _item call RPP_fnc_itemGetName]) call RPP_fnc_hint;
                }
                else
                {
                    localize "STRS_gather_noRoom" call RPP_fnc_hint;
                };
            };
        
        };
            
    
        sleep 10;
    };
    RPP_var_isGathering = false;
    
    localize "STRS_gather_stop" call RPP_fnc_hint;
};