/*  requete pour récuperer les noms des navires qui effectuent des voyages avec des etapes transitoires, sans doublons*/
/* la requete porte sur trois tables */

select distinct 
    navire.name 
from 
    navire,voyage,etape_transitoire 
where 
    navire.id_navire=voyage.id_navire 
    and 
    voyage.id_voyage=etape_transitoire.id_voyage ;

