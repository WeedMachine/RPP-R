/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_skills = 
[
    ["mining", "Mining"],
    ["fishing", "Fishing"],
    ["manufacture", "Manufacturing"],
    ["cooking", "Cooking"],
    ["forestry", "Forestry/Harvesting"],
    ["farming", "Farming"]
];

RPP_var_maxSkill = 99;
RPP_var_skillTable = [];

/* Setup player skills and create array */
RPP_var_userSkills = [];
{RPP_var_userSkills set[(count RPP_var_userSkills), [(_x select 0), 0]]} forEach RPP_var_skills;

RPP_fnc_generateExperienceTable =
{
    private ["_i"];
    _i = 0;
    while {_i <= RPP_var_maxSkill-1} do
    {
        _level = _i;
        _experience = (_level * (100 * _i) ^ 1.25);
        RPP_var_skillTable set[(count RPP_var_skillTable), [_level+1, _experience]];
        _i = _i + 1;
    };
};

RPP_fnc_getSkillName =
{
    private ["_id", "_name"];
    _id = _this;
    _name = "";
    
    {
        if (_id == (_x select 0)) exitWith
        {
            _name = (_x select 1);
        };
    
    } forEach RPP_var_skills;

    _name
};

RPP_fnc_calculateLevel = 
{
    private ["_experience", "_level", "_previous", "_prevLevel", "_lastArr", "_lastLevel", "_lastExp"];
    _experience = _this;
    _level = 0;
    
    _previous = 0;
    _prevLevel = 0;
    {
        _curExp = _x select 1;
        _nowLevel = _x select 0;

        if (_experience >= _previous && (_experience < _curExp)) exitWith
        {
            _level = _prevLevel;
        };
        _previous = _curExp;
        _prevLevel = _nowLevel;
    } forEach RPP_var_skillTable;
    
    /* Lets check if its higher than max skill */
    _lastArr = (RPP_var_skillTable select (count RPP_var_skillTable)-1);
    _lastLevel = _lastArr select 0;
    _lastExp = _lastArr select 1;
    
    if (_experience >= _lastExp) then
    {
        _level = _lastLevel;
    };
    
    _level
};

RPP_fnc_increaseSkill = 
{
    private ["_skill", "_amount"];
    _skill = _this select 0;
    _amount = _this select 1;
    
    {
        _type = _x select 0;
        _exp = _x select 1;
        
        if (_type == _skill) exitWith
        {
            _newExp = _exp + _amount;
            
            if (_newExp < 0) then
            {
                _newExp = 0;
            };
            
            _x set[1, _newExp];
        };   
    } forEach RPP_var_userSkills;
};

RPP_fnc_getExperience = 
{
    private ["_skill", "_exp"];
    _skill = _this;
    _exp = 0;
    
    {
        if (_x select 0 == _skill) exitWith
        {
            _exp = _x select 1;
        };
    } forEach RPP_var_userSkills;
    
    _exp
};

RPP_fnc_skillsSaving =
{
    while {true} do
    {
         sleep 600;
        if (RPP_var_loggedIn) then
        {
            [RPP_var_saving_tableSkills, ["RPP_var_userSkills", RPP_var_acc_login], RPP_var_userSkills] call RPP_fsav_clientRequestSave;
        };
    };
};