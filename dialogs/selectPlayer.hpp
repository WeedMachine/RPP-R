class RPP_Dlg_SelectPlayer
{
    idd = 3000;
    movingEnable = false;
    controlsBackground[] = { Background };
    objects[] = { };
    controls[] = { selectUnit, selectBtn, closeBtn };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

    class Background : RPP_BackgroundFill
    {
            idc = 1200;
            text = "images\web_box1.paa";
            x = 0.381289 * safezoneW + safezoneX;
            y = 0.35838 * safezoneH + safezoneY;
            w = 0.216213 * safezoneW;
            h = 0.201986 * safezoneH;
    };
    
    class selectUnit : RPP_ComboBox
    {
            idc = 2100;
            x = 0.405397 * safezoneW + safezoneX;
            y = 0.401482 * safezoneH + safezoneY;
            w = 0.168 * safezoneW;
            h = 0.0418947 * safezoneH;
    };
    
    class selectBtn : RPP_Button
    {
            idc = 1600;
            text = "Select";
            x = 0.404667 * safezoneW + safezoneX;
            y = 0.481528 * safezoneH + safezoneY;
            w = 0.0788753 * safezoneW;
            h = 0.0455891 * safezoneH;
            action = "(call compile (lbData [2100,lbCurSel 2100])) call RPP_fnc_medical_begin;";
    };
    
    class closeBtn : RPP_Button
    {
            idc = 1601;
            text = "Close";
            x = 0.493059 * safezoneW + safezoneX;
            y = 0.481527 * safezoneH + safezoneY;
            w = 0.0788753 * safezoneW;
            h = 0.0455891 * safezoneH;
            action = "CloseDialog 0;";
    };

};