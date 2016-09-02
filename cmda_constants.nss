const int CMD_ENABLED = TRUE;

const string CMD_OPENING_TOKEN = "<<";
const int CMD_OPENING_TOKEN_LENGTH = 2;

const string CMD_CLOSING_TOKEN = ">>";
const int CMD_CLOSING_TOKEN_LENGTH = 2;

const string CMD_PARAMETER_TOKEN = " ";
const string CMD_DEFINITION_TOKEN = "=";

const string CMD_ERROR = "";

const string CMD_EMPTY_SPEECH = "";
const string CMD_EMPTY_COMMAND_DATAS = "";
const string CMD_EMPTY_PARAMETER = "";
const string CMD_EMPTY_RESULT = "";

const int CMD_MAX_DEPTH = 5;

const string CMD_C_MOVE_TO = "moveto";
const string CMD_C_SAVE_LOC = "savepos";

const string CMD_PAR_LOCAL_LOCATION_VARIABLE_NAME = "var";
const string CMD_PAR_WAYPOINT_TAG = "tag";
const string CMD_PAR_TO_LOCATION = "loc";
const string CMD_PAR_TO_WAYPOINT = "wp";
const string CMD_PAR_RUN = "run";
const string CMD_PAR_JUMP = "jump";

const string ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT = "Impossible de se déplacer à la fois vers un Waypoint et vers une Location.";
const string ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON = "Paramètre de nom de variable non transmit.";
const string ERR_WAYPOINT_DESTINATION_INVALID = "Le Waypoint de destination est invalide.";
const string ERR_MOVING_TYPE_NOT_DEFINED = "Le type de déplacement (vers un Waypoint ou vers une Location) n'a pas été défini.";

const string CMD_M_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE = "Vous avez sauvegardé cette position dans la variable.";
const string CMD_M_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY = "Vous pourrez la réutiliser pour y revenir automatiquement.";

const string CMD_C_TOGGLE_AFK = "afk";

const string CMD_C_FLUSH_AUTH = "flush_auth";
const string CMD_M_YOU_FLUSHED_AUTHORIZATIONS = "Les autorisations ont été mise à jour.";