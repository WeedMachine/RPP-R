/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_Login
{
	idd = 1400;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground, LoginFrame, RulesFrame; LoginTitle };
	objects[] = { };
	controls[] = { LoginWelcome, Password, LoginDesc, PasswordDesc, PID, LoginConfirmDesc, LoginButton, Rules };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.02;
            y = 0.06;
            w = 0.9;
            h = 0.9;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.015;
            y = 0.06;
            w = 0.95;
            h = 0.9;
            size = 0.035;
        };
        
        class LoginFrame : RPP_Frame
        {
            idc = 2;
            x = 0.15;
            y = 0.38;
            w = 0.67;
            h = 0.12;
            text = "Login";
        };
        
	class RulesFrame : LoginFrame
        {
            y = 0.6;
            h = 0.33;
            text = "Server Rules - (Last Updated: 06/10/11 @ 15:00)";
        };
        
        class Rules : RPP_List
        {
            idc = 11;
            y = 0.635;
            h = 0.33;
            w = 0.67;
            x = 0.15;
        };
        
        class LoginTitle : RPP_StructuredText 
        {
            idc = 3;
            x = 0.11;
            y = 0.11;
            w = 0.85;
            h = 0.2;
            size = 0.08;
            text = "- Welcome to RP-Project: Reloaded -";
        };
        
        class LoginWelcome : RPP_StructuredText
        {
            idc = 5;
            x = 0.1;
            y = 0.2;
            w = 0.8;
            h = 0.4;
            text = "";
        };
		
	class LoginConfirmDesc : RPP_StructuredText
        {
            idc = 8;
            x = 0.148;
            y = 0.54;
            w = 0.8;
            h = 0.15;
            text = "By clicking Register you agree to the server rules below.";
        };
        
        
        class Title : RPP_HeaderTitle1
        {
            idc = 1;
            x = 0.06;
            y = 0.06;
            text = "Welcome to RP-Project: Reloaded";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.010;
            y = 0.055;
            w = 0.9;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.015;
            y = 0.055;
            w = 0.95;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
		
	class FooterFill : RPP_BackgroundFill
        {
            x = 0.015;
            y = 0.96;
            w = 0.95;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
	class LoginDesc : RPP_StructuredText
        {
            idc = 5;
            x = 0.165;
            y = 0.432;
            w = 0.4;
            h = 0.4;
            text = "Player ID:";
            size = 0.04;
        };
		
	class PID : RPP_Edit
        {
            idc = 4;
            x = 0.295; 
            y = 0.42;   
            w = 0.12;
            h = 0.065;
            text = "1234567";
            
        };
		
		
	class PasswordDesc : LoginDesc
        {
            idc = 6;
            x = 0.45;
            text = "Password:";
        };
		
	class Password : PID
        {
            idc = 7;
            x = 0.58;  
            w = 0.22;
            text = "Password";
        };
		
	class LoginButton : RPP_Button
        {
            idc = 10;
            x = 0.618;
            y = 0.525;
            text = "";
        };
     
};    