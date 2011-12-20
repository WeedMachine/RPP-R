RPP_fnc_search_openDialog = 
{
    private ["_unit"];
    _unit = _this;

    if (!isNull(findDisplay 2700)) exitWith
    {
        /* Do nothing */
    };
    
    createDialog "RPP_Dlg_Search";

    ["RPP_fnc_search_client", [_unit, player]] call RPP_fnet_execPublic;
};

RPP_fnc_search_reject = 
{
    private ["_unit", "_searcher"];
    _unit = _this select 0;
    _searcher = _this select 1;
    
    if (player == _searcher) then
    {
        localize "STRS_search_reject" call RPP_fnc_hint;
        closeDialog 0;
    };
    
};

RPP_fnc_search_client = 
{
    private ["_unit", "_searcher", "_animState"];
    _unit = _this select 0;
    _searcher = _this select 1;
    
    if (player != _unit) exitWith {};
        
    _animState = animationState _unit;
    if ((RPP_var_isTazed) || (_animState == "amovpercmstpssurwnondnon") || (RPP_var_isRestrained)) then
    {
        ["RPP_fnc_search_populate", [_unit, _searcher, [RPP_var_inventory, RPP_var_playerLicenses, weapons player, magazines player]]] call RPP_fnet_execPublic;
    
    }
    else
    {
        ["RPP_fnc_search_reject", [_unit, _searcher]] call RPP_fnet_execPublic;
    };

};

RPP_fnc_search_populate = 
{
    private ["_unit", "_searcher", "_variables", "_inv", "_licenses", "_weapons", "_magazines"];
    _unit = _this select 0;
    _searcher = _this select 1;
    _variables = _this select 2;
    _inv = _variables select 0;
    _licenses = _variables select 1;
    _weapons = _variables select 2;
    _magazines = _variables select 3;
    
    if (player == _unit) then
    {
        format[localize "STRS_search_searched", name _searcher] call RPP_fnc_hint;
    };
    
    if (player != _searcher) exitWith {};
    
    lbAdd[1500, "INVENTORY"];
    {
        _item = _x select 0;
        _amount = _x select 1;
        _name = _item call RPP_fnc_itemGetName;
        
        _index = lbAdd[1500, format["%1, %2x", _name, _amount]];
    } forEach _inv;
    
    if (count _inv <= 0) then
    {
        lbAdd[1500, "No inventory"];
    };
    
    lbAdd[1500, ""];
    lbAdd[1500, "LICENSES"];
    {
        _name = _x call RPP_fnc_getLicenseName;
        
        _index = lbAdd[1500, _name]; 
    } forEach _licenses;
    
    if (count _licenses <= 0) then
    {
        lbAdd[1500, "No licenses"];
    };
    
    lbAdd[1500, ""];
    lbAdd[1500, "WEAPONS & MAGAZINES"];
    {
        _class = (_x select 0);
        _name = _class call RPP_fnc_itemGetName;
        _amount = (_x select 1);
        _index = lbAdd[1500, format["%1, %2x", _name, _amount]];
    } forEach ([(_weapons) + (_magazines)] call RPP_fnc_createWeaponsArray);
    
};