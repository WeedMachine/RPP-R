/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RscTitles
{
    titles[] = {RPP_Dlg_UI, RPP_Dlg_Progress };

    class RPP_Dlg_UI
    {   
        idd = 100;
        movingEnable = true;
        controlsBackground[] = { Background, moneyText };
        duration = 100000000;
        fadein = 0;
        name = "RPP_Dlg_UI";    
        objects[] = { };
        controls[] = { };
        onLoad = "RPP_display_ui = _this;";
        
        class Background : RPP_BackgroundFill
        {
            x = 0.0925;
            y = safeZoneY;
            w = 0.82;
            h = 0.065;
            text = "images\rpp_head.paa";
            colorBackground[] = {0.9, 0.9, 0.9, 0.85};
            colorText[] = {0.9, 0.9, 0.9, 0.85};
        };
        
        class moneyText : RPP_StructuredText
        {
            idc = 1;
            x = 0.135;
            y = safeZoneY;
            w = 0.75;
            h = 0.3;
            size = 0.025;
            text = "";
        };
    };  

    class RPP_Dlg_Progress
    {
        idd = 400;
        movingEnable = true;
        controlsBackground[] = { progressText };
        duration = 100000000;
        fadein = 0;
        name = "RPP_Dlg_Progress";    
        objects[] = { };
        controls[] = { };
        onLoad = "RPP_display_progress = _this;";
        
        class progressText : RPP_StructuredText
        {
            idc = 1;
            x = 0.40;
            y = 0.5;
            w = 1.75;
            h = 0.3;
            size = 0.025;
            text = "Progress: 0%";
        };
    
    };

};