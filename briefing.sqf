_pages = 
[ 
    ["Rules", "Rules & Guidelines"],
    ["Info", "Information"],
    ["Tutorial", "Tutorial"],
    ["Credits", "Credits"],
    ["Changelog", "Changelog"]
];

{
    _subject = (_x select 0);
    _title = (_x select 1);
    
    player createDiarySubject[_subject,_title];
} forEach _pages;

player selectDiarySubject "Rules"; 

player createDiaryRecord
["Tutorial",["Tutorial",
"No current tutorial."
]];

player createDiaryRecord
["Rules",["Server Rules",
"<img image=""images\project_logo.paa""/><br/>
All players are required to read these rules before playing on the RPP server. Not knowing the rules is not an excuse for breaking them. The rules are subject to change at any time, but advance notice will be given where possible.
<br/>
<br/>
1. GENERAL RULES<br/>
1.1. The server language is English. Use English on global, side, and command channels.<br/>
1.2. Hacking, glitching, or bug abuse will result in a ban.<br/>
1.3. No racism, excessive cursing, personal insults (out of character). This also applies to Teamspeak.<br/>
1.4. Copies of ARMA2 or OA identified as illegal or pirated will be banned.<br/>
1.5. The ping limit is 300m/s. Higher pings allowed at the discretion of the server admins.<br/>
1.6. You may only have one account on the server. You may have two characters on this account; no more than one for civs, no more than one for cops (if you are allowed to play cop).<br/>
1.7. Do not intentionally mislead new players about the game.<br/>
1.8. No macros.<br/>
<br/>
<br/>
2. ALL PLAYERS<br/>
2.1. There is NO new life rule.<br/>
2.2. All players are required to roleplay; this means acting in a realistic way. No intentional ruining of roleplay, or spreekilling/deathmatching, or pointless destruction will be allowed.<br/>
2.3. Do not use manual respawn or intentional suicide to avoid roleplay situations, or as a way to travel somewhere else.<br/>
2.4. Do not use weapons you got as a cop if playing as civ.<br/>
<br/>
<br/>
3. COPS<br/>
3.1. Do not play as cop unless you have been accepted onto the official police roster.<br/>
3.2. (NOT IN USE) Cops may NOT use global, side, or command channel for in-character communications. The only exception is for announcements, which must not be questions.<br/>
3.3. Do not use the civilian Teamspeak channels.<br/>
3.4. Only use lethal force to protect your own life, the lives of other cops, or the lives of innocent civs. Do not intentionally shoot other cops.<br/>
<br/>
<br/>
4. CIVILIANS (CIVS)<br/>
4.1. (NOT IN USE) Civilians may NOT use global, side, or command channel for in-character communication. The only exception is for news/radio broadcasts, and announcements from the mayor. Do not reply to announcements on these channels.<br/>
4.2. Do not use the cop Teamspeak channels.<br/>
<br/>
<br/>
5. ADMINS<br/>
5.1. Admins should always have fraps running, or some other way to take screenshots.<br/>
5.2. Always use #logout if you are afk, alt-tabbed, or not doing anything that requires you to be logged in.<br/>
5.3. If it is unclear whether a rule has been broken, admins may use their discretion to deal with the situation.<br/>
"
]];

player createDiaryRecord
["Info",["Website",
"<img image=""images\project_logo.paa""/><br/>
http://www.rp-project.net/<br/>
<br/>
The official home of the Roleplay Project: Reloaded!
"
]];

player createDiaryRecord
["Changelog",["Version: 1.0",
"<img image=""images\project_logo.paa""/><br/>
Version: 0.1<br/>
Date Released: November 14th 2011<br/>
Changes:<br/>
First closed beta release of the mission.
"
]];

player createDiaryRecord
["Credits", ["Developers",
"<img image=""images\project_logo.paa""/><br/>
Unforgiven, [Lead Developer, Scripting]<br/>
Jason, [Dialogs]<br/>
Somebloke, [Sounds]<br/>
Andrew, [RTE Editing]<br/>
Thunderstruck, [RTE Editing]<br/>
Baycity-rpg, [Models]<br/>
"]];

player createDiaryRecord
["Credits", ["Staff",
"<img image=""images\project_logo.paa""/><br/>
---Lead Admin---<br/>
Jason<br/>
Unforgiven<br/>
<br/>
---Senior Admins---<br/>
GreenGerkin<br/>
Slikbaz<br/>
Thunderstruck<br/>
Hammer<br/>
<br/>
--- Server Admins---<br/>
Aku<br/>
Ashrac<br/>
Ghostrider<br/>
Andrew<br/>
Knock0<br/>
Preacher<br/>
"]];

player createDiaryRecord
["Credits", ["Addons",
"<img image=""images\project_logo.paa""/><br/>
Lester, [MAP Editorupgrade (EU)]<br/>
Commander1985, [Island Cicada]<br/>
Laertes, [Chernarus National Police]<br/>
Gnome_AS, [AS Editor Update - Full]<br/>
"]];