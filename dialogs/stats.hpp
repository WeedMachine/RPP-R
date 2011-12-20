/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_Stats
{
	idd = 700;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground, WeatherFrame, StatsFrame, AdminsOnlineFrame };
	objects[] = { };
	controls[] = { BtnClose, MissionDesc, WeatherIcon, StatsList, AdminList, WeatherList};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.15;
            y = 0.25;
            w = 0.6;
            h = 0.5;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.125;
            y = 0.15;
            w = 0.655;
            h = 0.5;
            size = 0.035;
        };
    
        class Title : RPP_HeaderTitle1
        {
            idc = 1;
            x = 0.155;
            text = "Stats Menu";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.15;
            y = 0.145;
            w = 0.605;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.125;
            y = 0.145;
            w = 0.655;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
        
        class FooterFill : RPP_BackgroundFill
        {
            x = 0.125;
            y = 0.645;
            w = 0.655;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
		
        class StatsFrame : RPP_Frame
        {
            y = 0.1755; 
            x = 0.175;
            h = 0.3;  
            w = 0.35;
            text = "Player Stats";
        };
		
        class WeatherFrame : StatsFrame
        {
            x = 0.175; 
            y = 0.48;
            w = 0.371; 
            h = 0.15;
            text = "Time & Weather";
        };
        
        class AdminsOnlineFrame : StatsFrame
        {
            x = 0.55; 
            h = 0.2;
            w = 0.1825;
            text = "Admins Online";
        };
		
        class BtnClose : RPP_Button
        {
            x = 0.555;
            y = 0.573;
            w = 0.1825;
            h = 0.055;
            text = "Close";
            action = "closeDialog 0;";
           
        };
        
        class MissionDesc : RPP_StructuredText 
        {
            idc = 5;
            x = 0.55;
            y = 0.45;
            w = 0.18;
            h = 0.4;
            size = 0.0235;
            text = "RP Project: Reloaded<br/><br/>http://rp-project.net";
        };
		
        class WeatherIcon : RPP_BackgroundFill
        {
            idc = 9;
            x = 0.18; 
            y = 0.51;
            w = 0.12; 
            h = 0.12;
            colorBackground[] = {0,0.055,0.14,1};
            text = "";
            sizeEx = 0.032;
        };
		
        class StatsList : RPP_List 
        {
            idc = 10;
            x = 0.174;
            y = 0.21;
            w = 0.34;
            h = 0.255;
            sizeEx = 0.021;
            onLBSelChanged  = "";
        };
		
        class PlayersList : StatsList
        {
            idc = 11;
            x = 0.362;
        };
        class AdminList : StatsList
        {
            idc = 12;
            x = 0.551;
            y = 0.21;
            h = 0.157;
            w = 0.18;
        };
		
        class WeatherList : StatsList
        {
            idc = 13;
            x = 0.3;
            y = 0.52;
            w = 0.2452;
            h = 0.13;
            sizeEx = 0.02;
            onLBSelChanged  = "";
        };
		
};    