#include "nw_i0_spells"

#include "sqla_main"
#include "stda_locmanips"
#include "cosa_constants"

object cosGetPCWaypoint(object oPC);
object cosCreatePCWaypoint(object oPC);
void cosSaveLocalValue(object oPC, string sVarName, string sValue);
void cosSetLocalInt(object oPC, string sVarName, int iValue, int iPersistant = TRUE);
int cosGetLocalInt(object oPC, string sVarName, int iPersistant = TRUE);
void cosSetLocalString(object oPC, string sVarName, string sString, int iPersistant = TRUE);
string cosGetLocalString(object oPC, string sVarName, int iPersistant = TRUE);
void cosSetLocalLocation(object oPC, string sVarName, location lLoc, int iPersistant = TRUE);
location cosGetLocalLocation(object oPC, string sVarName, int iPersistant = TRUE);
int cosGetPCId(object oPC);
int cosIsNewPC(object oPC);
void cosCreatePCId(object oPC);
int cosGetAccountId(object oPC);
int cosHasNewAccount(object oPC);
void cosCreateAccountId(object oPC);
int cosGetPublicCDKeyId(object oPC);
int cosHasNewPublicCDKey(object oPC);
void cosCreatePublicCDKeyId(object oPC);
void cosLinkAccountToKey(object oPC);
void cosStartLocationManager(object oPC);
void cosUpdateLastConnexion(object oPC);
void cosGive(object oPC, string sTag, string sResRef);
void cosGivePlayerTools(object oPC);

int cosGetPCId(object oPC) {
    int iId = cosGetLocalInt(oPC, COS_PC_ID, FALSE);
    if (iId == 0) {
        iId = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(GetName(oPC))+";");
        if (iId != 0) {
            cosSetLocalInt(oPC, COS_PC_ID, iId, FALSE);
        }
    }
    return iId;
}

int cosIsNewPC(object oPC) {
    if (cosGetPCId(oPC) == 0) {
        return TRUE;
    }
    return FALSE;
}

void cosCreatePCId(object oPC) {
   if (cosHasNewAccount(oPC)) {
       cosCreateAccountId(oPC);
   }
   if (cosHasNewPublicCDKey(oPC)) {
       cosCreatePublicCDKeyId(oPC);
   }
   cosLinkAccountToKey(oPC);
   sqlExecDirect("INSERT INTO "+COS_SQLT_CHAR+" ("+COS_SQLF_NAME+","+COS_SQLF_ID_ACCOUNT+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetName(oPC))+","+IntToString(cosGetAccountId(oPC))+", NOW());");
}

int cosGetAccountId(object oPC) {
    int iId = cosGetLocalInt(oPC, COS_PC_ACCOUNT_ID, FALSE);
    if (iId == 0) {
        iId = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(GetPCPlayerName(oPC))+";");
        if (iId != 0) {
            cosSetLocalInt(oPC, COS_PC_ACCOUNT_ID, iId, FALSE);
        }
    }
    return iId;
}

int cosHasNewAccount(object oPC) {
     if (cosGetAccountId(oPC) == 0) {
         return TRUE;
     }
     return FALSE;
}

void cosCreateAccountId(object oPC) {
     sqlExecDirect("INSERT INTO "+COS_SQLT_ACCOUNT+" ("+COS_SQLF_NAME+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetPCPlayerName(oPC))+", NOW());");
}

int cosGetPublicCDKeyId(object oPC) {
    int iKey = cosGetLocalInt(oPC, COS_PC_KEY_ID, FALSE);
    if (iKey == 0) {
        iKey = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY+" WHERE "+COS_SQLF_VALUE+" = "+sqlQuote(GetPCPublicCDKey(oPC))+";");
        if (iKey != 0) {
            cosSetLocalInt(oPC, COS_PC_KEY_ID, iKey, FALSE);
        }
    }
    return iKey;
}

int cosHasNewPublicCDKey(object oPC) {
     if (sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY+" WHERE "+COS_SQLF_VALUE+" = "+sqlQuote(GetPCPublicCDKey(oPC))+";") == 0) {
         return TRUE;
     }
     return FALSE;
}

void cosCreatePublicCDKeyId(object oPC) {
     sqlExecDirect("INSERT INTO "+COS_SQLT_CDKEY+" ("+COS_SQLF_VALUE+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetPCPublicCDKey(oPC))+", NOW());");
}

void cosLinkAccountToKey(object oPC) {
     if (!cosHasNewAccount(oPC) && !cosHasNewPublicCDKey(oPC)) {
         sqlExecDirect("INSERT IGNORE INTO "+COS_SQLT_CDKEY_TO_ACCOUNT+" ("+COS_SQLF_ID_ACCOUNT+","+COS_SQLF_ID_CDKEY+","+COS_SQLF_CREATION+") VALUES ("+IntToString(cosGetAccountId(oPC))+","+IntToString(cosGetPublicCDKeyId(oPC))+", NOW());");
     }
}

object cosGetPCWaypoint(object oPC) {
    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
    if (!GetIsObjectValid(oPCWP)) {
        oPCWP = CreateObject(OBJECT_TYPE_WAYPOINT, COS_WP_CHARDATA_RESREF, GetStartingLocation(), FALSE, COS_WP_CHARDATA_TAG);
        if (GetIsObjectValid(oPCWP)) {
            SetLocalObject(oPC, COS_WP_CHARDATA_VARNAME, oPCWP);
        }
    }
    return oPCWP;
}

