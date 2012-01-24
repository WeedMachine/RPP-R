RPP_fsav_clientRequestSave = 
{
    private ["_tableName", "_indexName", "_data"];
    _tableName = (_this select 0);
    _indexName = format["%1", (_this select 1)];
    _data = str(_this select 2);


    [{if (isServer) then { [(_this select 0), (_this select 1), (_this select 2)] call RPP_fsav_serverRequestSave; };}, [_tableName, _indexName, _data]] call RPP_fnet_execPublic;
};

RPP_fsav_serverRequestSave = 
{
    private ["_tableName", "_indexName", "_data"];
    _tableName = (_this select 0);
    _indexName = (_this select 1);
    _data = (_this select 2);

    [_tableName, _indexName, _data] call RPP_fsav_serverInsertIntoSaveQueue;
};

RPP_fsav_serverInsertIntoSaveQueue =
{
    private ["_tableName", "_indexName", "_data"];
    _tableName = format["%1",(_this select 0)];
    _indexName = format["%1",(_this select 1)];
    _data = (_this select 2);
    
    diag_log format["Saving: %1 %2", _indexName, _data];

    RPP_gVar_int_saveArray = RPP_gVar_int_saveArray + [ [_tableName, _indexName, _data] ];

};

RPP_fsav_serverCommit = 
{
    private ["_i"];
    if ((!(RPP_gVar_boolean_databaseInUse)) && (RPP_Saving)) then
    {
        RPP_gVar_boolean_databaseInUse = true;

        _counter = count RPP_gVar_int_saveArray;
        _i = 0;
        while {_i < _counter} do
        {
            _tableName = ((RPP_gVar_int_saveArray select _i) select 0);
            _indexName = ((RPP_gVar_int_saveArray select _i) select 1);
            _data = ((RPP_gVar_int_saveArray select _i) select 2);
            _found = false;
            _sleepTime = 1.0;

            sleep _sleepTime;

            (format["SELECT * FROM %1", _tableName]) call SQLiteGet;

            sleep _sleepTime;

            _result = [] call SQLiteGetReply;

            _y = 0;
            _newResults = [];
            _newIndex = [];
            _newData = [];
            {
                if (_y == 1) then
                {
                    _newData = _x;
                    _newResults = _newResults + [ [_newIndex,_newData] ];
                    _y = 0;
                }
                else
                {
                    _newIndex = _x;
                    _y = 1;
                };
            } forEach _result;
            _result = _newResults;

            {
                _getIndexName = _x select 0;
                _getData = _x select 1;
                _searchIndexName = _getIndexName;
                _searchIndexName2 = _indexName;

                if (typeName _getIndexName == "OBJECT") then
                {
                    if (isNull _getIndexName) exitWith
                    {
                            _found = false;
                    };
                };

                if (typeName _getIndexName != "STRING") then
                {
                    _searchIndexName = format["%1", _getIndexName];
                };

                if (typeName _indexName != "STRING") then
                {
                    _searchIndexName2 = format["%1", _indexName];
                };

                if (_searchIndexName == _searchIndexName2) then
                {
                    _x set[1,_data];

                    _toCompile = "RPP_gVar_arr_serverLoadedVariables_"+_tableName+" = _result;";
                    call compile _toCompile;


                    //call compile format['RPP_gVar_arr_serverLoadedVariables_%1 = _result;', _tableName];
                    _found = true;
                };
            } forEach _result;

            if (_found) then
            {
                _string = "UPDATE " + _tableName + " SET data='"+_data+"' WHERE indexName='"+_indexName+"'";		
                _string call SQLiteUpdate;
                diag_log format["Updating: %1", _indexName];
                //format["UPDATE %1 SET data='%2' WHERE indexName='%3'", _tableName, _data, _indexName] call SQLiteUpdate;
            }
            else
            {
                _string = "INSERT INTO "+_tableName + "(indexName, data) VALUES('"+_indexName+"','"+_data+"')";
                _string call SQLiteInsert;
                diag_log format["Inserting into: %1", _indexName];
                //format["INSERT INTO %1 (indexName, data) VALUES('%2','%3')", _tableName, _indexName, _data] call SQLiteInsert;
                _cmIndex = call compile _indexName;
                _cmData = call compile _data;
                _toCompile = "RPP_gVar_arr_serverLoadedVariables_"+_tableName+" = RPP_gVar_arr_serverLoadedVariables_"+_tableName+" + [ ["+str _cmIndex+","+str _cmData+"] ];";
                call compile _toCompile;
                //call compile format['RPP_gVar_arr_serverLoadedVariables_%1 = RPP_gVar_arr_serverLoadedVariables_%1 + [ [%2,%3] ];', _tableName, call compile _indexName, call compile _data];
            };

            _counter = count RPP_gVar_int_saveArray;
            _i = _i + 1;
        };

        RPP_gVar_int_saveArray = [];
        RPP_gVar_boolean_databaseInUse = false;
    };
};

