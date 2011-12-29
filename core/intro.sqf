/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

/* Civilian song: Harvest Red */
/* Cop Song: Khe sahn */

RPP_var_civSong = "Track08_Harvest_Red";
RPP_var_civCamera =
[
    [[6943.65,-95672.45,39.50], [6168.72,4324.86,38.18], 0.700, 3.5, "Welcome to Aussie Life: Reloaded"],
    [[6943.65,-95672.45,39.50], [6168.72,4324.86,38.18], 0.700, 7, "Mission brought to you by Rp-project.net & AussieLifeReloaded.com"],
    [[6943.65,-95672.45,39.50], [6168.72,4324.86,38.18], 0.700, 7, "RP-Project Project Leader: Unforgiven"],
    [[3844.62,104305.57,1285.63], [6155.86,4345.51,41.47], 0.700, 7, "RP-Project Lead Administrator: Jason"],
    [[3844.62,104305.57,1285.60], [6176.39,4345.98,41.47], 0.700, 7, "Aussie Life Reloaded Project Leader: WeedMachine"],
    [[2737.64,104294.02,788.88], [6171.36,4355.27,43.14], 0.700, 7, "Exclusive to the Australian Community."],
    [[21466.68,-62347.32,-72841.34], [6151.03,4348.34,45.80], 0.700, 7, ""],
    [[58440.81,54459.67,68991.43], [6162.64,4316.39,20.43], 0.700, 7, ""],
    [[4215.22,103918.91,-8605.37], [6168.86,4313.27,17.78], 0.700, 7, ""],
    [[4215.22,103918.91,-8605.13], [6169.00,4313.30,1.74], 0.700, 7, "And thank you to the community who made this mission possible."],
    [[4215.22,103918.91,-8605.44], [6168.78,4321.59,1.74], 0.700, 7, "Enjoy your game here " + name player]
];

RPP_var_copSong = "Ambient06_Khe_Sanh_Riff";
RPP_var_copCamera = 
[
    [[-82093.38,53815.25,-5434.16], [5002.56,4995.96,3.85], 0.700, 7, "Welcome to the Aussie Life: Reloaded"],
    [[-12613.63,102174.34,-16072.59], [4890.04,5061.57,4.76], 0.700, 7, "Mission brought to you by rp-project.net & AussieLifeReloaded.com"],
    [[5914.73,105144.48,-1112.63], [4876.48,5157.38,1.96], 0.700, 7, "Lead Developer: Unforgiven & WeedMachine"],
    [[-95080.05,7826.40,-1113.57], [4878.83,5234.59,2.23], 0.700, 7, "Scripting: Unforgiven"],
    [[1935.54,95560.27,-42671.56], [4878.78,5234.77,27.84], 0.700, 7, "Dialogs: Jason"],
    [[89786.08,36188.15,-42671.64], [4878.78,5234.77,27.84], 0.700, 7, "Sounds: Somebloke"],
    [[60485.81,-66005.80,-42671.60], [4878.78,5234.77,27.84], 0.700, 7, "Models: Slatts"],
    [[-70097.45,-45222.40,-42671.66], [4878.78,5234.77,27.84], 0.700, 7, "RTE Editing: Thunderstruck, Andrew"],
    [[67617.23,83083.87,-2395.92], [4853.39,5273.73,0.67], 0.700, 7, "Thanks to Baycity-rpg for contributing various models"],
    [[67617.23,83083.87,-2395.85], [4866.73,5290.27,0.67], 0.700, 7, "And thank you to the community who made this mission possible."],
    [[72898.36,78543.67,-2396.49], [4868.67,5292.97,2.08], 0.700, 7, "To play as Cop you must join the police force first on the forums"],
    [[72898.36,78543.67,-2396.53], [4878.56,5303.67,2.08], 0.700, 7, "Enjoy your game here " + name player]
];

RPP_fnc_runIntro = 
{
    private ["_type", "_cameraArray", "_music", "_camera"];
    _type = _this;
    _cameraArray = [];
    _music = "";
    
    if !(RPP_Intro) exitWith {};
    
    
    if (_type == "COP") then
    {
        _cameraArray = RPP_var_copCamera;
        _music = RPP_var_copSong;
    }
    else
    {
        _cameraArray = RPP_var_civCamera;
        _music = RPP_var_civSong;
    };
    
    
    _cameraArray = RPP_var_civCamera;
    _music = RPP_var_civSong;
    
    playMusic _music;
    2 fadeSound 0;
    10 fadeMusic 1;

   // "filmGrain" ppEffectEnable true; 
   // "filmGrain" ppEffectAdjust [0.08, 1, 1, 0.1, 1, false];
   // "filmGrain" ppEffectCommit 0.1;
    
    _camera = "camera" camcreate ((_cameraArray select 0) select 1);
    _camera camSetPos ((_cameraArray select 0) select 1);
    _camera cameraEffect ["internal", "back"];
    _camera camSetTarget player;
    _camera camSetFOV 0.700;
    _camera camCommit 0;
    _camera camPreload 0;
   // waitUntil {camPreloaded _camera};
    
    _i = 0;
    while {_i < (count _cameraArray)} do 
    {	
        _cameraTarget = ((_cameraArray select _i) select 0);
        _cameraPos = ((_cameraArray select _i) select 1);
        _cameraFov = ((_cameraArray select _i) select 2);
        _camPreload = ((_cameraArray select _i) select 3);
        _titleText = ((_cameraArray select _i) select 4);

        _camera camSetPos _cameraPos;							
        _camera camSetTarget _cameraTarget;											
        _camera camSetFOV _cameraFov;				
        _camera camCommit _camPreload;	

        cutText [_titleText,"PLAIN",4];

        if (_i >= (count _cameraArray)) then
        {
            _i = 0;
        };

        waitUntil {camCommitted _camera};
        
         _camera camPreload 1;
        waitUntil {camPreloaded _camera};
        _i = _i + 1;
    };

    2 fadeSound 1;
    10 fadeMusic 0;
    _camera cameraEffect ["terminate","back"];
    titleCut [" ","Black in",1];
    camDestroy _camera;
    
   // "filmGrain" ppEffectEnable false;
    //"colorCorrections" ppEffectEnable false;

    
};