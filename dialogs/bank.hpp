/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_Bank
{
	idd = 300;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground, ActionsFrame, AmountFrame, TransferFrame, DescFrame };
	objects[] = { };
	controls[] = { DisplayBalance, DisplayCash, EditAmount, BtnWithdraw, BtnDeposit, BtnClose, BtnTransfer, ComboTransfer, TransferDesc, BankDesc };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.20;
            y = 0.25;
            w = 0.5;
            h = 0.5;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.175;
            y = 0.15;
            w = 0.55;
            h = 0.5;
            size = 0.035;
        };
    
        class Title : RPP_HeaderTitle1
        {
            idc = 1;
            text = "The Bank";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.20;
            y = 0.145;
            w = 0.5;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.145;
            w = 0.55;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
        
        class FooterFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.645;
            w = 0.55;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
        class DisplayBalance : RPP_StructuredText 
        {
            idc = 2;
            x = 0.200;
            y = 0.195;
            w = 0.25;
            h = 0.4;
            size = 0.025;
            text = "(Balance: $255604)";
        };
        
        class DisplayCash : RPP_StructuredText 
        {
            idc = 3;
            x = 0.5450;
            y = 0.195;
            w = 0.25;
            h = 0.4;
            size = 0.025;
            text = "(Cash: $10000000)";
        };
        
        class EditAmount : RPP_Edit
        {
            idc = 4;
            x = 0.3725;
            y = 0.24; 
            w = 0.16;
            h = 0.065;
            text = "0";
        };
        
        class BtnWithdraw : RPP_Button
        {
            x = 0.390;
            y = 0.3605;
            w = 0.12;
            h = 0.065;
            text = "Withdraw";
            action = "(parseNumber(ctrlText 4)) call RPP_fnc_withdrawBnk;";
           
        };
        
        class BtnDeposit : RPP_Button
        {
            x = 0.390;
            y = 0.50;
            w = 0.12;
            h = 0.065;
            text = "Deposit";
            action = "(parseNumber(ctrlText 4)) call RPP_fnc_depositBnk;";
           
        };
        
        class BtnClose : RPP_Button
        {
            x = 0.390;
            y = 0.571;
            w = 0.12;
            h = 0.065;
            text = "Close";
            action = "closeDialog 0;";
           
        };
        
        class BtnTransfer : RPP_Button
        {
            x = 0.390;
            y = 0.430;
            w = 0.12;
            h = 0.065;
            text = "Transfer";
            action = "[(parseNumber(ctrlText 4)), call compile lbData[6,lbCurSel 6]] call RPP_fnc_transferBnk;";
        };
        
        class ActionsFrame : RPP_Frame
        {
            x = 0.360;
            y = 0.33;
            w = 0.1825;
            h = 0.3175;
            text = "Transactions";
        };
        
        class AmountFrame : ActionsFrame 
        {
            y = 0.175;
            h = 0.15;
            text = "Amount ($)";
        };
        
        class TransferFrame : ActionsFrame
        {
            x = 0.2075;
            y = 0.33;
            w = 0.15;
            text = "Transfer";
        
        };
        
        class DescFrame : TransferFrame
        {
            x = 0.5450;
            text = "Description";
        };
        
        class ComboTransfer : RPP_ComboBox
        {
            idc = 6;
            x = 0.212;
            y = 0.595;
            w = 0.14;
            h = 0.045;
            sizeEx = 0.03121;
        };
        
        class TransferDesc : RPP_StructuredText 
        {
            idc = 5;
            x = 0.205;
            y = 0.36;
            w = 0.15;
            h = 0.4;
            size = 0.019;
            text = "To transfer money you must select the player you wish to transfer to below and hit the transfer button, the mayor can set a transfer tax though!";
        };
        
        class BankDesc : TransferDesc
        {
            idc = 7;
            x = 0.5445;
            w = 0.155;
            size = 0.019;
            text = "Welcome to the bank, from here you can manage your money by withdrawing and depositing your cash into a safe and secure place. You may also transfer your money to other players that are online.";
        
        };
};    