RPP_fsav_serverLoad = 
{
    private ["_arrayTableNames"];
    _arrayTableNames = (_this select 0);
    _time = time;

    server setVariable["loaded", false, true];

    if ((!(RPP_gVar_boolean_databaseInUse)) && (RPP_Saving)) then
    {
        ["","","",""] call SQLiteConnect; //Probably does nothing now.
        RPP_gVar_boolean_databaseInUse = true;

            {
                _sleepTime = 0.8;
                _tableName = (_x);

                sleep _sleepTime;

                _tableName call SQLiteTableExists;
                sleep _sleepTime;

                _result = [] call SQLiteGetReply;

                if !(_result) then
                {
                    (format["CREATE TABLE %1(indexName TEXT, data TEXT)", _tableName]) call SQLite;
                    sleep _sleepTime;
                };


                (format["SELECT * FROM %1", _tableName]) call SQLiteGet;
                sleep _sleepTime;

                _result = [] call SQLiteGetReply;

                call compile format['RPP_gVar_arr_serverLoadedVariables_%1 = [];', _tableName];
                _i = 0;
                _newResults = [];
                _newIndex = [];
                _newData = [];
                {
                    if (_i == 1) then
                    {
                        _newData = _x;
                        _newResults = _newResults + [ [_newIndex,_newData] ];
                        _i = 0;
                    }
                    else
                    {
                        _newIndex = _x;
                        _i = 1;
                    };
                } forEach _result;

                _result = _newResults;


                {
                    _toCompile = "RPP_gVar_arr_serverLoadedVariables_"+ _tableName + " = RPP_gVar_arr_serverLoadedVariables_" + _tableName + " + [ ["+ str(_x select 0) +","+str(_x select 1)+"] ];";
                    //_toCompile = "RPP_gVar_arr_serverLoadedVariables_"+ _tableName + " = RPP_gVar_arr_serverLoadedVariables_" + _tableName + " + [ [(_x select 0), (_x select 1)] ];";

                    call compile _toCompile;
                    //call compile format['RPP_gVar_arr_serverLoadedVariables_%1 = RPP_gVar_arr_serverLoadedVariables_%1 + [ [(_x select 0), (_x select 1)] ];', _tableName];
                } forEach _newResults;

            } forEach _arrayTableNames;


        RPP_gVar_boolean_databaseInUse = false;
    };
    
    /* Load Server Users names */
    [RPP_var_saving_users] call RPP_fsav_serverRequestLoad;
    { if (_x select 3) then { [(_x select 0), RPP_var_saving_publicStorages] call RPP_fsav_serverLoadSetVariables; }; } forEach RPP_var_storages;

   // { if (_x select 3) then { [(_x select 0), RPP_gVar_arr_tables_storagesLoad] call RPP_fsav_serverLoadSetVariables; }; } forEach Gvar_arr_trunk_storages;
    //{ [(_x select 0), RPP_gVar_arr_tables_factoriesLoad] call RPP_fsav_serverLoadSetVariables; } forEach RPP_gVar_arr_fact_factorys;
    //  [stockmarket, RPP_gVar_arr_tables_stockMarketLoad] call RPP_fsav_serverLoadSetVariables;
   //   [corporations, RPP_gVar_arr_tables_corporationsLoad] call RPP_fsav_serverLoadSetVariables;
   // { [(_x select 2), RPP_gVar_arr_tables_workplacesLoad] call RPP_fsav_serverLoadSetVariables;	} forEach RPP_gVar_workplaces;
   // { [(_x select 0), RPP_gVar_arr_tables_shopsLoad] call RPP_fsav_serverLoadSetVariables;	} forEach RPP_gVar_arr_playerShops;

   // [RPP_gVar_arr_tables_serverLoad] call RPP_fsav_serverRequestLoad;
   //   [bank, RPP_gVar_arr_tables_bankReferencesLoad] call RPP_fsav_serverLoadSetVariables; 
   //   [users, RPP_gVar_arr_tables_usersLoad] call RPP_fsav_serverLoadSetVariables;
   // { [bank, [ [RPP_gVar_str_tables_bankAccounts, format["RPP_bank_acc_%1", (_x)] ]] ] call RPP_fsav_serverLoadBankAccounts; } forEach (bank getVariable "RPP_bank_accounts");


    server setVariable ["loaded",true,true];
};

