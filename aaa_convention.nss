/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\

                                         CONVENTION FF2

    Ce script ne sert pas à proprement dit au fonctionnement du module. C'est un mode d'emploi qui
regroupe ses conventions de développement. Il contient tout ce qu'il faut faire pour conserver
une cohérence de scripting et de mapping, les nomenclatures et la liste des systèmes actifs.

    Il permet une évolutivité permanente et simple en définissant les façons de procéder à des
éventuelles modifications des systèmes en présence.
    Merci de suivre ces indications afin de conserver un module propre et réutilisable et n'oubliez
pas que vous ne serez pas le seul à coder sur FF2 et que les autres ont besoin de pouvoir s'y
retrouver simplement et rapidement.

    NOMENCLATURES

        o Scripts
        ---------

    Les scripts sont le moteur du module, ils en permettent le fonctionnement et sont, par
conséquent soumis à une nomenclature draconienne à laquelle il faut se plier pour pouvoir
s'y retrouver à l'avenir.

    Le nom des scripts obéit au pattern suivant (16 caractères maximum) :

                AAA_BB_CCCCCCCCC

                    AAA       : Prefixe du script (voir liste des préfixes). 
                    BB        : Type du script (voir liste des types de scripts).
                    CCCCCCCCC : Description (voir convention de description).
                    
      - Préfixes de scripts
      ---------------------
      
    Les préfixes changent en fonction de l'utilisation du script dans le module.
    
    1. Cas d'une utilisation générale (c'est à dire que le script doit forcément être utilisé dans
    les évènements du module et avoir une portée globale). Dans ce cas le préfixe est égal aux trois
    lettres définissant son système. Si le script appartient au coeur du système il sera affublé du
    préfixe cos.
    
    2. Cas d'une utilisation spécifique à une aire (c'est à dire que le script doit nécessairement
    être contenu dans un des objets de l'aire).    

      - Types de scripts
      ------------------

    EV : Correspond à tous les scripts qui sont appelés par les évènements ces scripts sont compilés
         en NCS.
    IN : Correspond aux scripts qui sont inclus dans d'autres, ils servent en général de bibliothèques.

      - Convention de description
      ---------------------------

    Les descriptions doivent être aussi claires que possible avec aussi peu de lettres que possible.

    En général, le script principal d'un système doit être décrit avec le mot "basis". C'est ce script
qui sera inclu dans le script de type EV correspondant. Exemple, quand on crée un système de gestion
des items (celui qui existe a pour acronyme ITM), on crée un script qui s'appelle "itm_in_basis" et
qui inclura tous les autres scripts dont il dépend. Finalement pour utiliser le système ITM dans un
autre script, on aura juste à inclure "itm_in_basis".

    En ce concerne le type EV la description est soumise à une convention précise.

                AAAAAAAAA

                    AAAAAAAAA : Type d'évènement associé au script.

                Liste des types d'évènements :

                    Triés par acronymes                 Triés par évènements
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

                    AAA : Numéro d'identification de l'aire (valeur numérique absolue et positive).

        o Items
        -------

    A developper.

        o Transitions
        -------------

    Les transitions peuvent être de plusieurs type.

            - Type standard
            ---------------

    Le type standard correspond à une transition "Transition -> Waypoint".

    La transition doit respecter le pattern suivant :

                TR_AAA_TO_BBB

    Le Waypoint doit respecter le pattern suivant :

                WP_BBB_FROM_AAA

                    AAA : Numéro de la map d'origine (celle contenant la Transition).
                    BBB : ID de la map de destination (celle contenant le Waypoint).

\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
