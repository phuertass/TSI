(define (problem ej1)
    (:domain ej1)
  (:objects	l1_1 l1_2 l1_3 l1_4 l1_5 l2_1 l2_2 l2_3 l2_4 l2_5 l3_1 l3_2 l3_3 l3_4 l3_5 l4_1 l4_2 l4_3 l4_4 l4_5 l5_1 l5_2 l5_3 l5_4 l5_5 - localizacion
            cm1 b1 - edificio
            unidad1 unidad2 unidad3 - unidad
            m1 m2 m3 g1 g2 - recurso)

  (:init
    (en l1_1 m1)
    (en l3_2 m2)
    (en l5_1 m3)
    (en l1_4 g1)
    (en l3_3 g2)
    (en l2_2 cm1)
    (en l2_2 unidad1)
    (en l2_2 unidad2)
    (en l2_2 unidad3)
    (unidad-es unidad1 vce)
    (unidad-es unidad2 vce)
    (unidad-es unidad3 vce)
    (edificio-necesita mineral barracones)
    (edificio-necesita gas centro-mando)
    (recurso-es g1 gas)
    (recurso-es g2 gas)
    (recurso-es m1 mineral)
    (recurso-es m2 mineral)
    (recurso-es m3 mineral)
    (conectado l2_1 l1_1)
    (conectado l1_1 l1_2)
    (conectado l1_2 l1_1)
    (conectado l1_2 l2_2)
    (conectado l2_2 l1_2)
    (conectado l1_2 l1_3)
    (conectado l1_3 l1_2)
    (conectado l1_2 l1_1)
    (conectado l1_1 l1_2)
    (conectado l1_3 l2_3)
    (conectado l2_3 l1_3)
    (conectado l1_3 l1_4)
    (conectado l1_4 l1_3)
    (conectado l1_3 l1_2)
    (conectado l1_2 l1_3)
    (conectado l1_4 l2_4)
    (conectado l2_4 l1_4)
    (conectado l1_4 l1_5)
    (conectado l1_5 l1_4)
    (conectado l1_4 l1_3)
    (conectado l1_3 l1_4)
    (conectado l1_5 l2_5)
    (conectado l2_5 l1_5)
    (conectado l1_5 l1_4)
    (conectado l1_4 l1_5)
    (conectado l2_1 l1_1)
    (conectado l1_1 l2_1)
    (conectado l2_1 l3_1)
    (conectado l3_1 l2_1)
    (conectado l2_1 l2_2)
    (conectado l2_2 l2_1)
    (conectado l2_2 l1_2)
    (conectado l1_2 l2_2)
    (conectado l2_2 l3_2)
    (conectado l3_2 l2_2)
    (conectado l2_2 l2_3)
    (conectado l2_3 l2_2)
    (conectado l2_2 l2_1)
    (conectado l2_1 l2_2)
    (conectado l2_3 l1_3)
    (conectado l1_3 l2_3)
    (conectado l2_3 l3_3)
    (conectado l3_3 l2_3)
    (conectado l2_3 l2_4)
    (conectado l2_4 l2_3)
    (conectado l2_3 l2_2)
    (conectado l2_2 l2_3)
    (conectado l2_4 l1_4)
    (conectado l1_4 l2_4)
    (conectado l2_4 l3_4)
    (conectado l3_4 l2_4)
    (conectado l2_4 l2_5)
    (conectado l2_5 l2_4)
    (conectado l2_4 l2_3)
    (conectado l2_3 l2_4)
    (conectado l2_5 l1_5)
    (conectado l1_5 l2_5)
    (conectado l2_5 l3_5)
    (conectado l3_5 l2_5)
    (conectado l2_5 l2_4)
    (conectado l2_4 l2_5)
    (conectado l3_1 l2_1)
    (conectado l2_1 l3_1)
    (conectado l3_1 l4_1)
    (conectado l4_1 l3_1)
    (conectado l3_1 l3_2)
    (conectado l3_2 l3_1)
    (conectado l3_2 l2_2)
    (conectado l2_2 l3_2)
    (conectado l3_2 l4_2)
    (conectado l4_2 l3_2)
    (conectado l3_2 l3_3)
    (conectado l3_3 l3_2)
    (conectado l3_2 l3_1)
    (conectado l3_1 l3_2)
    (conectado l3_3 l2_3)
    (conectado l2_3 l3_3)
    (conectado l3_3 l4_3)
    (conectado l4_3 l3_3)
    (conectado l3_3 l3_4)
    (conectado l3_4 l3_3)
    (conectado l3_3 l3_2)
    (conectado l3_2 l3_3)
    (conectado l3_4 l2_4)
    (conectado l2_4 l3_4)
    (conectado l3_4 l4_4)
    (conectado l4_4 l3_4)
    (conectado l3_4 l3_5)
    (conectado l3_5 l3_4)
    (conectado l3_4 l3_3)
    (conectado l3_3 l3_4)
    (conectado l3_5 l2_5)
    (conectado l2_5 l3_5)
    (conectado l3_5 l4_5)
    (conectado l4_5 l3_5)
    (conectado l3_5 l3_4)
    (conectado l3_4 l3_5)
    (conectado l4_1 l3_1)
    (conectado l3_1 l4_1)
    (conectado l4_1 l5_1)
    (conectado l5_1 l4_1)
    (conectado l4_1 l4_2)
    (conectado l4_2 l4_1)
    (conectado l4_2 l3_2)
    (conectado l3_2 l4_2)
    (conectado l4_2 l5_2)
    (conectado l5_2 l4_2)
    (conectado l4_2 l4_3)
    (conectado l4_3 l4_2)
    (conectado l4_2 l4_1)
    (conectado l4_1 l4_2)
    (conectado l4_3 l3_3)
    (conectado l3_3 l4_3)
    (conectado l4_3 l5_3)
    (conectado l5_3 l4_3)
    (conectado l4_3 l4_4)
    (conectado l4_4 l4_3)
    (conectado l4_3 l4_2)
    (conectado l4_2 l4_3)
    (conectado l4_4 l3_4)
    (conectado l3_4 l4_4)
    (conectado l4_4 l5_4)
    (conectado l5_4 l4_4)
    (conectado l4_4 l4_5)
    (conectado l4_5 l4_4)
    (conectado l4_4 l4_3)
    (conectado l4_3 l4_4)
    (conectado l4_5 l3_5)
    (conectado l3_5 l4_5)
    (conectado l4_5 l5_5)
    (conectado l5_5 l4_5)
    (conectado l4_5 l4_4)
    (conectado l4_4 l4_5)
    (conectado l5_1 l4_1)
    (conectado l4_1 l5_1)
    (conectado l5_1 l5_2)
    (conectado l5_2 l5_1)
    (conectado l5_2 l4_2)
    (conectado l4_2 l5_2)
    (conectado l5_2 l5_3)
    (conectado l5_3 l5_2)
    (conectado l5_2 l5_1)
    (conectado l5_1 l5_2)
    (conectado l5_3 l4_3)
    (conectado l4_3 l5_3)
    (conectado l5_3 l5_4)
    (conectado l5_4 l5_3)
    (conectado l5_3 l5_2)
    (conectado l5_2 l5_3)
    (conectado l5_4 l4_4)
    (conectado l4_4 l5_4)
    (conectado l5_4 l5_5)
    (conectado l5_5 l5_4)
    (conectado l5_4 l5_3)
    (conectado l5_3 l5_4)
    (conectado l5_5 l4_5)
    (conectado l4_5 l5_5)
    (conectado l5_5 l5_4)
    (conectado l5_4 l5_5)
  )

  (:goal
  	(and (en l5_3 b1))
  )
)
