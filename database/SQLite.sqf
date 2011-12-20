//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

SQLiteConnect = 
{
    private ["_servername", "_database", "_username", "_password", "_toSend"];
    _servername = (_this select 0);
    _database = (_this select 1);
    _username = (_this select 2);
    _password = (_this select 3);
    _toSend = format["['A2U-COMMAND','SQL','connect','%1','%2','%3','%4']", _servername, _database, _username, _password];
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLite = 
{
    private ["_command", "_toSend"];
    _command = _this;
    _toSend = format["['A2U-COMMAND','SQL','SQL','%1']", _command];
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteUpdate = 
{
    private ["_command", "_toSend"];
    _command = _this;
    _toSend = _command;
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteInsert =
{
    private ["_command", "_toSend"];
    _command = _this;
    _toSend = _command;
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteCommit = 
{
    private ["_toSend"];
    _toSend = "";
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteAutoCommit = 
{
    private ["_command", "_toSend"];
    _command = _this;
    _toSend = format["", _command];
    sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteGet = 
{
    private ["_command", "_toSend", "_result"];
    _command = _this;
    _toSend = format["['A2U-COMMAND','SQL','getSQL','%1']", _command];
    _result = "";
    //sleep 0.05;

    copyToClipboard _toSend;

    _result = call SQLiteGetReply;
};

SQLiteTableExists =
{
    private ["_table", "_toSend", "_result"];
    _table = _this;
    _toSend = format["['A2U-COMMAND','SQL','exists','pragma table_info(%1)']", _table];
    _result = "";
    //sleep 0.05;

    copyToClipboard _toSend;
};

SQLiteGetReply =
{
    private ["_found", "_result"];
    _found = false;
    _result = "";
    //sleep 0.05;
    while {!_found} do
    {
        _result = copyFromClipboard;
        if ((_result != "-waiting for reply-")) then
        {
            //player groupchat format["RESULT %1", copyFromClipboard];
            try
            {

                _result = call compile _result;
                _found = true;
            } catch { _found = false; };
        };
    };

    _result
};