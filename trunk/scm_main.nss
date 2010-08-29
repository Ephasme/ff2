/*********************************************************************/
/** Nom :              scm_main
/** Date de cr ation : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script principal d'ex cution des commandes.
/*********************************************************************/

                // #include "usu_constants"
            // #include "usu_stringtokman"
            // #include "scm_constants"
        // #include "scm_utils"

            // #include "usu_constants"
        // #include "usu_movings"
    // #include "scm_cmmoving"
#include "scm_commands"

/***************************** PROTOTYPES ****************************/

// DEF IN "scm_main"
// Fonction qui ex cute une commande et renvoie le r sultat sous forme de chaîne.
//   > string sCommand - Commande   tra ter.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - R sultat de la commande (renvoie une chaîne vide si aucun r sultat n'est trouvé).
string scmExecuteCommand(string sCommand, object oPC);

// DEF IN "scm_main"
// Renvoie un speech int grant le r sultat d'une commande.
//   > struct scm_command_datas strScmCommandDatas - Structure de la commande.
//   > string sResult - R sultat   int grer.
//   o string - R sultat de la commande (renvoie une chaîne vide si aucun r sultat n'est trouvé).
string scmFetchCommand(struct scm_command_datas strScmCommandDatas, string sResult);

// DEF IN "scm_main"
// Fonction qui ex cute une commande et la remplace par son r sultat dans le speech d'origine.
//   > struct scm_command_datas strScmCommandDatas - Structure de la commande.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - R sultat de la commande (renvoie une chaîne vide si aucun r sultat n'est trouvé).
string scmExecAndFetchCommand(struct scm_command_datas strScmCommandDatas, object oPC);

/************************** IMPLEMENTATIONS **************************/

string scmExecuteCommand(string sCommand, object oPC) {
    string sCommandName;

    // On teste si le système est actif.
    if (SCM_ENABLED == FALSE) {
        return SCM_EMPTY_RESULT;
    }
    // On récupère le nom de la commande.
    sCommandName = scmGetCommandName(sCommand);

    // Et on cherche la fonction correspondante.
    if (sCommandName == SCM_CM_SAVE_LOC) {

        return scmSaveLocCommand(sCommand, oPC);

    } else if (sCommandName == SCM_CM_MOVE_TO) {

        return scmMoveToCommand(sCommand, oPC);

    }

    // Enfin, on renvoie un r sultat vide si aucune fonction n'a été trouvé pour la commande.
    return SCM_EMPTY_RESULT;
}

string scmFetchCommand(struct scm_command_datas strScmCommandDatas, string sResult) {
    if (scmIsValidCommand(strScmCommandDatas)) {
        // On extrait la partie gauche, avant la commande.
        string sLeftPart = usuGetStringBeforeToken(strScmCommandDatas.sSpeech, strScmCommandDatas.iOpeningTokPos);
        // On extrait la partie droite, après la commande.
        string sRightPart = usuGetStringAfterToken(strScmCommandDatas.sSpeech, SCM_CLOSING_TOKEN_LENGTH, strScmCommandDatas.iClosingTokPos);
        // On remplace la commande par son r sultat.
        return sLeftPart+sResult+sRightPart;
    } else {
        return strScmCommandDatas.sSpeech;
    }
}

string scmExecAndFetchCommand(struct scm_command_datas strScmCommandDatas, object oPC) {
    // Si la commande n'est pas vide, on l'ex cute et on remplace directement le r sultat.
    if (scmIsValidCommand(strScmCommandDatas)) {
        return scmFetchCommand(strScmCommandDatas, scmExecuteCommand(strScmCommandDatas.sCommand, oPC));
    }
    // Et on renvoie le texte d'origine modifi .
    return SCM_EMPTY_RESULT;
}
