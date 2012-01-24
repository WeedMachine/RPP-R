_pages = 
[ 
    ["Rules", "Rules & Guidelines"],
	["law", "Laws"],
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

player createDiaryRecord ["Rules", 
[
"General Server Rules", 
"
<br/>
Basic Rules and Laws of Chern City:<br/>
<br/>
Every player must obey and play these Rules,<br/>
This is a condition of playing to agree to the following...<br/>
<br/>
[1.0] Compliance Rules<br/>
<br/>
Compliance Rules:<br/>
<br/>
[1.1] - Death-matching will not be tolerated<br/>
<br/>
- Death-matching is killing without reason. For example, looking for a Police officer to kill just to simply kill them, or if a Civilian kills another Civilian for no legitimate reason. Civilians and Police officers should only get into firefights for reasons related to crimes.<br/>
- Other forms of Death-matching include:<br/>
- Running / Killing Police Officers when they are on a routine traffic stop when you are NOT wanted and NOT in the same gang as the person being stopped.<br/>
- Hitting / Killing other civilians because you feel like it.<br/>
- Terrorism is not an excuse for Death-matching civilians, this must be an organised strike not a cop / civilian Hunt.<br/>
<br/>
[1.2] - Do Not Hack Or Exploit Bugs<br/>
<br/>
- Hacking/Exploiting in any way shape or form and distributing throughout the community is not permitted on G[B]H.Team.com Servers.<br/>
- Bug Exploiting will not be tolerated just because there is a bug that can be exploited doesn’t mean your using it for its intended purpose. The best thing to do is tell an admin and NOT tell other players so the the bug doesn’t spread. Any type of bug exploiting will leave you no longer welcome in this community and may result in a membership suspension.<br/>
<br/>
[1.3] - Common Decency and Respect for other Players<br/>
<br/>
- Meaning of expression Common Decency<br/>
This term is usually used to demand that someone show the common decency to do X, in cases where someone has grossly violated our social conventions. eg. Bite your tongue before swearing at somebody and find the out the proper story before going Ape sh*t.<br/>
<br/>
[1.4] - Role Play Is Required!<br/>
<br/>
- Meaning of Role Play Role-playing refers to the changing of one's behaviour to assume a role, either unconsciously to fill a social role, or consciously to act out an adopted role.<br/>
- In G[B]H Roll Play Is Required in all aspects of game play, if you believe you downloaded the latest shoot’em’up Mod for Arma2 you have been terribly mistaken.<br/>
<br/>
[1.5] - Communication with others<br/>
<br/>
- Using the global channel for no other reason then its intended purpose, discussing role-play related issues, e.g. Cop “Pull Over” Civilian “Never you Pig”.<br/>
- If you have a complaint contact a In-Game Admin via Private Message on the forums or via Teamspeak in a private channel.<br/>
<br/>
Failure to comply with listed rule set stated above reserves the right for admins to execute their community role. This may result in a verbal / written warning or more serious consequences such as being kicked from the game server or even banned.<br/>
<br/>
<br/>
Enjoy Yourselves<br/>
Thankyou<br/>
Admin Team <br/>
"
]
];
player createDiaryRecord ["details", 
[
"G[B]H Bug Tracker", 
"
<br/>
http://tracker.downundermod.com/<br/>
<br/>
while this code was being re-ported bugs script errors were found and fixed<br/>
We are sure there are more and would appreciate them being reported<br/>
so they can be addressed http://tracker.downundermod.com/<br/>
"
]
];
player createDiaryRecord ["details", 
[
"Offical Team Speak 3", 
"
<br/>

125.214.66.118:10000<br/>
<br/>
Police may be insisted upon to join DU's Official TS or Change to the civilian side.<br/>
"
]
];
player createDiaryRecord ["details", 
[
"Official Website", 
"
<br/>
http://www.gbhteam.com<br/>
<br/>
Keep up with the latest news, and join our forums to keep in touch with our community.<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#29 MANSLAUGHTER", 
"
<br/>
MANSLAUGHTER: Manslaughter is the accidental death of one person by another. It will be determined by discussion with Police Officials and the victim as to whether this death was accidental, punishment will occur but will be less severe than that of Murder. If manslaughter is not found to be the crime, and it is indeed murder, that punishment WILL occur (see MURDER)<br/>
<br/>
Jail: 5 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#28 MURDER", 
"
<br/>
MURDER: Committing a homicide of either civilian or police officer's will be met with severe punishment, you must have motive to kill any player in the server, if you are found death matching (killing players for fun or no reasonable reason) will result in being banned.<br/>
<br/>
Jail: 10 min (Civ)<br/>
Jail: 15 min (Cop)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#27 ATTEMPTED MURDER", 
"
<br/>
ATTEMPTED MURDER: A person found to have attempted the murder of a civilian or to have caused enough harm for it to be classed as such will be jailed.<br/>
<br/>
Jail: 3 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#26 TERRORISM", 
"
<br/>
TERRORISM: Any person found to be in possession of Terrorist Training, or associated equipment in relation to this training will face severe punishment.<br/>
<br/>
Jail: 6 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#25 DESTRUCTION OF PROPERTY", 
"
<br/>
DESTRUCTION OF PROPERTY: Fines will be issued and restitution must be made to the owner of the property. If civilian cannot afford to pay owner of said property they will face 1 Minute Jail for each $15,000 or part thereof value of said property.<br/>
<br/>
Fine: $5000<br/>
Jail: 1 min/$15K<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#24 VEHICULAR ASSAULT", 
"
<br/>
VEHICULAR ASSAULT: Running down any person with your vehicle but failing to kill them is a serious offence, this also includes intentional use of your vehicle to ram another's (serial offenders may face jail).<br/>
<br/>
Fine: $2500<br/>
Jail: 2 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#23 ROBBERY", 
"
<br/>
ROBBERY: Civilians seen, or found to be guilty of armed robbery (even if no gain was apparent) said civilian will face jail time irrespective of whether victim lays charges. All weapons and money earned will be taken/fined to be sure assailant made no profit.<br/>
<br/>
Jail: 4 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#22 DEATH BY DANGEROUS DRIVING", 
"
<br/>
DEATH BY DANGEROUS DRIVING: As this crime incorporates two divergent crimes the assailant in question will be punished for both crimes +1 minute jail in addition to these punishments, (see RECKLESS DRIVING and MANSLAUGHTER/MURDER).<br/>
<br/>
Jail/Fine: Variable +1 minute Jail<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#21 SPEEDING", 
"
<br/>
SPEEDING: The speed limit within towns is determined by the user using the Q (50km/h) button; the W (100km/h) button is for out of towns. Fines will be issued for violators. Violations will vary from what is seen by the police officer, if the officer believes you were intent of doing an illegal speed purposely he will fine you, if the speed was accidental the officer may give a warning. This rule also applies for other vehicle offences as well.<br/>
<br/>
Fine: $500 0-15km (over)<br/>
Fine: $1000 16-20km (over)<br/>
Fine: $1500 21-40km (over)<br/>
Jail: 2min 41+km (over)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#20 RECKLESS DRIVING", 
"
<br/>
RECKLESS DRIVING: Driving a vehicle recklessly whether around other persons or not will result in fines.<br/>
<br/>
Fine: $1000<br/>
<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#19 FAIL TO STOP", 
"
<br/>
FAIL TO STOP: Failing to stop at an intersection where the road no longer continues will result in a fine as this is a dangerous practice, (remember always give way to your right).<br/>
<br/>
Fine: $500<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#18 OFF-ROADING", 
"
<br/>
OFF-ROADING: Off-Roading is NOT permitted. Civilians found to be Off-Roading without a lawful or reasonable excuse (determined by the officer) will be fined. Lawful excuses include Hunting, Fishing, Baking, Oil Drilling or other legitimate civilian employ (taking a shortcut is not).<br/>
<br/>
Fine: $500<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#17 DRIVING/FLYING UNLICENCED", 
"
<br/>
DRIVING/FLYING UNLICENCED: Unlicensed driving /flying will be met with harsh penalties.<br/>
<br/>
Fine: $10,000 (Car)<br/>
Fine: $15,000 (Air)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#16 ABANDONMENT OF VEHICLE", 
"
<br/>
ABANDONMENT OF VEHICLE: Any civilian found to have left a vehicle in a place which is not a car park with no intention of claiming this vehicle again in a short period of time will be found guilty of vehicle abandonment. Vehicle WILL be impounded and civilian will be fined when next seen for said crime.<br/>
Impound: Vehicle<br/>
<br/>
Fine: $1000<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#15 FAILURE TO STOP/EVASION", 
"
<br/>
FAILURE TO STOP/EVASION: Failure to comply/resisting arrest is a pain for all police involved, heavy fines and on occasion (for serial offenders) jail time will be issued. In particular this law relates to not pulling a vehicle over when directed, but also to not following orders (see COMPLIANCE #2)<br/>
<br/>
Fine: $2000<br/>
Jail: 2 mins<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#14 VEHICLE SAFETY (LIGHTS", 
"
<br/>
VEHICLE SAFETY (LIGHTS): Civilians found to be flying or driving vehicles without appropriate night time illumination (lights) will be fined as this is a safety issue for other civilians.<br/>
<br/>
Fine: $5000 (Air)<br/>
Fine: $500 (Car)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#13 AIDING AND ABETING", 
"
<br/>
AIDING AND ABETING: Civilians found to be aiding criminals in the escape or evasion of pursuit will be guilty of a crime.<br/>
<br/>
Jail: 3 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#12 ILLEGAL IMMIGRATION", 
"
<br/>
ILLEGAL IMMIGRATION: Civilians found to be crossing the border without a Passport issued by the Government of Chern City will face fines and/or jail for attempting to cross border without said passport.<br/>
<br/>
Fine: $10,000<br/>
Jail: 2 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#11 FALSE REPORT", 
"
<br/>
FALSE REPORT: Misleading information given by a civilian will lead to jail time, wasting a police officer's time will then come back to you ten-fold.<br/>
<br/>
Jail: 5 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#10 NARCOTICS/WHALE", 
"
<br/>
NARCOTICS: If you have narcotics on you/within your vehicle or illegal weapons, you will face jail time, this will also include any passengers of the vehicle found containing drugs or persons who have drugs on them, so make sure when hitchhiking you know what people have within the vehicle. This includes Whale<br/>
<br/>
Jail: 3 min 0-100k worth<br/>
Jail: 5 min 100-200k worth<br/>
Jail: 7 min 200k+ worth<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#9 GRAND THEFT AUTO", 
"
<br/>
GRAND THEFT AUTO: If found committing or have committed grand theft auto you will face jail time.<br/>
<br/>
Jail: 5 min (Civ)<br/>
Jail: 7 min (Cop)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#8 JAIL BREAK", 
"
<br/>
JAIL BREAK: If you are caught attempting to break out of jail or break someone out of jail both violators will be jailed, jail time will increase on your original jail time, the person attempting to assist the jail break will receive the same time as the person who was in jail.<br/>
<br/>
Jail : +5 min <br/>
"
]
];
player createDiaryRecord ["law", 
[
"#7 RANDOM SEARCH", 
"
<br/>
RANDOM SEARCH: Police officers are permitted to search any vehicle OR house at anytime, random vehicle checks will take place, and if you are non-co-operative you will be placed under arrest and fined for your misconduct, if you display misconduct, officers will jail you, excessiveness of misconduct and stupid behaviour will result in yourself being banned.<br/>
<br/>
Fine : $1000 (non-cooperation)<br/>
Jail : 3 min (misconduct)<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#6 COMPLIANCE #2", 
"
<br/>
COMPLIANCE #2: When a police officer requests you pull over on the VOIP or Team Speak, when in the vicinity you are to do so, if you do not respond when given a direct order be it to pull over, get on the ground, put your hands up, do not move etc, the police officer then has probable cause to stun you. If the officer feels his safety is in danger within good reason that officer may fire lethal rounds to warn or kill you. If the officer fears for his safety he will warn you once, then if you continue to disregard the order the officer is permitted open fire, if the threat is imitate the officer may fire without warning. Not following orders will result in jail time if the officer has subdued you.<br/>
<br/>
Jail : 3 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#5 COMPLIANCE", 
"
<br/>
COMPLIANCE: If you see a police officer with lights/sirens on, pull to the side of the road and comply with their instruction. Failure to do so will result in punishment. If they continue past you, they are obviously on their way to a job and you may carry on.<br/>
<br/>
Fine : $500<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#4 PROSTITUTION", 
"
<br/>
PROSTITUTION: Civilians found to be soliciting prostitutes for sex, in exchange for money will be jailed.<br/>
<br/>
Jail : 2 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#3 THREAT WITH A FIREARM", 
"
<br/>
THREAT WITH A FIREARM: Aiming any kind of firearm at officers/civilians will likely be met with deadly force. This is allowed and if an officer chooses non-lethal force, you will be jailed.<br/>
<br/>
Jail : 5 min<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#2 WEAPONS #2", 
"
<br/>
WEAPONS #2: If asked by a police officer if you or your property (car) is in possession of a firearm and you give the Officer incorrect information, you will be fined.<br/>
<br/>
Fine : $5000<br/>
"
]
];
player createDiaryRecord ["law", 
[
"#1 UNHOLSTERED WEAPON", 
"
<br/>
UNHOLSTERED WEAPON: Handguns/Rifles un-holstered within/outside towns are not permitted; they must be holstered at all times (Unless being used in an authorised area (e.g. Hunting Grounds)). Punishment for violation of this law will result in jail time.<br/>
<br/>
Jail : 2 min<br/>
"
]
];
player createDiaryRecord ["changelog", 
[
"DU 2.2", 
"
<br/>
ADDED:<br/>
Added Server Refresh Script<br/>
Added Server Load Check to your radio<br/>
Added Unflip Vechicle to your radio<br/>
Added realestate License to Donating players<br/>
Added ability to plant, and grow apples<br/>
Added apples to market and shop arrays<br/>
Added demand to status menu for apples<br/>
Added new laws for Down Under. Found in briefing<br/>
Added ability for Cops to elect in Chief in Cop bases<br/>
Re-introduced military base<br/>
NZ Civ slots<br/>
NZ Police slots<br/>
Added NZ Civ Spawn<br/>
Added NZ Cop Spawn<br/>
<br/>
FIXED:<br/>
Fixed Esocrt Giving X Cords<br/>
Fixed Cavair Bug<br/>
Fixed Selling to many Barracks to shops<br/>
Fixed Spam on shops<br/>
Fixed Double Licensing<br/>
Fixed General Police Box<br/>
Fixed Servo Bounty Infomation<br/>
Fixed Hot spots for Veiw Trunk on Air Vechicles<br/>
Fixed Crop strength in status menu for Wheat<br/>
Fixed Cops from being elected Mayor<br/>
Fixed Civs from being elected Police Chief<br/>
Many multiple small script errors<br/>
Rebalancing has made more jobs more viable<br/>
Fixed Taxi missions<br/>
Fixed ability to cut power by blowing power plant<br/>
<br/>
UPDATED:<br/>
Major Update on car radio. Off, Light and Full options now available<br/>
Re-built briefing.sqf<br/>
<br/>
CHANGED:<br/>
Changed Speed Cams at 103 being the limit<br/>
Changed songs available on Radio<br/>
Revamped item pricings for balance<br/>
Revamped item weights for Balance<br/>
Changed map to Duala, away from ArmA map, to ArmA II map. Reduce bugs and map issues<br/>
Changed stun script. Now when stuned, vehciles are locked to stop exploiting<br/>
<br/>
REMOVED:
Removed 1/5 Graphics setting option for Balacing of gameplay<br/>
<br/>
while this code was being re-ported bugs script errors were found and fixed<br/>
We are sure there are more and would appreciate them being reported<br/>
so they can be addressed http://tracker.downundermod.com/<br/>
"
]
];

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