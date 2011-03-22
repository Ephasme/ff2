/*********************************************************************/
/** Nom :              move_used_sit2
/** Date de création : 07/10/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script pour s'asseoir sur un banc.
/*********************************************************************/

void main()
{
    // Déclarations
    object oPlayer = GetLastUsedBy();
    object oBench = OBJECT_SELF;
    object oPillow1 = GetLocalObject( OBJECT_SELF, "move_used_sit2_Pillow1" );
    object oPillow2 = GetLocalObject( OBJECT_SELF, "move_used_sit2_Pillow2" );

    // Si la place n'est pas occupé, la créer
    if( !GetIsObjectValid( oPillow1 ) )
    {
        // Créer les variables
        object oArea = GetArea( oBench );
        vector locBench = GetPosition( oBench );
        float fOrient = GetFacing( oBench );

        // Calcule la location des 2 places
        location locPillow1 = Location( oArea, locBench + AngleToVector( fOrient + 90.0f ) / 2.0f, fOrient );
        location locPillow2 = Location( oArea, locBench + AngleToVector( fOrient - 90.0f ) / 2.0f, fOrient );

        // Créer le 2eme joueur assis
        oPillow1 = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", locPillow1 );
        oPillow2 = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", locPillow2 );

        // Memorise les places
        SetLocalObject( OBJECT_SELF, "move_used_sit2_Pillow1", oPillow1 );
        SetLocalObject( OBJECT_SELF, "move_used_sit2_Pillow2", oPillow2 );
    }

    if( GetDistanceBetween( oPlayer, oPillow1 ) < GetDistanceBetween( oPlayer, oPillow2 ) )
    {
        if( !GetIsObjectValid( GetSittingCreature( oPillow1 ) ) )
        {
            AssignCommand( oPlayer, ActionSit( oPillow1 ) );
        }
        else
        {
            AssignCommand( oPlayer, ActionSit( oPillow2 ) );
        }
    }
    else
    {
        if( !GetIsObjectValid( GetSittingCreature( oPillow2 ) ) )
        {
            AssignCommand( oPlayer, ActionSit( oPillow2 ) );
        }
        else
        {
            AssignCommand( oPlayer, ActionSit( oPillow1 ) );
        }
    }
}
