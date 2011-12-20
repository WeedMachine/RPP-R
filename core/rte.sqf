RPP_var_RTEImport = 
[
    "RTE\seamine_1.sqf",
    "RTE\seamine_2.sqf",
    "RTE\seamine_3.sqf",
    "RTE\seamine_4.sqf",
    "RTE\seamine_5.sqf"
];

RPP_fnc_importSQF = 
{
    private ["_filePath", "_array"];
    _array = [];
    
    if (typeName _this != "ARRAY") then
    {
        _filePath = _this;

        _array = [] call compile preProcessFileLineNumbers _filePath;
    }
    else
    {
        _array = _this;
    };
    
    {
        _id = _x select 0;
        _class = (_x select 1) select 0;
        _pos = (_x select 1) select 1;
        _dir = (_x select 1) select 2;
        _init = (_x select 1) select 8;
        _isWater = surfaceIsWater _pos;
        
        _obj = _class createVehicle [0,0,0];
        _obj setDir _dir;
        if (_isWater) then
        {
            _obj setPosASL _pos;
        }
        else
        {
            _obj setPos _pos;
        };
        _obj setVehicleInit _init;
        processInitCommands; 
    } forEach _array;
};

RPP_fnc_importAll = 
{
    {
        _x call RPP_fnc_importSQF;
    } forEach RPP_var_RTEImport;
};