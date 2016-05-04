_id = _this select 0;
_hc = _this select 1;

diag_log format ["REPRO(Server:REPRO_SRV_RegisterHC): Registering HC [%1] with ID [%2] on the server, now available for delegation", _id, _hc];

//--- Make sure that the HC list exists
if (isNil 'REPRO_HC_LIST') then {REPRO_HC_LIST = []};

//--- Add the HC to the current list
REPRO_HC_LIST pushBack [_id, _hc];

diag_log format ["REPRO(Server:REPRO_SRV_RegisterHC): The HC [%1] with ID [%2] was added to the current HC list->%3", _id, _hc, REPRO_HC_LIST];