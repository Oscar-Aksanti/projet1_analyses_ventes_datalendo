
-- PARTIE 1 : EXPLOIRATION DES DONNÉES

--Etape 1 : Compter les lignes

-- Compter le nombre de clients
SELECT COUNT(*) AS total_clients
FROM clients;

-- Compter le nombre de ventes
SELECT COUNT(*) AS total_ventes
FROM ventes;

-- Compter le nombre de produits
SELECT COUNT(*) AS total_produits
FROM produits;

-- Compter le nombre de paiements
SELECT COUNT(*) AS total_paiements
FROM paiements;


-- Etape 2 : Afficher un échantillon

-- Voir les 5 premiers clients
SELECT *
FROM clients
LIMIT 5;

-- Voir les 5 premières ventes
SELECT *
FROM ventes
LIMIT 5;

-- Voir les 5 premiers produits
SELECT *
FROM produits
LIMIT 5;

-- Voir les 5 premiers paiements
SELECT *
FROM paiements
LIMIT 5;


-- Etape 3 : Vérifier les colonnes importantes
-- Voir les pays des clients
SELECT DISTINCT pays
FROM clients;

-- Vérifier les méthodes de paiement
SELECT DISTINCT methode, statut
FROM paiements;

-- Vérifier les catégories de produits
SELECT DISTINCT categorie
FROM produits;


-- Etape 4 : Statistiques simples
-- Montant total des ventes
SELECT SUM(montant_total) AS chiffre_affaires_total
FROM ventes;

-- Moyenne du montant des ventes
SELECT AVG(montant_total) AS panier_moyen
FROM ventes;

-- Vente maximale
SELECT MAX(montant_total) AS vente_max
FROM ventes;

-- Vente minimale
SELECT MIN(montant_total) AS vente_min
FROM ventes;


-- PARTIE 2 : Nettoyage et préparation des données

-- Etape 1 : Filtrer les paiements réussis
-- Garder uniquement les ventes avec un paiement réussi
SELECT v.*
FROM ventes v
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success';

-- Étape 2 – Vérifier les doublons
-- Vérifier les doublons dans les ventes
SELECT id_vente, COUNT(*) AS nb_occurrences
FROM ventes
GROUP BY id_vente
HAVING COUNT(*) > 1;


-- Etape 3 : Vérifier les valeurs nulles ou manquantes
-- Vérifier les clients sans pays
SELECT *
FROM clients
WHERE pays IS NULL;

-- Vérifier les ventes sans montant
SELECT *
FROM ventes
WHERE montant_total IS NULL;


-- Etape 4 – Conversion des dates
-- Vérifier les dates de vente
SELECT date_vente
FROM ventes
LIMIT 5;

-- Vérifier les dates d'inscription des clients
SELECT date_inscription
FROM clients
LIMIT 5;


-- Etape 5 – Préparer les colonnes importantes pour l’analyse
-- Total ventes par pays
SELECT c.pays, COUNT(v.id_vente) AS nb_ventes
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
GROUP BY c.pays
ORDER BY nb_ventes DESC;


-- PARTIE 3  : KPIs Retail : chiffre d’affaires et analyse des ventes

-- Etape 1 – Chiffre d’affaires total
-- Chiffre d'affaires total
SELECT SUM(montant_total) AS chiffre_affaires_total
FROM ventes v
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success';


-- Étape 2 – Évolution mensuelle des ventes
-- Chiffre d'affaires par mois
SELECT 
    DATE_TRUNC('month', date_vente) AS mois,
    SUM(montant_total) AS chiffre_affaires
FROM ventes v
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY mois
ORDER BY mois;

-- Étape 3 – Meilleur jour / mois
-- Chiffre d'affaires par jour de la semaine
SELECT 
    TO_CHAR(date_vente, 'Day') AS jour,
    SUM(montant_total) AS chiffre_affaires
FROM ventes v
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY jour
ORDER BY chiffre_affaires DESC;


-- Etape 4 – Analyse des méthodes de paiement
-- Méthodes de paiement et chiffre d'affaires
SELECT 
    p.methode,
    COUNT(v.id_vente) AS nb_ventes,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY p.methode
ORDER BY chiffre_affaires DESC;


-- PARTIE 4 : Analyse Produits : Best Sellers, Top Revenue, panier moyen et produits faibles

-- Etape 1 – Best Sellers (volume)

-- Produits les plus vendus en volume
SELECT pr.nom_produit, SUM(v.quantite) AS total_vendu
FROM ventes v
JOIN produits pr ON v.id_produit = pr.id_produit
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY pr.nom_produit
ORDER BY total_vendu DESC
LIMIT 10;


-- Etape 2 : Top Revenue (valeur) 

-- Produits générant le plus de CA
SELECT pr.nom_produit, SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN produits pr ON v.id_produit = pr.id_produit
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY pr.nom_produit
ORDER BY chiffre_affaires DESC
LIMIT 10;


-- Étape 3 – Panier moyen par produit
-- Panier moyen par produit
SELECT pr.nom_produit, AVG(v.montant_total) AS panier_moyen
FROM ventes v
JOIN produits pr ON v.id_produit = pr.id_produit
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY pr.nom_produit
ORDER BY panier_moyen DESC
LIMIT 10;


-- Étape 4 – Identifier les produits faibles / fin de cycle
-- Produits avec faibles ventes
SELECT pr.nom_produit, SUM(v.quantité) AS total_vendu
FROM ventes v
JOIN produits pr ON v.id_produit = pr.id_produit
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY pr.nom_produit
ORDER BY total_vendu ASC
LIMIT 10;


-- PARTIE 5 : Analyse Clients : chiffre d’affaires, localisation, âge et RFM simplifié

-- Etape 1 – Chiffre d’affaires par client
-- Chiffre d'affaires par client
SELECT c.nom, SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.nom
ORDER BY chiffre_affaires DESC
LIMIT 10;

-- Étape 2 – Répartition par localisation

-- Nombre de ventes par pays
SELECT c.pays, COUNT(v.id_vente) AS nb_ventes, SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.pays
ORDER BY chiffre_affaires DESC;

-- Nombre de ventes par ville
SELECT c.ville, COUNT(v.id_vente) AS nb_ventes, SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.ville
ORDER BY chiffre_affaires DESC
LIMIT 10;

-- Étape 3 – Âge moyen des clients
-- Âge moyen des clients
SELECT AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_naissance))) AS age_moyen
FROM clients;


-- Étape 4 – RFM simplifié

 -- RFM = Récence, Fréquence, Montant.

-- Step 1 : R – Récence (clients les plus récents)
-- Clients les plus récents
SELECT c.nom, MAX(v.date_vente) AS derniere_achat
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.nom
ORDER BY derniere_achat DESC
LIMIT 10;



-- Step 2 : F – Fréquence (clients qui achètent le plus souvent)
-- Clients les plus fréquents
SELECT c.nom, COUNT(v.id_vente) AS nb_achats
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.nom
ORDER BY nb_achats DESC
LIMIT 10;



-- Step 3 : M – Montant (clients qui dépensent le plus)
-- Clients qui dépensent le plus
SELECT c.nom, SUM(v.montant_total) AS total_depense
FROM ventes v
JOIN clients c ON v.id_client = c.id_client
JOIN paiements p ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY c.nom
ORDER BY total_depense DESC
LIMIT 10;




