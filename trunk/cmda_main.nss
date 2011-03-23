/*********************************************************************/
/** Nom :              cmda_main
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script principal d'ex cution des commandes.
/*********************************************************************/

/*DEBUG*/ #include "dbga_main"

#include "cmda_c_mov" // Système MOV
#include "cmda_c_afk" // Système AFK

/***************************** PROTOTYPES ****************************/

// DEF IN "cmda_main"
// Fonction qui exécute une commande et renvoie le résultat sous forme de chaîne.
//   > string sCommand - Commande à traîter.
//   > object oPC - Personnage qui a lancé la requête.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdExecute(string sCommand, object oPC);

// DEF IN "cmda_main"
// Renvoie un speech int grant le résultat d'une commande.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > string sResult - résultat à intégrer.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdFetch(struct cmd_data_str strCmdData, string sResult);

// DEF IN "cmda_main"
// Fonction qui exécute une commande et la remplace par son résultat dans le speech d'origine.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > object oPC - Personnage qui a lancé la requête.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmdExecute(string sCommand, object oPC) {
/*DEBUG*/ dbgChangeSource("cmdExecute");
    string sCommandName;

    // On teste si le système est actif.
    if (CMD_ENABLED == FALSE) {
        return CMD_EMPTY_RESULT;
    }
    // On récupère le nom de la commande.
    sCommandName = cmdGetCommandName(sCommand);

    // Et on cherche la fonction correspondante.
    // ==== Système MOV ====
    if (sCommandName == CMD_C_SAVE_LOC) {
        return cmdSaveLocCommand(sCommand, oPC);
    } else if (sCommandName == CMD_C_MOVE_TO) {
        return cmdMoveToCommand(sCommand, oPC);
    }
    // ==== Système AFK ====
    else if (sCommandName == CMD_C_TOGGLE_AFK) {
/*DEBUG*/ dbgWrite("CMD_C_TOGGLE_AFK command detected.");
        return cmdToggleAFKState(sCommand, oPC);
    }

    // Enfin, on renvoie un résultat vide si aucune fonction n'a été trouvé pour la commande.
    return CMD_EMPTY_RESULT;
}

string cmdFetch(struct cmd_data_str strCmdData, string sResult) {
    if (cmdIsCommandValid(strCmdData)) {
        // On extrait la partie gauche, avant la commande.
        string sLeftPart = usuGetStringBeforeToken(strCmdData.sSpeech, strCmdData.iOpeningTokPos);
        // On extrait la partie droite, après la commande.
        string sRightPart = usuGetStringAfterToken(strCmdData.sSpeech, CMD_CLOSING_TOKEN_LENGTH, strCmdData.iClosingTokPos);
        // On remplace la commande par son résultat.
        return sLeftPart+sResult+sRightPart;
    } else {
        return strCmdData.sSpeech;
    }
}

string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC) {
    // Si la commande n'est pas vide, on l'exécute et on remplace directement le résultat.
    if (cmdIsCommandValid(strCmdData)) {
        return cmdFetch(strCmdData, cmdExecute(strCmdData.sCommand, oPC));
    }
    // Et on renvoie le texte d'origine modifié.
    return CMD_EMPTY_RESULT;
}
