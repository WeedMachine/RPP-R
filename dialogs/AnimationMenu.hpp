/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_AnimationMenu
{
	idd = 900;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground };
	objects[] = { };
	controls[] = { DescFrame, Animate, CloseMenu, AnimationList};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.20;
            y = 0.25;
            w = 0.40;
            h = 0.65;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.175;
            y = 0.15;
            w = 0.45;
            h = 0.65;
            size = 0.035;
        };
    
        class Title : RPP_HeaderTitle1
        {
            idc = -1;
            text = "Player Animations";
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
            y = 0.795;
            w = 0.45;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
        class DescFrame : RPP_Frame
        {
            x = 0.22;
            y = 0.185;
            w = 0.3625;
            h = 0.51;
            text = "Select Animation";
        };
        
        class Animate : RPP_Button
        {
            idc = 3;
            x = 0.22;
            y = 0.71;
            w = 0.16;
            h = 0.065;
            text = "Do Animation";
            action = "[] call RPP_fnc_selectAnim;";
           
        };
		
        class CloseMenu : Animate 
        {
            idc = 4;
            x = 0.42;
            text = "Close Menu";
            action = "closeDialog 0;";
           
        };
		
        class AnimationList : RPP_List 
        {
            idc = 2;
            x = 0.225;
            y = 0.22;
            w = 0.35;
            h = 0.475;
            sizeEx = 0.03;
            onLBSelChanged  = "";
            default = true;
        };
};    