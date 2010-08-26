/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\

                                         CONVENTION FF2

    Ce script ne sert pas � proprement dit au fonctionnement du module. C'est un mode d'emploi qui
regroupe ses conventions de d�veloppement. Il contient tout ce qu'il faut faire pour conserver
une coh�rence de scripting et de mapping, les nomenclatures et la liste des syst�mes actifs.

    Il permet une �volutivit� permanente et simple en d�finissant les fa�ons de proc�der � des
�ventuelles modifications des syst�mes en pr�sence.
    Merci de suivre ces indications afin de conserver un module propre et r�utilisable et n'oubliez
pas que vous ne serez pas le seul � coder sur FF2 et que les autres ont besoin de pouvoir s'y
retrouver simplement et rapidement.

    NOMENCLATURES

        o Scripts
        ---------

    Les scripts sont le moteur du module, ils en permettent le fonctionnement et sont, par
cons�quent soumis � une nomenclature draconienne � laquelle il faut se plier pour pouvoir
s'y retrouver � l'avenir.

    Le nom des scripts ob�it au pattern suivant (16 caract�res maximum) :

                AAA_BB_CCCCCCCCC

                    AAA       : Prefixe du script (voir liste des pr�fixes). 
                    BB        : Type du script (voir liste des types de scripts).
                    CCCCCCCCC : Description (voir convention de description).
                    
      - Pr�fixes de scripts
      ---------------------
      
    Les pr�fixes changent en fonction de l'utilisation du script dans le module.
    
    1. Cas d'une utilisation g�n�rale (c'est � dire que le script doit forc�ment �tre utilis� dans
    les �v�nements du module et avoir une port�e globale). Dans ce cas le pr�fixe est �gal aux trois
    lettres d�finissant son syst�me. Si le script appartient au coeur du syst�me il sera affubl� du
    pr�fixe cos.
    
    2. Cas d'une utilisation sp�cifique � une aire (c'est � dire que le script doit n�cessairement
    �tre contenu dans un des objets de l'aire).    

      - Types de scripts
      ------------------

    EV : Correspond � tous les scripts qui sont appel�s par les �v�nements ces scripts sont compil�s
         en NCS.
    IN : Correspond aux scripts qui sont inclus dans d'autres, ils servent en g�n�ral de biblioth�ques.

      - Convention de description
      ---------------------------

    Les descriptions doivent �tre aussi claires que possible avec aussi peu de lettres que possible.

    En g�n�ral, le script principal d'un syst�me doit �tre d�crit avec le mot "basis". C'est ce script
qui sera inclu dans le script de type EV correspondant. Exemple, quand on cr�e un syst�me de gestion
des items (celui qui existe a pour acronyme ITM), on cr�e un script qui s'appelle "itm_in_basis" et
qui inclura tous les autres scripts dont il d�pend. Finalement pour utiliser le syst�me ITM dans un
autre script, on aura juste � inclure "itm_in_basis".

    En ce concerne le type EV la description est soumise � une convention pr�cise.

                AAAAAAAAA

                    AAAAAAAAA : Type d'�v�nement associ� au script.

                Liste des types d'�v�nements :

                    Tri�s par acronymes                 Tri�s par �v�nements
                    ----------------------------------------------------------------------
                    acquiitem  = OnAcquireItem          OnAcquireItem          = acquiitem
                    activitem  = OnActivateItem         OnActivateItem         = activitem
                    areatrclk  = OnAreaTransitionClick  OnAreaTransitionClick  = areatrclk
                    cli_enter  = OnClientEnter          OnBlocked              = onblocked
                    cli_leave  = OnClientLeave          OnClick                = on_click
                    combrdend  = OnCombatRoundEnd       OnClientEnter          = cli_enter
                    cutscnabr  = OnCutsceneAbort        OnClientLeave          = cli_leave
                    heartbeat  = OnHeartbeat            OnClose                = on_close
                    onblocked  = OnBlocked              OnCombatRoundEnd       = combrdend
                    on_click   = OnClick                OnConversation         = onconvers
                    on_close   = OnClose                OnCutsceneAbort        = cutscnabr
                    onclosstr  = OnStoreClosed          OnDamaged              = ondamaged
                    onconvers  = OnConversation         OnDeath                = ondeath
                    ondamaged  = OnDamaged              OnDisarm               = ondisarm
                    ondeath    = OnDeath                OnDisturbed            = ondisturb
                    ondisarm   = OnDisarm               OnEnter                = on_enter
                    ondisturb  = OnDisturbed            OnExhausted            = onexhaust
                    on_enter   = OnEnter                OnExit                 = on_exit
                    onexhaust  = OnExhausted            OnFailToOpen           = onfailopn
                    on_exit    = OnExit                 OnHeartbeat            = heartbeat
                    onfailopn  = OnFailToOpen           OnLock                 = on_lock
                    on_lock    = OnLock                 OnModuleLoad           = onmodload
                    onmodload  = OnModuleLoad           OnOpen                 = on_open
                    on_open    = OnOpen                 OnOpenStore            = onopenstr
                    onopenstr  = OnOpenStore            OnPerception           = onpercept
                    onpercept  = OnPerception           OnPhysicalAttacked     = phyattack
                    onplchat   = OnPlayerChat           OnPlayerChat           = onplchat
                    onpldeath  = OnPlayerDeath          OnPlayerDeath          = onpldeath
                    onpldying  = OnPlayerDying          OnPlayerDying          = onpldying
                    onpleqitm  = OnPlayerEquipItem      OnPlayerEquipItem      = onpleqitm
                    onpllvlup  = OnPlayerLevelUp        OnPlayerLevelUp        = onpllvlup
                    onplrespw  = OnPlayerRespawn        OnPlayerRespawn        = onplrespw
                    onplrest   = OnPlayerRest           OnPlayerRest           = onplrest
                    onplunequ  = OnPlayerUnEquipItem    OnPlayerUnEquipItem    = onplunequ
                    on_rested  = OnRested               OnRested               = on_rested
                    onspawn    = OnSpawn                OnSpawn                = onspawn
                    on_unlock  = OnUnlock               OnSpellCastAt          = spellcast
                    on_used    = OnUsed                 OnStoreClosed          = onclosstr
                    onuserdef  = OnUserDefined          OnTrapTriggered        = traptrigg
                    phyattack  = OnPhysicalAttacked     OnUnAcquireItem        = unacqitem
                    spellcast  = OnSpellCastAt          OnUnlock               = on_unlock
                    traptrigg  = OnTrapTriggered        OnUsed                 = on_used
                    unacqitem  = OnUnAcquireItem        OnUserDefined          = onuserdef

        o Areas
        -------

    Le blueprint des aires suit le pattern suivant :

                areaAAA

                    AAA : Num�ro d'identification de l'aire (valeur num�rique absolue et positive).

        o Items
        -------

    A developper.

        o Transitions
        -------------

    Les transitions peuvent �tre de plusieurs type.

            - Type standard
            ---------------

    Le type standard correspond � une transition "Transition -> Waypoint".

    La transition doit respecter le pattern suivant :

                TR_AAA_TO_BBB

    Le Waypoint doit respecter le pattern suivant :

                WP_BBB_FROM_AAA

                    AAA : Num�ro de la map d'origine (celle contenant la Transition).
                    BBB : ID de la map de destination (celle contenant le Waypoint).

\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
