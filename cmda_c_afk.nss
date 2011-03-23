/*********************************************************************/
/** Nom :              cmda_c_afk
/** Date de cr�ation : 23/03/2011
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les commandes relatives � l'AFK.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_utils"
#include "afka_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmda_commands"
// Fonction qui active ou d�sactive le mode AFK d'un personnage.
//   > string sCommand - Commande � traiter.
//   > object oPC - Source de la requ�te.
//   o string - Cha�ne vide.
string cmdToggleAFKState(string sCommand, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmdToggleAFKState(string sCommand, object oPC) {
/*DEBUG*/ dbgChangeSource("cmdToggleAFKState");
/*DEBUG*/ dbgWrite("Changing AFK State.");
    afkToggleState(oPC);
/*DEBUG*/ dbgWrite("AFK State changed.");
    return CMD_EMPTY_RESULT;
}
