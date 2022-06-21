(define (domain mono)
    (:requirements :strips :typing)
    (:types
        movible localizacion - object
        mono caja - movible
    )
    (:predicates
        ;“El objeto x de tipo movible
        ;está en la localización y”
        (en ?obj - movible ?x - localizacion)
        
        ;“El mono x tiene el plátano”
        (tienePlatano ?m - mono)

        ;“El mono x está sobre la caja y”
        (sobre ?m - mono ?c - caja)

        ;“El plátano está en la localización x”
        (platanoEn ?x - localizacion)
    )

    (:action cogerPlatanos
        :parameters (?m - mono ?c - caja)
        :precondition (and
            (sobre ?m ?c)
        )
        :effect (and
            (tienePlatano ?m)
        )
    )
    
    (:action irA
        :parameters (?m - mono ?x ?y - localizacion)

        :precondition
        (and 
            (en ?m ?x)
        )

        ;Lista de predicados a añadir al estado previo.
        ;Lista de predicados a borrar al estado previo (se borran con
        ;not)

        :effect
        (and 
            (en ?m ?y)
            (not (en ?m ?x))
        )
    )
    

)