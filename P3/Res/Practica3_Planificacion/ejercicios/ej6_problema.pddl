(define (problem p3prob)
    (:domain p3dom)
    (:objects
        vce1 vce2 vce3 marine1 marine2 segador - unidad
        centro barracon extractor bahia deposito - edificio
        segadorImpulsor - investigacion
        c1_1 c1_2 c1_3 c1_4 c1_5 c2_1 c2_2 c2_3 c2_4 c2_5 c3_1 c3_2 c3_3 c3_4 c3_5 c4_1 c4_2 c4_3 c4_4 c4_5 c5_1 c5_2 c5_3 c5_4 c5_5 - localizacion
    )
    (:init
        (= (limite Minerales) 100)
        (= (limite Gas) 100)
        (= (almacenado Minerales) 100)
        (= (almacenado Gas) 100)
        (esTipoUnidad vce1 VCE)
        (esTipoUnidad vce2 VCE)
        (esTipoUnidad vce3 VCE)
        (esTipoUnidad marine1 Marines)
        (esTipoUnidad marine2 Marines)
        (esTipoUnidad segador Segadores)
        (esTipoEdificio centro CentroDeMando)
        (esTipoEdificio barracon Barracones)
        (esTipoEdificio extractor Extractor)
        (esTipoEdificio bahia BahiaDeInvestigacion)
        (esTipoEdificio deposito Deposito)
        (= (incrementaLimite Deposito) 100)
        (necesita CentroDeMando Minerales)
        (necesita CentroDeMando Gas)
        (= (coste Minerales CentroDeMando) 150)
        (= (coste Gas CentroDeMando) 50)
        (necesita Barracones Minerales)
        (= (coste Minerales Barracones) 150)
        (= (coste Gas Barracones) 0)
        (necesita Extractor Minerales)
        (= (coste Minerales Extractor) 75)
        (= (coste Gas Extractor) 0)
        (necesita BahiaDeInvestigacion Minerales)
        (= (coste Minerales BahiaDeInvestigacion) 125)
        (= (coste Gas BahiaDeInvestigacion) 0)
        (necesita Deposito Minerales)
        (necesita Deposito Gas)
        (= (coste Minerales Deposito) 75)
        (= (coste Gas Deposito) 25)
        (necesita Marines Minerales)
        (= (coste Minerales Marines) 50)
        (= (coste Gas Marines) 0)
        (necesita Segadores Minerales)
        (necesita Segadores Gas)
        (= (coste Minerales Segadores) 50)
        (= (coste Gas Segadores) 25)
        (necesita VCE Minerales)
        (= (coste Minerales VCE) 50)
        (= (coste Gas VCE) 0)
        (necesitaInv segadorImpulsor Minerales)
        (necesitaInv segadorImpulsor Gas)
        (= (costeInv Minerales segadorImpulsor) 50)
        (= (costeInv Gas segadorImpulsor) 200)                
        (permite segadorImpulsor Segadores)
        (recluta CentroDeMando VCE)
        (recluta Barracones Marines)
        (recluta Barracones Segadores)
        (en centro c3_3)
        (en Minerales c1_1)
        (en Minerales c1_2)
        (en Minerales c1_3)
        (en Gas c5_1)
        (en Gas c5_2)
        (en vce1 c2_2)
        (camino c1_1 c2_1)
        (camino c1_1 c1_2)
        (camino c1_2 c2_2)
        (camino c1_2 c1_3)
        (camino c1_2 c1_1)
        (camino c1_3 c2_3)
        (camino c1_3 c1_4)
        (camino c1_3 c1_2)
        (camino c1_4 c2_4)
        (camino c1_4 c1_5)
        (camino c1_4 c1_3)
        (camino c1_5 c2_5)
        (camino c1_5 c1_4)
        (camino c2_1 c1_1)
        (camino c2_1 c3_1)
        (camino c2_1 c2_2)
        (camino c2_2 c1_2)
        (camino c2_2 c3_2)
        (camino c2_2 c2_3)
        (camino c2_2 c2_1)
        (camino c2_3 c1_3)
        (camino c2_3 c3_3)
        (camino c2_3 c2_4)
        (camino c2_3 c2_2)
        (camino c2_4 c1_4)
        (camino c2_4 c3_4)
        (camino c2_4 c2_5)
        (camino c2_4 c2_3)
        (camino c2_5 c1_5)
        (camino c2_5 c3_5)
        (camino c2_5 c2_4)
        (camino c3_1 c2_1)
        (camino c3_1 c4_1)
        (camino c3_1 c3_2)
        (camino c3_2 c2_2)
        (camino c3_2 c4_2)
        (camino c3_2 c3_3)
        (camino c3_2 c3_1)
        (camino c3_3 c2_3)
        (camino c3_3 c4_3)
        (camino c3_3 c3_4)
        (camino c3_3 c3_2)
        (camino c3_4 c2_4)
        (camino c3_4 c4_4)
        (camino c3_4 c3_5)
        (camino c3_4 c3_3)
        (camino c3_5 c2_5)
        (camino c3_5 c4_5)
        (camino c3_5 c3_4)
        (camino c4_1 c3_1)
        (camino c4_1 c5_1)
        (camino c4_1 c4_2)
        (camino c4_2 c3_2)
        (camino c4_2 c5_2)
        (camino c4_2 c4_3)
        (camino c4_2 c4_1)
        (camino c4_3 c3_3)
        (camino c4_3 c5_3)
        (camino c4_3 c4_4)
        (camino c4_3 c4_2)
        (camino c4_4 c3_4)
        (camino c4_4 c5_4)
        (camino c4_4 c4_5)
        (camino c4_4 c4_3)
        (camino c4_5 c3_5)
        (camino c4_5 c5_5)
        (camino c4_5 c4_4)
        (camino c5_1 c4_1)
        (camino c5_1 c5_2)
        (camino c5_2 c4_2)
        (camino c5_2 c5_3)
        (camino c5_2 c5_1)
        (camino c5_3 c4_3)
        (camino c5_3 c5_4)
        (camino c5_3 c5_2)
        (camino c5_4 c4_4)
        (camino c5_4 c5_5)
        (camino c5_4 c5_3)
        (camino c5_5 c4_5)
        (camino c5_5 c5_4)

    )
    (:goal
        (and
            (en marine1 c4_1)
            (en marine2 c5_3)
            (en segador c5_3)
        )
    )
)