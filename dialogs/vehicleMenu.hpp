/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_VehicleMenu
{
	idd = 600;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground };
	objects[] = { };
	controls[] = { DescFrame, TrunkFrame, VclFrame, TrunkAccess, TrunkLock, VclPullout, VclLock, Information };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.20;
            y = 0.25;
            w = 0.40;
            h = 0.5;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.175;
            y = 0.15;
            w = 0.45;
            h = 0.5;
            size = 0.035;
        };
    
        class Title : RPP_HeaderTitle1
        {
            idc = -1;
            text = "Vehicle Menu";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.20;
            y = 0.145;
            w = 0.40;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.145;
            w = 0.45;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
        
        class FooterFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.645;
            w = 0.45;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
        class DescFrame : RPP_Frame
        {
            x = 0.22;
            y = 0.170;
            w = 0.3625;
            h = 0.15;
            text = "Information";
        };
        
        class TrunkFrame : RPP_Frame
        {
            x = 0.22;
            y = 0.325;
            w = 0.3625;
            h = 0.15;
            text = "Trunk";
        };
        
        class VclFrame : RPP_Frame
        {
            x = 0.22;
            y = 0.48;
            w = 0.3625;
            h = 0.15;
            text = "Vehicle";
        };
        
        class TrunkAccess : RPP_Button
        {
            idc = 5;
            x = 0.25;
            y = 0.3725;
            w = 0.12;
            h = 0.065;
            text = "Open";
            action = "";
           
        };
        
        class TrunkLock : RPP_Button
        {
            idc = 4;
            x = 0.425;
            y = 0.3725;
            w = 0.12;
            h = 0.065;
            text = "Lock/Unlock";
            action = "";
        };
        
        class VclPullout : RPP_Button
        {
            idc = 3;
            x = 0.25;
            y = 0.5325;
            w = 0.12;
            h = 0.065;
            text = "Pullout";
            action = "";
           
        };
        
        class VclLock : RPP_Button
        {
            idc = 2;
            x = 0.425;
            y = 0.5325;
            w = 0.12;
            h = 0.065;
            text = "Lock/Unlock";
            action = "";        
        };
        
        class Information : RPP_StructuredText 
        {
            idc = 1;
            x = 0.22;
            y = 0.205;
            w = 0.375;
            h = 0.4;
            size = 0.021;
            text = "";
        };
};    