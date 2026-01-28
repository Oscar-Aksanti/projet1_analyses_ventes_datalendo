CREATE DATABASE datalendo_db;


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



