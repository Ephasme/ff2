/***************************** CONSTANTES ****************************/

const int SCM_ENABLED = TRUE;

// Token utilis‚ pour d‚marrer une s‚quence de commandes.
const string SCM_OPENING_TOKEN = "<!";
const int SCM_OPENING_TOKEN_LENGTH = 2;

const string SCM_CLOSING_TOKEN = "!>";
const int SCM_CLOSING_TOKEN_LENGTH = 2;

const string SCM_PARAMETER_TOKEN = " ";
const string SCM_DEFINITION_TOKEN = ":";

// Messages d'erreur.
const string SCM_ERROR = "";

// Speech vide.
const string SCM_EMPTY_SPEECH = "";
const string SCM_EMPTY_COMMAND_DATAS = "";
const string SCM_EMPTY_PARAMETER = "";
const string SCM_EMPTY_RESULT = "";

// Limite du nombre d'imbrication de commande.
const int MAXIMUM_COMMAND_INTERWEAVING_NUMBER = 5;

/***************************** CONSTANTES ****************************/

// Constantes de langue.
const string L_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE = "Vous avez sauvegard‚ cette position dans la variable";
const string L_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY = "Vous pourrez la r‚utiliser pour y revenir automatiquement.";

// Nom des commandes.
const string SCM_CM_MOVE_TO = "moveto";
const string SCM_CM_SAVE_LOC = "savepos";

// Param‡tres des commandes.
const string SCM_PAR_LOCAL_LOCATION_VARIABLE_NAME = "var";
const string SCM_PAR_WAYPOINT_TAG = "tag";
const string SCM_PAR_TO_LOCATION = "loc";
const string SCM_PAR_TO_WAYPOINT = "wp";
const string SCM_PAR_RUN = "run";
const string SCM_PAR_JUMP = "jump";

// Messages d'erreur.
const string ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT = "Impossible de se d‚placer à la fois vers un Waypoint et vers une Location.";
const string ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON = "Param‡tre de nom de variable non transmit.";
const string ERR_WAYPOINT_DESTINATION_INVALID = "Le Waypoint de destination est invalide.";
const string ERR_MOVING_TYPE_NOT_DEFINED = "Le type de déplacement (vers un Waypoint ou vers une Location) n'a pas ‚t‚ défini.";

