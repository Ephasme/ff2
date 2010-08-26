/*********************************************************************/
/** Nom :              a017on_enterAAA
/** Date de cr�ation : 25/08/2010
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Script sp�cifique � la map 017. D�clench� quand le personnage
/**   d�clenche l'�v�nement OnEnter de l'objet dont le tag termine
/**   par AAA.
/*********************************************************************/

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC)) {
        SendMessageToPC(oPC, "Bienvenue sur FF2, allez parler � l'homme qui se trouve devant vous.");
    }
}
