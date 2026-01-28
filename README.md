# DataLendo Analysis

## Contexte
DataLendo est une entreprise spécialisée dans la vente de produits électroniques (smartphones, laptops, TV, accessoires) via un site e-commerce et des boutiques physiques, principalement dans les pays francophones.

Ce projet vise à analyser les **ventes, les produits et les clients** de DataLendo sur une période donnée afin de fournir une **vision claire de la performance commerciale** et des recommandations stratégiques pour la direction.

---

## Objectifs et mission

L’objectif principal est de reproduire le travail d’un **Data Analyst junior** pour :  

1. Explorer et comprendre les données disponibles : clients, ventes, produits et paiements.
2. Nettoyer et préparer les données pour garantir des analyses fiables.
3. Calculer les **KPIs Retail** essentiels : chiffre d’affaires total, évolution mensuelle, meilleurs jours, méthodes de paiement.
4. Analyser les produits :  
   - Best Sellers (volume)  
   - Top Revenue (valeur)  
   - Panier moyen par produit  
   - Produits faibles ou en fin de cycle
5. Analyser les clients :  
   - CA par client  
   - Répartition par pays et ville  
   - Profil (âge moyen si disponible)  
   - Segmentation RFM simplifiée (Récence, Fréquence, Montant)
6. Transformer les résultats en **insights business et recommandations actionnables**.
7. Documenter et organiser le projet dans GitHub pour un livrable professionnel et reproductible.

---

## Structure des fichiers

Le projet est organisé de manière **professionnelle et reproductible** :


> Notes :  
> - Les analyses sont réalisées **100% en SQL avec PostgreSQL** et VS Code.  
> - Les visualisations ne sont pas incluses car l’objectif est de rester **100% SQL**, mais elles peuvent être générées ultérieurement à partir des résultats exportés.  

---

## Instructions pour reproduire l’analyse

1. **Préparer l’environnement :**  
   - Installer PostgreSQL et VS Code.  
   - Créer une base de données :  

   ```sql
   CREATE DATABASE datalendo_db;


COPY clients FROM '/path/clients.csv' DELIMITER ',' CSV HEADER;
COPY ventes FROM '/path/ventes.csv' DELIMITER ',' CSV HEADER;
COPY produits FROM '/path/produits.csv' DELIMITER ',' CSV HEADER;
COPY paiements FROM '/path/paiements.csv' DELIMITER ',' CSV HEADER;
