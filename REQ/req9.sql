/*une requete impliquant le calcul de deux agr ́egats (par exemple, les moyennes d’un
ensemble de maximums)*/

/*La moyenne des distances parcourus par voyage intercontinental ayant le max de distance*/


SELECT AVG(distance)::real, classe
FROM voyage
GROUP BY classe , distance
HAVING distance = (select max(v1.distance) FROM voyage v1 where v1.classe='Intercontinental')  ;




/***
  avg   |      classe      
--------+------------------
 115425 | Intercontinental
(1 row)


**/
