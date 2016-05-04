diag_log format ["REPRO(All:init.sqf): Processing init.sqf at %1", time];

//--- Determine which machine is running this init script
SESSION_IsHostedServer = if (isServer && !isDedicated) then {true} else {false};
SESSION_IsServer = if (isDedicated || SESSION_IsHostedServer) then {true} else {false};
SESSION_IsClient = if (SESSION_IsHostedServer || !isDedicated) then {true} else {false};
SESSION_IsHeadless = if !(hasInterface || isDedicated) then {true} else {false};

diag_log format ["REPRO(All:init.sqf): Determining the environment: Hosted->[%1], Dedicated->[%2], Client->[%3], Headless->[%4] | IsMultiplayer->[%5]", SESSION_IsHostedServer, isDedicated, SESSION_IsClient, SESSION_IsHeadless, isMultiplayer];

//--- Create a resistance center (still needed?)
createCenter resistance;
resistance setFriend [west, 1];
resistance setFriend [east, 1];

//--- [Server init]
if (SESSION_IsServer) then {
	diag_log format ["REPRO(Server:init.sqf): Processing Server init at %1", time];
	
	//--- Server functions
	REPRO_SRV_AI_DelegationCreate = compileFinal preprocessFileLineNumbers "REPRO_SRV_AI_DelegationCreate.sqf";
	REPRO_SRV_AI_DelegationDelete = compileFinal preprocessFileLineNumbers "REPRO_SRV_AI_DelegationDelete.sqf";
	REPRO_SRV_RegisterHC = compileFinal preprocessFileLineNumbers "REPRO_SRV_RegisterHC.sqf";
};

//--- [Client init]
if (SESSION_IsClient) then {
	diag_log format ["REPRO(Client:init.sqf): Processing Client init at %1", time];
	
	waitUntil {!(isNull player)};
	
	//--- The action to create AI on the HC 	([Player Action] --> [Server Create the group] --> [AI are created on the HC])
	player addAction ["CREATE AI Units on the HC", {player remoteExec ["REPRO_SRV_AI_DelegationCreate", 2]}];
	//--- The action to delete AI from the HC 	([Player Action] --> [Delete AIs (Last Group - Server)])
	player addAction ["DELETE HC AI Units from the Server (Last Group)", {["Server", "LastGroup"] remoteExec ["REPRO_SRV_AI_DelegationDelete", 2]}];
	//--- The action to delete AI from the HC 	([Player Action] --> [Delete AIs (All Groups - Server)])
	player addAction ["DELETE HC AI Units from the Server (All Group)", {["Server", "AllGroups"] remoteExec ["REPRO_SRV_AI_DelegationDelete", 2]}];
	//--- The action to delete AI from the HC 	([Player Action] --> [Identify HC (Server)] --> [Delete AIs (Last Group - HC)])
	player addAction ["DELETE HC AI Units from the HC (Last Group)", {["HC", "LastGroup"] remoteExec ["REPRO_SRV_AI_DelegationDelete", 2]}];
	//--- The action to delete AI from the HC 	([Player Action] --> [Identify HC(s) (Server)] --> [Delete AIs (All Groups - HC)])
	player addAction ["DELETE HC AI Units from the HC (All Group)", {["HC", "AllGroups"] remoteExec ["REPRO_SRV_AI_DelegationDelete", 2]}];
};

//--- [Headless Client init]
if (SESSION_IsHeadless) then {
	diag_log format ["REPRO(Headless Client:init.sqf): Processing Headless Client init at %1", time];
	
	//--- Headless Client functions
	REPRO_HC_AI_DelegationDelete = compileFinal preprocessFileLineNumbers "REPRO_HC_AI_DelegationDelete.sqf";
	REPRO_HC_AI_DelegationDoCreate = compileFinal preprocessFileLineNumbers "REPRO_HC_AI_DelegationDoCreate.sqf";
	
	//--- Register the Headless Client's ID on the server
	[clientOwner, player] remoteExec ["REPRO_SRV_RegisterHC", 2];
};