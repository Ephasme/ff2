/*********************************************************************/
/** Nom :              usu_hashset
/** Date de création : 18/12/2003
/** Version :          1.0.0
/** Créateur :         Ingmar Stieger
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Ingmar Stieger) :
/**      Ensemble de fonction permettant de gérer un Hashset.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "usu_constants"

/***************************** PROTOTYPES ****************************/

/* TODO: Traduire les descriptions de prototypes. */

// DEF IN "usu_hashset"
// create a new hash on oObject with name sHashSetName.
int usuHashCreate(string sHashSetName, int iSize = 500);

// DEF IN "usu_hashset"
// Clear and delete sHashSetName on oObject
void usuHashDestroy(string sHashSetName);

// DEF IN "usu_hashset"
// return true if hashset sHashSet is valid
int usuHashValid(string sHashSetName);

// DEF IN "usu_hashset"
// return true if hashset sHashSet contains key sKey
int usuHashKeyExists(string sHashSetName, string sKey);

// DEF IN "usu_hashset"
// Set key sKey of sHashset to string sValue
int usuHashSetLocalString(string sHashSetName, string sKey, string sValue);

// DEF IN "usu_hashset"
// Retrieve string value of sKey in sHashset
string usuHashGetLocalString(string sHashSetName, string sKey);

// DEF IN "usu_hashset"
// Set key sKey of sHashset to integer iValue
int usuHashSetLocalInt(string sHashSetName, string sKey, int iValue);

// DEF IN "usu_hashset"
// Retrieve integer value of sKey in sHashset
int usuHashGetLocalInt(string sHashSetName, string sKey);

// DEF IN "usu_hashset"
// Delete sKey in sHashset
int usuHashDeleteVariable(string sHashSetName, string sKey);

// DEF IN "usu_hashset"
// Return the n-th key in sHashset
// note: this returns the KEY, not the value of the key;
string usuHashGetNthKey(string sHashSetName, int i);

// DEF IN "usu_hashset"
// Return the first key in sHashset
// note: this returns the KEY, not the value of the key;
string usuHashGetFirstKey(string sHashSetName);

// DEF IN "usu_hashset"
// Return the next key in sHashset
// note: this returns the KEY, not the value of the key;
string usuHashGetNextKey(string sHashSetName);

// DEF IN "usu_hashset"
// Return the current key in sHashset
// note: this returns the KEY, not the value of the key;
string usuHashGetCurrentKey(string sHashSetName);

// DEF IN "usu_hashset"
// Return the number of elements in sHashset
int usuHashGetSize(string sHashSetName);

// DEF IN "usu_hashset"
// Return TRUE if the current key is not the last one, FALSE otherwise
int usuHashHasNext(string sHashSetName);

/* TODO: Decrire la fonction usuHashGetWaypoint. */

// DEF IN "usu_hashset"
object usuHashGetWaypoint();

/************************** IMPLEMENTATIONS **************************/

int usuHashCreate(string sHashSetName, int iSize = 500)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!CREATE", sHashSetName + "!" + IntToString(iSize) + "!");
    return HASHSET_SUCCESS;
}

void usuHashDestroy(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!DESTROY", sHashSetName + "!!");
}

int usuHashValid(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!VALID", sHashSetName + "!!");
    return StringToInt(GetLocalString(oWP, "NWNX!HASHSET!VALID"));
}

int usuHashKeyExists(string sHashSetName, string sKey)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!EXISTS", sHashSetName + "!" + sKey + "!");
    return StringToInt(GetLocalString(oWP, "NWNX!HASHSET!EXISTS"));
}

int usuHashSetLocalString(string sHashSetName, string sKey, string sValue)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!INSERT", sHashSetName + "!" + sKey + "!" + sValue);
    return HASHSET_SUCCESS;
}

string usuHashGetLocalString(string sHashSetName, string sKey)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!LOOKUP", sHashSetName + "!" + sKey + "!"+
    "                                                                                   "+
    "                                                                                   ");
    return GetLocalString(oWP, "NWNX!HASHSET!LOOKUP");
}

int usuHashSetLocalInt(string sHashSetName, string sKey, int iValue)
{
    usuHashSetLocalString(sHashSetName, sKey, IntToString(iValue));
    return HASHSET_SUCCESS;
}

int usuHashGetLocalInt(string sHashSetName, string sKey)
{
    string sValue = usuHashGetLocalString(sHashSetName, sKey);
    if (sValue == "")
        return 0;
    else
        return StringToInt(sValue);
}

int usuHashDeleteVariable(string sHashSetName, string sKey)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!DELETE", sHashSetName + "!" + sKey + "!");
    return HASHSET_SUCCESS;
}

string usuHashGetNthKey(string sHashSetName, int i)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!GETNTHKEY", sHashSetName + "!" + IntToString(i) + "!                                                                                                                                          ");
    return GetLocalString(oWP, "NWNX!HASHSET!GETNTHKEY");
}

string usuHashGetFirstKey(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!GETFIRSTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oWP, "NWNX!HASHSET!GETFIRSTKEY");
}

string usuHashGetNextKey(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!GETNEXTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oWP, "NWNX!HASHSET!GETNEXTKEY");
}

string usuHashGetCurrentKey(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!GETCURRENTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oWP, "NWNX!HASHSET!GETCURRENTKEY");
}

int usuHashGetSize(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!GETSIZE", sHashSetName + "!!           ");
    return StringToInt(GetLocalString(oWP, "NWNX!HASHSET!GETSIZE"));
}

int usuHashHasNext(string sHashSetName)
{
    object oWP = usuHashGetWaypoint();
    SetLocalString(oWP, "NWNX!HASHSET!HASNEXT", sHashSetName + "!!           ");
    return StringToInt(GetLocalString(oWP, "NWNX!HASHSET!HASNEXT"));
}

object usuHashGetWaypoint() {
    // On tente de récupérer le Waypoint (s'il existe, l'objet sera valide.)
    object oWP = GetObjectByTag(COS_WP_GVHASH_TAG);
    if (!GetIsObjectValid(oWP)) {
        // Sinon on le crée.
        oWP = CreateObject(OBJECT_TYPE_WAYPOINT,
                           COS_WP_GVHASH_RESREF,
                           GetStartingLocation(),
                           FALSE,
                           COS_WP_GVHASH_TAG);
    }
    // Dans tous les cas, on renvoie l'objet sus-créé.
    return oWP;
}

