# Flutter Hypertension Monitor 

## Descrizione del Progetto 

Flutter Hypertension Monitor è un'applicazione mobile e web sviluppata con Flutter per la gestione ed il monitoraggio della pressione arteriosa, in particolare per soggetti a rischio di ipertensione. 

L'applicazione permette di 

* gestire gli account degli utenti e i relativi profili paziente, 
* registrare le misurazioni della pressione arteriosa e della frequenza cardiaca, 
* consultare lo storico delle misurazioni, 
* gestire l'anamnesi clinica, 
* visualizzare statistiche sull'andamento della pressione. 

Inoltre, supporta la visualizzazione dei dati tramite un grafico, permettendo di osservare l'andamento della pressione sistolica e diastolica nel tempo. 

L'interfaccia utente è stata progettata per adattarsi a diverse dimensioni dello schermo e ai diversi orientamenti dei dispositivi. 

--- 

## Esperienza Utente 

Una caratteristica fondamentale dell'applicazione è data dalla possibilità di poter scegliere la tipologia di Account che si vuole creare ed usare: 

* Account Paziente, il soggetto che crea l'account agisce come unico paziente (Utente = Paziente)
* Account Utente, il soggetto che crea l'account non intende usarla per scopi personali ed individuali, bensì di usarla per monitorare e gestire altri soggetti/pazienti (Utente != Paziente)

La diversa tipologia comporta un'interazione differente con l'applicazione. 


Le principali funzionalità dell'applicazione sono: 

### Login e Registrazione 

All'avvio l'utente può effettuare l'accesso inserendo username e password. Qualora non possieda ancora un account, può accedere alla schermata di registrazione e crerne uno con la tipologia che preferisce. 

Dopo aver eseguito il login, l'utente viene indirizzato alla schermata principale (Home). 

### Gestione dei Pazienti 

Gli utenti che possono gestire più pazienti (Account Utente) possono visualizzare l'elenco dei profili disponibili e selezionare il paziente da gestire. 

Per entrambe le tipologie di account, per ogni paziente è disponibile una scheda dedicata contenente le principali informazioni personali tra cui: 

- nome e cognome;
- data di nascita;
- sesso;
- altezza;
- peso;
- BMI.

Dalla scheda paziente è possibile modificare le informazioni del profilo oppure eliminarlo.

La creazione e la modifica del profilo utilizzano un form comune, che permette di inserire i dati che vengono richiesti. 

### Gestione dell'Anamnesi 

Sia dalla scheda paziente (tramite la pagina Pazienti) che dalla pagina Anamnesi, è possibile accedere e modificare le informazioni relative alla storia medica del paziente. 

### Inserimento delle Misurazioni 

Le misurazioni della pressione possono essere registrate direttamente dalla scheda del paziente oppure, nel caso dell' Account Paziente, anche dalla pagina Misurazioni.

L'utente può inserire i valori relativi alla pressione sistolica, alla pressione diastolica e alla frequenza cardiaca, insieme alla data ed all'ora della misurazione tramite l'interfaccia dedicata. 

Le misurazioni vengono visualizzate nello storico del paziente o nella pagina delle Misurazioni, ordinate dalla più recente alla più datata. 

