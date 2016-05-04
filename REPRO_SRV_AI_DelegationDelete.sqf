_deleteFrom = _this select 0;
_deleteWhat = _this select 1;

diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationDelete): Removing units from [%1] with parameter [%2]", _deleteFrom, _deleteWhat];

switch (_deleteFrom) do {
	case "Server": { //--- The delete operation is performed on the server
		switch (_deleteWhat) do {
			case "LastGroup": { //--- Delete the last created group from the server
				if !(isNil 'REPRO_HC_GROUP_LAST') then {
					if !(isNull REPRO_HC_GROUP_LAST) then {
						//--- Remove the units from the last group
						[[REPRO_HC_GROUP_LAST, local REPRO_HC_GROUP_LAST, count units REPRO_HC_GROUP_LAST, groupOwner REPRO_HC_GROUP_LAST], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3], owner -> [%4]", _this select 0, _this select 1, _this select 2, _this select 3]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3]", REPRO_HC_GROUP_LAST, local REPRO_HC_GROUP_LAST, count units REPRO_HC_GROUP_LAST, groupOwner REPRO_HC_GROUP_LAST];
						
						{
							[[_x, REPRO_HC_GROUP_LAST, local _x], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _this select 0, _this select 1, _this select 2]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _x, REPRO_HC_GROUP_LAST, local _x];
							deleteVehicle _x;
							[[REPRO_HC_GROUP_LAST, _x], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for unit removal in group [%1], result is [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for unit removal in group [%1], result is [%2]", REPRO_HC_GROUP_LAST, _x];
						} forEach units REPRO_HC_GROUP_LAST;
						
						//--- Remove the last group
						[[REPRO_HC_GROUP_LAST, count units REPRO_HC_GROUP_LAST], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", REPRO_HC_GROUP_LAST, count units REPRO_HC_GROUP_LAST];
						
						_arrayIndex = REPRO_HC_GROUPS find REPRO_HC_GROUP_LAST;
						if (_arrayIndex > -1) then {REPRO_HC_GROUPS deleteAt _arrayIndex};
						
						deleteGroup REPRO_HC_GROUP_LAST;
						
						[REPRO_HC_GROUP_LAST, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for group removal [%1]", _this]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for group removal [%1]", REPRO_HC_GROUP_LAST];
					} else {
						[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delete the last group, it is empty at time [%1]", _this]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delete the last group, it is empty at time [%1]", time];
					};
				} else {
					[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", _this]}] remoteExec ["call", -2];
					diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", time];
				};
			};
			case "AllGroups": { //--- Delete all the groups from the server
				if !(isNil 'REPRO_HC_GROUPS') then {
					if (count REPRO_HC_GROUPS > 0) then {
						//--- Remove the units from all groups
						{
							_group = _x;
							[[_group, local _group, count units _group, groupOwner _group], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3], owner -> [%4]", _this select 0, _this select 1, _this select 2, _this select 3]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3]", _group, local _group, count units _group, groupOwner _group];
							
							//--- Remove the units from this group
							{
								[[_x, _group, local _x], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _this select 0, _this select 1, _this select 2]}] remoteExec ["call", -2];
								diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _x, _group, local _x];
								deleteVehicle _x;
								[[_group, _x], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for unit removal in group [%1], result is [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
								diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for unit removal in group [%1], result is [%2]", _group, _x];
							} forEach units _group;
							
							//--- Remove this group
							[[_group, count units _group], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", _group, count units _group];
							
							deleteGroup _group;
							
							[_group, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for group removal [%1]", _this]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Checking for group removal [%1]", _group];
						} forEach REPRO_HC_GROUPS;
						
						REPRO_HC_GROUPS = [];
						publicVariable "REPRO_HC_GROUPS";
					} else {
						[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) There are no groups to delete at time [%1]", _this]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) There are no groups to delete at time [%1]", time];
					};
				} else {
					[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", _this]}] remoteExec ["call", -2];
					diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", time];
				};
			};
		};
	};
	case "HC": { //--- The delete operation is performed on the HC
		switch (_deleteWhat) do {
			case "LastGroup": { //--- Delete the last created group from the server
				if !(isNil 'REPRO_HC_GROUP_LAST') then {
					if !(isNull REPRO_HC_GROUP_LAST) then {
						//--- Delegate the last group removal to the HC
						[[REPRO_HC_GROUP_LAST, groupOwner REPRO_HC_GROUP_LAST], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Delegating last group removal [%1] to HC ID [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Delegating last group removal [%1] to HC ID [%2]", REPRO_HC_GROUP_LAST, groupOwner REPRO_HC_GROUP_LAST];
						
						(_x) remoteExec ["REPRO_HC_AI_DelegationDelete", groupOwner REPRO_HC_GROUP_LAST];
					} else {
						[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delegate the deletion of the last group to the HC, it is empty at time [%1]", _this]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delegate the deletion of the last group to the HC, it is empty at time [%1]", time];
					};
				} else {
					[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", _this]}] remoteExec ["call", -2];
					diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", time];
				};
			};
			case "AllGroups": {
				if !(isNil 'REPRO_HC_GROUPS') then {
					if (count REPRO_HC_GROUPS > 0) then {
						//--- Delegate the group removal to the HC(s)
						{
							[[_x, groupOwner _x], {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Delegating last group removal [%1] to HC ID [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
							diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Delegating last group removal [%1] to HC ID [%2]", _x, groupOwner _x];
							
							(_x) remoteExec ["REPRO_HC_AI_DelegationDelete", groupOwner _x];
						} forEach REPRO_HC_GROUPS;
						
						REPRO_HC_GROUPS = [];
						publicVariable "REPRO_HC_GROUPS";
					} else {
						[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delegate the deletion of the groups to the HCs, There are no groups to delete at time [%1]", _this]}] remoteExec ["call", -2];
						diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) Unable to delegate the deletion of the groups to the HCs, There are no groups to delete at time [%1]", time];
					};
				} else {
					[time, {player sideChat format["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", _this]}] remoteExec ["call", -2];
					diag_log format ["REPRO(Server:REPRO_SRV_AI_DelegationCreate.sqf) No groups were ever created at time [%1]", time];
				};
			};
		};
	};
};