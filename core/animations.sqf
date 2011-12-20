/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_animations = 
[
    ["Handsup", "switchMove", "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon", {}],
    ["Normal (Play)", "playMoveNow", "AmovPercMstpSnonWnonDnon", {}],
    ["Normal (Switch)", "SwitchMove", "AmovPercMstpSnonWnonDnon", {}],
    ["Jump", "switchMove", "AovrPercMstpSnonWnonDf", {}],
    ["Idle (Rifle)", "switchMove", "CtsDoktor_Vojak_hulakani1", {}],
    ["Cheer", "switchMove", "c7a_bravoTOerc_idle", {}],
    ["Cheer 2", "switchMove", "c7a_bravoTOerc_idle8", {}],
    ["Clap hands up", "switchMove", "c7a_bravoTOerc_idle24", {}],
    ["Clapping", "switchMove", "c7a_bravoTleskani_idle1", {}],
    ["Exercise (Press-ups)", "switchMove", "AmovPercMstpSnonWnonDnon_idle71kliky", {}],
    ["Exercise (Press-ups 2)", "switchMove", "AmovPercMstpSnonWnonDnon_idle56kliky", {}],
    ["Exercise (Situps)", "switchMove", "AmovPercMstpSnonWnonDnon_idle72lehSedy", {}],
    ["Exercise (Handstands)", "switchMove", "AmovPercMstpSnonWnonDnon_idle70chozeniPoRukou", {}],
    ["Exercise (KneeBend)", "switchMove", "AmovPercMstpSnonWnonDnon_idle69drepy", {}],
    ["Exercise (Boxing)", "switchMove", "AmovPercMstpSnonWnonDnon_idle68boxing", {}],
    ["Exercise (Karate)", "switchMove", "AmovPercMstpSnonWnonDnon_exerciseKata", {}],
    ["Suicide", "switchMove", "ActsPercMstpSnonWpstDnon_suicide1B", {}],
    ["Talking 1", "switchMove", "ActsPercMstpSnonWnonDnon_talking01a", {}],
    ["Talking 2", "switchMove", "ActsPercMstpSnonWnonDnon_talking02", {}],
    ["Talking 3", "switchMove", "ActsPercMstpSnonWnonDnon_talking03", {}],
    ["Talking 4", "switchMove", "ActsPercMstpSnonWnonDnon_talking04", {}],
    ["Assemble", "switchMove", "ActsPercSnonWnonDnon_assembling", {}],
    ["Fix Car", "switchMove", "ActsPercSnonWnonDnon_carFixing", {}],
    ["Fix Car 2", "switchMove", "ActsPercSnonWnonDnon_carFixing2", {}],
    ["Dance (1)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingDuoIvan", {}],
    ["Dance (2)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingDuoStefan", {}],
    ["Dance (3)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingStefan", {}],
    ["Stand with hands out", "switchMove", "TowingTractorSupport", {}],
    ["Navigate Driver", "switchMove", "NavigationDriverReverse", {}],
    ["Navigate Heli", "SwitchMove", "NavigationHeli", {}],
    ["Repair Kneel", "switchMove", "RepairingKneel", {}],
    ["Wash car", "switchMove", "RepairingErc", {}],
    ["Hit with rifle", "playMove", "AmelPercMstpSlowWrflDnon_StrokeGun", {}],
    ["Right Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder1", {}],
    ["Left Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder2", {}],
    ["Straight Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder3", {}]
];

RPP_fnc_openAnimations = 
{
    if (!isNull(findDisplay 900)) exitWith
    {
        closeDialog 0;
    };
    
    _dlg = createDialog "RPP_Dlg_AnimationMenu";
    lbClear 2;
    {
        _index = lbAdd [2,format["%1", _x select 0]];
        lbSetData[2, _index, str[(_x select 1), (_x select 2), (_x select 3)]];
    
    } forEach RPP_var_animations;
    lbSetCurSel [2,0];

};

RPP_var_allowAnimation = true;

RPP_fnc_selectAnim = 
{
    _data = call compile lbData[2, lbCurSel 2];
    _type = _data select 0;
    _anim = _data select 1;
    _animCode = _data select 2;

    _code = compile format['%1 %2 "%3"', player, _type, _anim];
    
    if (vehicle player != player) exitWith {};

    if (RPP_var_allowAnimation) then
    {
        [] spawn _animCode;
        [{[] call (_this select 0);}, [_code]] call RPP_fnet_execPublic;
    };

    closeDialog 0;
};
