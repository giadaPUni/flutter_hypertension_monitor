# 


# Flutter Hypertension Monitor 

(hypertension-monitor-app) 

## Architettura applicativa (baseline)


### **Obiettivo applicazione**

Applicazione Flutter per la gestione ed il monitoraggio di pazienti con possibile ipertensione. 

### Uso 

1. Uso personale 
    * una persona registra i propri valori 
    * gestisce il proprio profilo clinico
    * monitora l'andamento e le statistiche 

2. Uso multi-persona
    * un utente può gestire più persone monitorate
    * ogni paziente ha il proprio storico





### Funzionalità
* Registrazione utente (eseguita una sola volta, locale)
* Login: autenticazione utente
* Gestione dei pazienti (dati anagrafici)
* Gestione anamnesi (dati clinici)
* Registrazione delle misurazioni (valori di pressione sistolica, diastolica e frequenza cardiaca)
* Visualizzazioni statistiche e trend (grafici)
* Persistenza locale dei dati 
* Interfaccia grafica responsive 


## Framework e dipendenze

Framework: 
* Flutter 
* Dart 

State Management: 
* Riverpod 

Database locale: 
* Hive CE (community edition, mantenuto attivamente)

Grafici: 
* f1_chart 

Utility: 
* uuid 
* intl
* shared_preferences 

## Features / Screens / Pages 

### Auth

Autenticazione: registrazione - login 

Funzionalità:
* registrazione utente
* login 
* logout 
* gestione sessionec

login_page.dart, register_page.dart 

### Dashboard 

Funzionalità: 
* riepilogo generale 
* accesso rapido alle funzionalità - altre schermate
* informazioni principali 

Contenuti: 
* numero pazienti
* ultime misurazioni 
* indicatori principali 
* accessi rapidi

### Patients 

Dati anagrafici 

Funzionalità: 
* creazione paziente
* modifica 
* eliminazione
* visualizzazione dettaglio 

### Medical History 

Funzionalità: 
* gestione anamnesi 

Separato da Patient in quanto un paziente potrebbe inserire o meno una storia clinica che potrebbe essere anche variabile nel tempo. 

### Measurements 

Misurazioni

Funzionalità: 
* registrazione valori clinici 

Prima implementazione: pressione diastolica e sistolica, frequenza cardiaca (blood pressure)

### Statistics 

Analisi dei dati 

Contiene:
* grafici 
* trend 
* aggregazioni 
* medie 
* valori min/max 

### Settings 

Configurazione applicazione 

Esempi:
* preferenze
* tema 
* gestione dati locali 

## Entità principali 

* User: gestisce l'utente autenticato, chi accede all'app
* Patient: rappresenta il paziente monitorato(relazionato con MedicalHistory e Measurements)
* MedicalHistory: patologie, note, informazioni cliniche
* BloodPressureMeasurement: pressione sistolica e diastolica, frequenza cardiaca, data/ora, note


## Navigazione 

* AdaptiveScaffold 
* Drawer 
* NavigationRail 
* BottomNavigationBar

Per mobile: BottomNavigationBar + Drawer 

Per tablet: NavigationRail + Drawer 

Per Desktop/Web: NavigationRail esteso 

## Grafica responsive 

* mobile verticale/orizzontale 
* tablet 
* desktop 
* web 

Breakpoints, ResponsiveLayout, AdaptiveScaffold 

------



## Info 




---

Dashboard
* ultima misurazione;
* media degli ultimi 7 giorni;
* numero totale di misurazioni;
* indicatore visivo (verde, giallo, rosso).


Storico

Oltre alla lista:

* ricerca;
* filtro per data;
* modifica;
* eliminazione.
* Grafici

Non solo un grafico.

Tre grafici separati:

* pressione sistolica;
* pressione diastolica;
* frequenza cardiaca.

Con filtri:

* 7 giorni;
* 30 giorni;
* 6 mesi;
* 1 anno.


Profilo

Anziché solo l'anagrafica:

* peso;
* altezza;
* BMI calcolato automaticamente.

Il BMI richiede solo peso e altezza, ma rende l'app più completa.



## Persistenza in locale  

Hive CE: 





--- 

