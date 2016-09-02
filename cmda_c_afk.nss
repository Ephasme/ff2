#include "cmda_utils"
#include "afka_main"

string cmd_afkToggleAFKState(string sCommand, object oPC);

string cmd_afkToggleAFKState(string sCommand, object oPC) {
    afkToggleState(oPC);
    return CMD_EMPTY_RESULT;
}
