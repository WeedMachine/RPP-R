RPP_var_paycheckTime = 480;
RPP_var_jobPaycheck = 0;
RPP_var_income = 0;
RPP_var_completeIncome = 0;
RPP_var_shopping = 0;
RPP_var_other = 0;
RPP_var_defaultCopPaycheck = 2500;

RPP_fnc_runPaycheck = 
{
    waitUntil {RPP_var_loggedIn};
    while {true} do
    {
        _time = time;
        _minutes = RPP_var_paycheckTime / 60;
        _minutesLeft = _minutes;
        
        while {(_time + RPP_var_paycheckTime) > time} do
        {
            (format[localize "STRS_paycheck_timeUntil", _minutesLeft]) call RPP_fnc_hint;
            _minutesLeft = _minutesLeft - 1;
            
            sleep 60;
        };
        
        /* Deal with paycheck here */
        if ((alive player) and (RPP_var_hasRespawned)) then
        {
            _message = "<t color='#4876FF'>Paycheck</t><br/>Your paycheck has arrived!";
            _oldBalance = RPP_var_bankAmount;

			if (player call RPP_fnc_isCop) then { /* Money for police */
				RPP_var_income = RPP_var_income + RPP_var_defaultCopPaycheck;
                RPP_var_completeIncome = RPP_var_completeIncome + RPP_var_defaultCopPaycheck;	
				_message = _message + format["<br/>Police pay: $%1", RPP_var_defaultCopPaycheck];
			};
            
            if (RPP_var_jobPaycheck > 0) then /* Money from jobs */
            {
                RPP_var_income = RPP_var_income + RPP_var_jobPaycheck;
                RPP_var_completeIncome = RPP_var_completeIncome + RPP_var_jobPaycheck;
                _message = _message + format["<br/>Income Jobs: $%1", RPP_var_jobPaycheck];
                RPP_var_jobPaycheck = 0;
            };
            
            if (RPP_var_shopping != 0) then /* Money from shopping */
            {
                RPP_var_income = RPP_var_income + RPP_var_shopping;
                _message = _message + format["<br/>Income Buying/Selling: $%1", RPP_var_shopping];
                RPP_var_shopping = 0;
            };
            
            /* Calculate shop money */
            _totalInvest = 0;
            {
                _amount = (call compile _x) call RPP_fnc_getInvestMoney;
                _totalInvest = _totalInvest + (ceil(  (random (_amount/2)) + (random (_amount/2))));
            } forEach RPP_var_invested;
            
            if (_totalInvest > 0) then /* Money from shops */
            {
                RPP_var_income = RPP_var_income + _totalInvest;
                RPP_var_completeIncome = RPP_var_completeIncome + _totalInvest;
                _message = _message + format["<br/>Income investments: $%1", _totalInvest];
            };
            
            if (RPP_var_other != 0) then /* Other purchases */
            {
                RPP_var_income = RPP_var_income + RPP_var_other;
                _message = _message + format["<br/>Other: $%1", RPP_var_other];
                RPP_var_other = 0;
            };
            
            RPP_var_bankAmount = RPP_var_bankAmount + RPP_var_completeIncome;
            [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;
            _message = _message + format["<br/>Total Income: $%1<br/>Actual Income: $%2<br/>", RPP_var_income, RPP_var_completeIncome];
            
            RPP_var_income = 0;
            RPP_var_completeIncome = 0;
            
            _message call RPP_fnc_hint;
        }
        else
        {
            localize "STRS_paycheck_dead" call RPP_fnc_hint;
        };
    };
};