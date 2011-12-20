class RPP_Dlg_Arrest
{
    idd = 2100;
    movingEnable = false;
    controlsBackground[] = { Background, Header, Footer, ArrestFrame, JailFrame };
    objects[] = { };
    controls[] = { Suspects, Prisoners, JailTime, BtnClose, BtnArrest, BtnRelease, ArrestTime, JailInfo, Title  };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
    class Background : RPP_BackgroundFill
    {
            idc = 1200;
            text = "images\center_webbox1.paa";
            x = 0.355721 * safezoneW + safezoneX;
            y = 0.288187 * safezoneH + safezoneY;
            w = 0.289266 * safezoneW;
            h = 0.424883 * safezoneH;
    };
    
    class Title : RPP_HeaderTitle1 
    {
        x = 0.37 * safezoneW + safezoneX;
        y = 0.2625 * safezoneH + safezoneY;
        text = "Arrest/Release";
    };
    
    class Header : RPP_BackgroundFill
    {
            idc = 1201;
            text = "images\header_webbox1.paa";
            x = 0.3555 * safezoneW + safezoneX;
            y = 0.259863 * safezoneH + safezoneY;
            w = 0.290 * safezoneW;
            h = 0.0283485 * safezoneH;
    };
    
    class Footer : RPP_BackgroundFill
    {
            idc = 1202;
            text = "images\footer_webbox1.paa";
            x = 0.355723 * safezoneW + safezoneX;
            y = 0.711813 * safezoneH + safezoneY;
            w = 0.289266 * safezoneW;
            h = 0.0184967 * safezoneH;
    };
    
    class ArrestFrame : RPP_Frame
    {
            idc = 1800;
            text = "Arrest";
            x = 0.374716 * safezoneW + safezoneX;
            y = 0.294344 * safezoneH + safezoneY;
            w = 0.250548 * safezoneW;
            h = 0.163811 * safezoneH;
    };
    
    class JailFrame : RPP_Frame
    {
            idc = 1801;
            text = "Jail Time";
            x = 0.374715 * safezoneW + safezoneX;
            y = 0.46675 * safezoneH + safezoneY;
            w = 0.250548 * safezoneW;
            h = 0.163811 * safezoneH;
    };
    
    class Suspects : RPP_ComboBox
    {
            idc = 2100;
            x = 0.379829 * safezoneW + safezoneX;
            y = 0.327741 * safezoneH + safezoneY;
            w = 0.138047 * safezoneW;
            h = 0.0369688 * safezoneH;
    };
    
    class ArrestTime : RPP_Text
    {
            idc = 5;
            x = 0.396632 * safezoneW + safezoneX;
            y = 0.40 * safezoneH + safezoneY;
            w = 0.177496 * safezoneW;
            h = 0.0234227 * safezoneH;
            size = 0.019;
            text = "Time: ";
    };   
    
    class JailInfo : RPP_StructuredText 
    {
        idc = 6;
        x = 0.375 * safezoneW + safezoneX;
        y = 0.50 * safezoneH + safezoneY;
        w = 0.25 * safezoneW;
        h = 0.085 * safezoneH;
        size = 0.021;
        text = "You can select a prisoner to be released on the list below, it is recommended to only release a prisoner if a mistake has been made.";
    };
    
    class JailTime : RPP_SliderH
    {
            idc = 1900;
            text = "";
            x = 0.396632 * safezoneW + safezoneX;
            y = 0.429807 * safezoneH + safezoneY;
            w = 0.177496 * safezoneW;
            h = 0.0234227 * safezoneH;
            onSliderPosChanged  = "[] call RPP_fnc_pol_updateArrest;";
    };
    
    class BtnArrest : RPP_Button
    {
            idc = 1600;
            text = "Arrest";
            x = 0.533238 * safezoneW + safezoneX;
            y = 0.327741 * safezoneH + safezoneY;
            w = 0.0810668 * safezoneW;
            h = 0.0382004 * safezoneH;
            action = "[call compile(lbData [2100, lbCurSel 2100]), player, (round(sliderPosition 1900))] call RPP_fnc_pol_arrestPlayer;";
    };
    
    class BtnClose : RPP_Button
    {
            idc = 1601;
            text = "Close";
            x = 0.456533 * safezoneW + safezoneX;
            y = 0.644082 * safezoneH + safezoneY;
            w = 0.0803363 * safezoneW;
            h = 0.0517465 * safezoneH;
            action = "closeDialog 0;";
    };
    
    class BtnRelease : RPP_Button
    {
            idc = 1602;
            text = "Release";
            x = 0.532508 * safezoneW + safezoneX;
            y = 0.578814 * safezoneH + safezoneY;
            w = 0.0810668 * safezoneW;
            h = 0.0382004 * safezoneH;
            action = "[""RPP_fnc_pol_prisonerReleased"", [call compile(lbData [2101, lbCurSel 2101]), player]] call RPP_fnet_execPublic;";
    };
    
    class Prisoners : RPP_ComboBox
    {
            idc = 2101;
            x = 0.384212 * safezoneW + safezoneX;
            y = 0.581277 * safezoneH + safezoneY;
            w = 0.138047 * safezoneW;
            h = 0.0369688 * safezoneH;
            action = "";
    };

};