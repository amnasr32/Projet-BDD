/* Req1 */

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



/* Req2*/
/* requete qui donne les noms des nations qui ont envoyé des navires différents dans des destinations différentes telle que le pays 
de la destination est en guerre*/

select 
    nationalite 
from 
    navire 
where 
    id_navire in
    (select distinct
        id_navire 
    from 
        voyage 
    where 
        destination 
    in 
        (select distinct 
            port.name 
        from 
            port 
        where nationnalite in 
            (select nation1 from relation_deplomatique where relation='en guerre')));
            
            
/*Req3*/
\! echo requete 1 qui calcule le gain de cargaison lors du voyage (achete-vendu)(res # car null)
/**
deux requetes qui renverraient le meme resultat si vos tables de ne contenaient pas de nulls, mais qui renvoient des resultats differents sinon
**/
--------req 1
SELECT regroupe , SUM(vol_achete - vol_vendu) as modification
from cargaison
group by regroupe;


/*Req4*/
/* une requete pour recuperer les noms des navires qui n'ont effectue aucun voyage court avec leurs nationnalité */

select
    navire.name, navire.nationalite
from
    voyage join navire  on voyage.id_navire = navire.id_navire
where
    not exists ( select * from voyage voy2 where voy2.id_navire=voyage.id_navire and voy2.type_voyage='court');
    
    
/*Req5*/
\! echo requete 2 qui calcule le gain de cargaison lors du voyage (achete-vendu) (res # car null)

/**
deux requetes qui renverraient le meme resultat si vos tables de ne contenaient pas de nulls, mais qui renvoient des resultats differents sinon
**/
--------req 2
SELECT regroupe , SUM(vol_achete) - SUM (vol_vendu) as modification
from cargaison
group by regroupe;


/*Req6*/
/*requete qui retourne les produits avec la date de conservation la plus longues*/
select distinct 
    produit.name,produit.categorie 
from 
    produit 
where 
    produit.categorie IN 
        (select id_cat from categorie_produit where conservation=(select max(conservation) from categorie_produit ));




/*Req7*/
/** le total des cargaisons ajoutés selon regroupe*/

WITH tab AS (select regroupe, sum(vol_achete) as CHARGE1
from cargaison
where vol_achete IS NOT NULL
group by regroupe
UNION ALL
SELECT regroupe, sum(vol_encours) as CHARGE1
from cargaison
where vol_vendu IS NOT NULL
group by regroupe
)
SELECT regroupe, SUM(CHARGE1) as charge
FROM tab
GROUP BY regroupe ;



/*Req8*/
/* requete qui retourne les id et noms des navires ayant une categorie en 3 et 5 et le nombre de leurs voyages */
/* group by et having */
select 
    navire.id_navire, navire.name,count(*) as nbr_voyages 
from 
    voyage join navire on voyage.id_navire=navire.id_navire 
    group by navire.id_navire, navire.name having navire.categorie between 3 and 5;


/*Req9*/
/*une requete impliquant le calcul de deux agr ́egats (par exemple, les moyennes d’un
ensemble de maximums)*/

/*La moyenne des distances parcourus par voyage intercontinental ayant le max de distance*/


SELECT AVG(distance)::real, classe
FROM voyage
GROUP BY classe , distance
HAVING distance = (select max(v1.distance) FROM voyage v1 where v1.classe='Intercontinental')  ;





/*Req10*/
/* requete qui retourne le nombre de passagers descendu à marseille pendant toutes les étapes tansitoire*/

select
    SUM(passagers.nb_depose) 
from 
    passagers join etape_transitoire on passagers.id_pass=etape_transitoire.passagers 
where etape_transitoire.name_port='Marseille';