RPP_fsav_serverRequestLoad =
{
    private ["_tableNames"];
    _tableNames = (_this select 0);

    {
        _tableName = (_x select 0);
        _varName = (_x select 1);
        _return = [];
        _toCompile = "_return = RPP_gVar_arr_serverLoadedVariables_"+_tableName;
        call compile _toCompile;
        //call compile format['_return = RPP_gVar_arr_serverLoadedVariables_%1', _tableName];

        {
                _getVarName = ((_x select 0) select 0);

                if (_getVarName == _varName) then
                {
                        _str = "" + _varName + " = " + (_x select 1) + ";";
                        call compile _str;
                        //call compile format['%1 = %2;', (_varName), (_x select 1)];
                };
        } forEach _return;
    } forEach _tableNames;

};

RPP_fsav_clientLoadSetVariables =
{
    private ["_object", "_tableNames", "_id"];
    _object = (_this select 0);
    _id = (_this select 1);
    _tableNames = (_this select 2);

    {
        _tableName = (_x select 0);
        _varName = (_x select 1);

        _return = [];
        _toCompile = "_return = RPP_gVar_arr_serverLoadedVariables_"+_tableName;
        call compile _toCompile;
        //call compile format['_return = RPP_gVar_arr_serverLoadedVariables_%1', _tableName];


        {
            _objName = ((_x select 0) select 0);
            _userID = ((_x select 0) select 1);

            if (typeName _object == "STRING") then
            {
                    _object = call compile _object;
            };

            if (typeName _objName == "STRING") then
            {
                    _objName = call compile _objName;
            };

            if ((str _objName) ==  (str _object)) then
            {
                if (_userID == _id) then
                {
                    _arr = (_x select 1);

                    if (typeName (_x select 1) == "STRING") then
                    {
                        _arr = call compile (_x select 1);
                    };

                    {
                        _arrVarData = (_x select 0);
                        _arrVarName = (_x select 1);

                        if (_varName == _arrVarName) then
                        {
                            [{ 
                                if (RPP_var_acc_login == (_this select 0)) then
                                {
                                        _obj = _this select 1;
                                        if (typeName _obj == "STRING") then
                                        {
                                                _obj = call compile _obj;
                                        };
                                        _obj setVariable[(_this select 2), (_this select 3), false];

                                };
                            }, 	[_id, (_objName), (_arrVarName), (_arrVarData), (_object)]] spawn RPP_fnet_execPublic;
                        };
                    } forEach _arr;
                };
            };

        } forEach _return;
    } forEach _tableNames;
};

RPP_fsav_serverLoadSetVariables =
{
    private ["_object", "_tableNames"];
    _object = (_this select 0);
    _tableNames = (_this select 1);

    {
        _tableName = (_x select 0);
        _varName = (_x select 1);

        _return = [];
        _toCompile = "_return = RPP_gVar_arr_serverLoadedVariables_"+_tableName;
        call compile _toCompile;
        //call compile format['_return = RPP_gVar_arr_serverLoadedVariables_%1', _tableName];
        {
            _objName = ((_x select 0) select 0);

            if (format["%1",_objName] == format["%1",_object]) then
            {
                {
                    _arrVarData = (_x select 0);
                    _arrVarName = (_x select 1);
                    if (_varName == _arrVarName) then
                    {
                        _object setVariable[_varName, _arrVarData, true];
                    };
                } forEach (_x select 1);
            };

        } forEach _return;
    } forEach _tableNames;
};

RPP_fsav_clientRequestLoad = 
{
    private ["_id", "_tableNames"];
    _id = (_this select 0);
    _tableNames = (_this select 1);
    
    {
        _tableName = (_x select 0);
        _varName = (_x select 1);
        _return = [];
        _toCompile = "_return = RPP_gVar_arr_serverLoadedVariables_"+_tableName;
        call compile _toCompile;
        //call compile format['_return = RPP_gVar_arr_serverLoadedVariables_%1', _tableName];

        {

            _userID = ((_x select 0) select 1);
            

            if (_userID == _id) then
            {
                [{ 
                    if (RPP_var_acc_login == (_this select 0)) then
                    {
                        _toCompile = "" + (_this select 1) + " = " + (_this select 2) + ";";
                        call compile _toCompile;
                        //call compile format['%1 = %2;', (_this select 2), (_this select 3)];
                    };
                }, [_id, (_varName), (_x select 1)]] call RPP_fnet_execPublic;
            };
        } forEach _return;

    } forEach _tableNames;
};

