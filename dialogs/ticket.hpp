class ALR_Dlg_Ticket
{
    idd = 2300;
    movingEnable = false;
    controlsBackground[] = { background, header };
    objects[] = { };
    controls[] = { playerFrame, playerList, sendBtn, closeBtn, infoamount, EditAmount, message, info };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        

    class background: RPP_BackgroundFill
    {
            idc = 1200;
            text = "images\web_box1.paa";
            x = 0.355722 * safezoneW + safezoneX;
            y = 0.220455 * safezoneH + safezoneY;
            w = 0.243974 * safezoneW;
            h = 0.491383 * safezoneH;
    };
    
    class header : RPP_HeaderTitle1 
    {
        x = 0.365722 * safezoneW + safezoneX;
        y = 0.2725455 * safezoneH + safezoneY;
        text = "Ticket";
    };
    
    class playerFrame: RPP_Frame
    {
            idc = 1800;
            text = "Select Civilian";
            x = 0.378368 * safezoneW + safezoneX;
            y = 0.301732 * safezoneH + safezoneY;
            w = 0.201603 * safezoneW;
            h = 0.080737 * safezoneH;
    };
    
    class playerList : RPP_ComboBox
    {
            idc = 2100;
            x = 0.411971 * safezoneW + safezoneX;
            y = 0.331289 * safezoneH + safezoneY;
            w = 0.134395 * safezoneW;
            h = 0.0418947 * safezoneH;
    };
    
    class sendBtn : RPP_Button
    {
            idc = 1600;
            text = "Submit";
            x = 0.392249 * safezoneW + safezoneX;
            y = 0.5914597 * safezoneH + safezoneY;
            w = 0.0810669 * safezoneW;
            h = 0.0455892 * safezoneH;
            action = "[ctrlText 1400, call compile(lbData[2100, lbCurSel 2100])] call RPP_fnc_phone_sendSMS;";
    };
    
    class closeBtn : RPP_Button
    {
            idc = 1601;
            text = "Close";
            x = 0.482102 * safezoneW + safezoneX;
            y = 0.5914597 * safezoneH + safezoneY;
            w = 0.0810669 * safezoneW;
            h = 0.0455892 * safezoneH;
            action = "CloseDialog 0;";
    };
    
    class infoamount : RPP_Text
    {
            idc = 1400;
			text = "Ticket Amount";
            x = 0.377637 * safezoneW + safezoneX;
            y = 0.403028 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.0221912 * safezoneH;
    };
	
    class EditAmount : RPP_Edit
        {
            idc = 1401;
            x = 0.378368 * safezoneW + safezoneX;
            y = 0.428028 * safezoneH + safezoneY;
            w = 0.201603 * safezoneW;
            h = 0.029 * safezoneH;
			style = 0x00 + 20;
            text = "0";
        };
	
	class message : RPP_Edit
    {
            idc = 1301;
            x = 0.377637 * safezoneW + safezoneX;
            y = 0.50862 * safezoneH + safezoneY;
            w = 0.203064 * safezoneW;
            h = 0.072669 * safezoneH;
            style = 0x00 + 16;
            linespacing = 1;
    };
    
    class info : RPP_Text
    {
            idc = 1000;
            text = "Ticket Reason";
            x = 0.373984 * safezoneW + safezoneX;
            y = 0.481528 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.0221912 * safezoneH;
    };

};