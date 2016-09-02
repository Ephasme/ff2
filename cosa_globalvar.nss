#include "cosa_constants"

object cosGetGlobalVarWaypoint();
void cosSetGlobalInt(string sGlobalVarName, int iValue);
void cosSetGlobalObject(string sGlobalVarName, object oObject);
int cosGetGlobalInt(string sGlobalVarName);
object cosGetGlobalObject(string sGlobalVarName);
void cosSaveOnEnter(object oEnteringObject);
object cosGetOnEnter();

object cosGetGlobalVarWaypoint() {
    object oGlobalVarWP;
    oGlobalVarWP = GetObjectByTag(COS_WP_GVSTOCK_TAG);
    if (!GetIsObjectValid(oGlobalVarWP)) {
        oGlobalVarWP = CreateObject(OBJECT_TYPE_WAYPOINT, COS_WP_GVSTOCK_RESREF, GetStartingLocation(), FALSE, COS_WP_GVSTOCK_TAG);
    }
    return oGlobalVarWP;
}

void cosSetGlobalInt(string sGlobalVarName, int iValue) {
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    if (GetIsObjectValid(oGlobalVarWP)) {
        SetLocalInt(oGlobalVarWP, sGlobalVarName, iValue);
    }
}

void cosSetGlobalObject(string sGlobalVarName, object oObject) {
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    if (GetIsObjectValid(oGlobalVarWP)) {
        SetLocalObject(oGlobalVarWP, sGlobalVarName, oObject);
    }
}

int cosGetGlobalInt(string sGlobalVarName) {
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    int result = -1;
    if (GetIsObjectValid(oGlobalVarWP)) {
        result = GetLocalInt(oGlobalVarWP, sGlobalVarName);
    }
    return result;
}

object cosGetGlobalObject(string sGlobalVarName) {
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    object result = OBJECT_INVALID;
    if (GetIsObjectValid(oGlobalVarWP)) {
        result = GetLocalObject(oGlobalVarWP, sGlobalVarName);
    }
    return result;
}

void cosSaveOnEnter(object oEnteringObject) {
    cosSetGlobalObject(COS_GV_ON_ENTER, oEnteringObject);
}

object cosGetOnEnter() {
    return cosGetGlobalObject(COS_GV_ON_ENTER);
}
