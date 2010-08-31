/*********************************************************************/
/** Nom :              cmdaf_main
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script principal d'ex cution des commandes.
/*********************************************************************/

                // #include "usuaf_constants"
            // #include "usuaf_strtokman"
            // #include "cmdaf_constants"
        // #include "cmdaf_utils"

            // #include "usuaf_constants"
        // #include "usuaf_movings"
    // #include "cmdaf_cmmoving"
#include "cmdaf_commands"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmdaf_main"
// Fonction qui ex cute une commande et renvoie le résultat sous forme de chaîne.
//   > string sCommand - Commande à tra ter.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdExecute(string sCommand, object oPC);

// DEF IN "cmdaf_main"
// Renvoie un speech int grant le résultat d'une commande.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > string sResult - résultat   int grer.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdFetch(struct cmd_data_str strCmdData, string sResult);

// DEF IN "cmdaf_main"
// Fonction qui ex cute une commande et la remplace par son résultat dans le speech d'origine.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmdExecute(string sCommand, object oPC) {
    string sCommandName;

    // On teste si le système est actif.
    if (CMD_ENABLED == FALSE) {
        return CMD_EMPTY_RESULT;
    }
    // On récupère le nom de la commande.
    sCommandName = cmdGetCommandName(sCommand);

    // Et on cherche la fonction correspondante.
    if (sCommandName == CMD_C_SAVE_LOC) {

        return cmdSaveLocCommand(sCommand, oPC);

    } else if (sCommandName == CMD_C_MOVE_TO) {

        return cmdMoveToCommand(sCommand, oPC);

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
    // Si la commande n'est pas vide, on l'ex cute et on remplace directement le résultat.
    if (cmdIsCommandValid(strCmdData)) {
        return cmdFetch(strCmdData, cmdExecute(strCmdData.sCommand, oPC));
    }
    // Et on renvoie le texte d'origine modifi .
    return CMD_EMPTY_RESULT;
}