void cosSaveLocalValue(object oPC, string sVarName, string sValue) {
    string sSQL = "INSERT INTO "+COS_SQLT_CHAR_DATA+" ("+COS_SQLF_ID_CHAR+","+COS_SQLF_NAME+","+COS_SQLF_VALUE+","+COS_SQLF_CREATION+","+COS_SQLF_LAST_UPDATE+")"+
                  " VALUES ("+IntToString(cosGetPCId(oPC))+","+sqlQuote(sVarName)+","+sqlQuote(sValue)+",NOW(),NOW()) "+
                  "ON DUPLICATE KEY UPDATE"+
                  " "+COS_SQLF_VALUE+"="+sqlQuote(sValue)+","+
                  " "+COS_SQLF_LAST_UPDATE+"=NOW();";
    sqlExecDirect(sSQL);
}

void cosSetLocalInt(object oPC, string sVarName, int iValue, int iPersistant = TRUE) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalInt(oPCWP, sVarName, iValue);
        if (iPersistant) {
            cosSaveLocalValue(oPC, sVarName, IntToString(iValue));
        }
    }
}

int cosGetLocalInt(object oPC, string sVarName, int iPersistant = TRUE) {
    int iRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        iRes = GetLocalInt(oPCWP, sVarName);
        if (iRes == 0 && iPersistant) {
            iRes = sqlEAFDSingleInt("SELECT "+COS_SQLF_VALUE+" FROM "+COS_SQLT_CHAR_DATA+" WHERE "+COS_SQLF_ID_CHAR+" = "+IntToString(cosGetPCId(oPC))+" AND "+COS_SQLF_NAME+" = "+sqlQuote(sVarName)+";");
            if (iRes != 0) {
                cosSetLocalInt(oPC, sVarName, iRes);
            }
        }
    }
    return iRes;
}

void cosSetLocalString(object oPC, string sVarName, string sString, int iPersistant = TRUE) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalString(oPCWP, sVarName, sString);
        if (iPersistant) {
            cosSaveLocalValue(oPC, sVarName, sString);
        }
    }
}

string cosGetLocalString(object oPC, string sVarName, int iPersistant = TRUE) {
    string sRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        sRes = GetLocalString(oPCWP, sVarName);
        if (sRes == "" && iPersistant) {
            sRes = sqlEAFDSingleString("SELECT "+COS_SQLF_VALUE+" FROM "+COS_SQLT_CHAR_DATA+" WHERE "+COS_SQLF_ID_CHAR+" = "+IntToString(cosGetPCId(oPC))+" AND "+COS_SQLF_NAME+" = "+sqlQuote(sVarName)+";");
            if (sRes != "") {
                cosSetLocalString(oPC, sVarName, sRes);
            }
        }
    }
    return sRes;
}

void cosSetLocalLocation(object oPC, string sVarName, location lLoc, int iPersistant = TRUE) {
    cosSetLocalString(oPC, sVarName, stdLocationToString(lLoc), iPersistant);
}

location cosGetLocalLocation(object oPC, string sVarName, int iPersistant = TRUE) {
    return stdStringToLocation(cosGetLocalString(oPC, sVarName, iPersistant));
}

int pv_is_in_starting_area(object oPC) {
	return GetArea(oPC) == GetAreaFromLocation(GetStartingLocation());
}

void pv_save_loc_loop(object oPC) {
	if (GetIsObjectValid(oPC) && GetIsPC(oPC)) {
		if (!pv_is_in_starting_area(oPC) && GetIsObjectValid(GetArea(oPC))) {
			cosSetLocalString(oPC, COS_PC_STARTLOC, stdLocationToString(GetLocation(oPC)));
		}
		float fDelay = GetRandomDelay(COS_SAVEPOS_DELAY_MIN, COS_SAVEPOS_DELAY_MAX);
		DelayCommand(fDelay, pv_save_loc_loop(oPC));
	}
}

void pv_begin_save_loc_loop(object oPC) {
    pv_save_loc_loop(oPC);
}

void pv_move_to_start_loc(object oPC) {
    string sLoc = cosGetLocalString(oPC, COS_PC_STARTLOC);
    if (sLoc == "") {
        sLoc = stdLocationToString(GetStartingLocation());
    }
    AssignCommand(oPC, ActionJumpToLocation(stdStringToLocation(sLoc)));
    pv_begin_save_loc_loop(oPC);
}

void pv_wait_for_start_loc(object oPC) {
    if (pv_is_in_starting_area(oPC)) {
        pv_move_to_start_loc(oPC);
    } else {
        DelayCommand(COS_STARTLOC_WAITING_DELAY, pv_wait_for_start_loc(oPC));
    }
}

void cosStartLocationManager(object oPC) {
    pv_wait_for_start_loc(oPC);
}

void cosUpdateLastConnexion(object oPC) {
    sqlExecDirect("UPDATE "+COS_SQLT_CHAR+" SET "+COS_SQLF_LAST_CNX+"=NOW();");
}

void cosGive(object oPC, string sTag, string sResRef) {
    object oObj = GetItemPossessedBy(oPC, sTag);
    if (oObj == OBJECT_INVALID) {
        CreateItemOnObject(sResRef, oPC);
    }
}

void cosGivePlayerTools(object oPC) {
    cosGive(oPC, COS_PLT_SELECT_TAG, COS_PLT_SELECT_RESREF);
}
