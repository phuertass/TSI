(define (problem monosp1)
    ;; Nombre del dominio asociado al problema
    (:domain mono)
    
    ;; Nombre y tipo de los objetos del problema
    (:objects
        mono1 - mono
        caja1 - caja
        platano1 - platano
        loc1 loc2 loc3 - localizacion
    )

    ;; Estado inicial del problema
    (:init
        ( en mono1 loc1 )
        ( platanoEn loc2 )
        ( en caja1 loc3 )
    )

    ;; Estado objetivo del problema

    (:goal
        (and
            (tienePlatano mono1)
        )
    )
)
