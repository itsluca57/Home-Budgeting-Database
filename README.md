

<!-- Start of picture text -->
(7 @y,@;5)\ UNIVERSITA<br>eileFikes DEGLI STUDI<br>Cromearxs/ DI PADOVA<br><!-- End of picture text -->

UNIVERSITA` DEGLI STUDI DI PADOVA Dipartimento di Matematica Corso di Laurea in Informatica Progetto di Basi di Dati 

**Home Budgeting: Base di dati di un sistema per la Gestione delle Finanze Personali** 

**Docente:** Prof. Massimiliano de Leoni 

**Studente:** Luca Cesco Bolla (Matr. 2138006) 

Anno Accademico 2025/2026 

# **Indice** 

|**1**|**Abstract**|**2**|
|---|---|---|
|**2**|**Analisi dei Requisiti**|**2**|
|**3**|**Progettazione Concettuale**|**4**|
||3.1<br>Vincoli non esprimibili nel Diagramma E-R . . . . . . . . .|. . . . . . . .<br>5|
|**4**|**Progettazione Logica**|**5**|
||4.1<br>Analisi delle Ridondanze . . . . . . . . . . . . . . . . . . .|. . . . . . . .<br>7|
||4.2<br>Eliminazione delle Generalizzazioni. . . . . . . . . . . . .|. . . . . . . .<br>8|
||4.3<br>Schema Relazionale . . . . . . . . . . . . . . . . . . . . .|. . . . . . . .<br>9|
|**5**|**Implementazione**|**10**|
||5.1<br>Definizione delle Query<br>. . . . . . . . . . . . . . . . . . .|. . . . . . . .<br>10|
||5.2<br>Definizione degli Indici . . . . . . . . . . . . . . . . . . . .|. . . . . . . .<br>13|
|**6**|**Applicazione Software**|**13**|



1 

## **1 Abstract** 

Negli ultimi anni, la crescente molteplicit`a di strumenti finanziari (conti correnti, carte di credito, investimenti) e la necessit`a di un risparmio consapevole rendono fondamentale l’adozione di strumenti digitali per il controllo della spesa. Il presente progetto si propone di progettare e realizzare una base di dati a supporto di un’applicazione di Home Budgeting, studiata per offrire agli utenti un tracciamento centralizzato, accurato e flessibile della propria situazione finanziaria. 

Il sistema `e concepito per gestire una molteplicit`a di utenti e supporta sia conti personali ad uso individuale, sia conti co-intestati tra pi`u utenti, per i conti co-intestati deve essere possibile specificare un livello di accesso necessario a garantire la sicurezza del conto. All’interno della base di dati vengono registrate le transazioni finanziarie: suddivise in entrate, uscite e trasferimenti interni tra conti distinti dello stesso utente, solitamente al costo di una commissione, gestendo anche eventuali transazioni ricorrenti. Ogni transazione `e associata a una categoria specifica, permettendo un’organizzazione e una classificazione dettagliata dei flussi finanziari. 

A completamento delle funzionalit`a operative, la piattaforma implementa uno strumento di pianificazione: ciascun utente pu`o impostare limiti di spesa (budget) per singola categoria su orizzonti temporali settimanali, mensili o personalizzati. Ad ogni budget attivo `e integrato un sistema di avviso basato su soglie configurabili, in grado di generare notifiche o e-mail per segnalare il rischio di sforamento del tetto di spesa. 

## **2 Analisi dei Requisiti** 

**Utente** . Rappresenta i soggetti registrati nel sistema che gestiscono i propri flussi finanziari. Per ciascun utente si devono memorizzare: 

- Codice univoco (ID) che distingue in modo univoco ogni utente. 

- Nome e Cognome dell’utente. 

- Indirizzo e-mail di contatto. 

**Conto** . Rappresenta le disponibilit`a liquide e i rapporti finanziari sui quali vengono registrati i movimenti. Per ogni conto si devono memorizzare: 

- Codice univoco (ID) che distingue ogni conto. 

- Nome del conto (es. Contanti, Conto Principale). 

- Saldo corrente presente sul conto. 

Per ogni associazione tra un utente e un conto (in particolare nei conti co-intestati), si deve memorizzare il relativo **livello di accesso** che pu`o essere Lettura, Modifica oppure Amministratore. 

Per i **Conti Corrente** bancari, oltre alle informazioni di base, si rende necessario memorizzare ulteriori dettagli relativi alla banca: 

2 

- Codice IBAN. 

- Nome della Banca di riferimento. 

**Transazione** . Rappresenta ogni singolo movimento finanziario registrato sui conti. Per ciascuna transazione si devono memorizzare: 

- Codice univoco (ID) della transazione. 

- Nome o descrizione sintetica del movimento. 

- Data e Ora di esecuzione. 

- Importo e Tipologia dell’operazione (Entrata, Uscita, Trasferimento). 

- Se la transazione `e ricorrente oppure no. 

Nel caso in cui la transazione rappresenti un **Trasferimento** di fondi tra conti, oltre alle informazioni di base, si specifica: 

- Conto di destinazione verso cui `e diretto il movimento. 

- Commissione pagata. 

Qualora la transazione fosse **Ricorrente** nel tempo, oltre ai dati generali della transazione, si registrano: 

- Frequenza di ripetizione del movimento. 

- Data di fine della ricorrenza. 

**Categoria** . Rappresenta la classificazione tematica utilizzata per catalogare le transazioni. Per ciascuna categoria si devono memorizzare: 

- Nome della categoria (es. Spesa, Stipendio, Trasporti). 

**Budget** . Rappresenta la pianificazione del tetto massimo di spesa impostato su una specifica categoria. Per ogni budget si devono memorizzare: 

- Importo target massimo di spesa. 

- Frequenza temporale (settimanale, mensile o personalizzata). 

- Data Fine del periodo del budget. 

**Avviso** . Rappresenta il meccanismo di notifica collegato al superamento della soglia di avviso impostata nel budget. Per ogni avviso si devono memorizzare: 

- Tipologia di invio della segnalazione (es. Notifica, Email). 

- Soglia percentuale o monetaria di allarme. 

3 

## **3 Progettazione Concettuale** 



<!-- Start of picture text -->
Nome Copnane promeyLieto Name Sado 10<br>9 0 ° ° 0<br>Email O UTENTE 1M 1m CONTO — |CONTO CORRENTE, © lean<br>Banca<br>p | vio | <eoed> | como | jocomone © banca<br>T.N) 10,.N) [0.N)<br>oR<br>tt Nome_©S" Nome ers ta<br>(0.1) Target<br><a>Pp BUDGET O Frequncaras -_ bat 0 mercer emisione<br>CATEGORIA on 0 HRANSAZIONEK = 4<br>01.1)<br>AWISO vata Fine 5 (0,1) (0.N) fe) 111 Oo |<br>Tipologia Importo RICORRENTE<br>Frecenca 12a<br>corenca<br><!-- End of picture text -->

Figura 1: Schema E-R corrispondente ai requisiti. 

Il diagramma Entity-Relationship (E-R) rappresentato in Figura 1 descrive l’organizzazione concettuale delle informazioni relative al sistema di _Home Budgeting_ . 

Nel modello individuiamo due gerarchie di specializzazione ed entit`a a identificazione esterna: 

- **Gerarchia dei Conti** : L’entit`a `CONTO` rappresenta la generalizzazione di qualsiasi rapporto finanziario. Essa viene specializzata nella sotto-entit`a `CONTO CORRENTE` , la quale ereditando gli attributi generali ( `ID` , `Nome` , `Saldo` ), estende l’informazione con i dati specifici relativi all’istituto bancario ( `IBAN` e `Nome Banca` ). Si tratta di una gerarchia parziale ed esclusiva, in quanto un conto pu`o non essere un conto corrente (es. contanti) e non pu`o appartenere a pi`u specializzazioni. 

- **Gerarchia delle Transazioni** : L’entit`a `TRANSAZIONE` ammette due specializzazioni non esclusive (sovrapponibili): `TRASFERIMENTO` e `RICORRENTE` . La specializzazione `TRASFERIMENTO` modella i movimenti di fondi collegandosi, tramite la relazione `INDIRIZZATO` , al conto di destinazione e memorizzando la commissione applicata. La specializzazione `RICORRENTE` memorizza i dettagli sulla temporizzazione dei movimenti periodici ( `Frequenza` e `Fine Ricorrenza` ). 

- **Identificazione Esterna e Dipendenze** : L’entit`a `CATEGORIA` `e identificata esternamente dall’entit`a `UTENTE` mediante la relazione `CREA` , garantendo che ogni categoria appartenga univocamente a un determinato utente. L’entit`a `BUDGET` possiede un’identificazione esterna mediante la relazione `LIMITA` (con `CATEGORIA` ) indicante la categoria dell’utente a cui il budget fa riferimento. Infine, l’entit`a `AVVISO` 

4 

`e modellata come entit`a debole identificata totalmente dall’entit`a `BUDGET` tramite la relazione `ATTIVA` . 

La Tabella 1 riassume tutte le entit`a e le relazioni individuate dall’analisi dei requisiti e rappresentate nel diagramma E-R, con i relativi attributi e i rispettivi identificatori primari (comprensivi delle identificazioni esterne). 

### **3.1 Vincoli non esprimibili nel Diagramma E-R** 

Il diagramma E-R non permette di rappresentare direttamente alcuni vincoli di integrit`a semantica propri del dominio applicativo, che dovranno pertanto essere garantiti a livello di logica applicativa: 

1. **Coerenza del Trasferimento tra Conti dello stesso Utente** : Una transazione di tipo `TRASFERIMENTO` deve avvenire esclusivamente tra due conti appartenenti al medesimo utente. In termini formali, indicando con _c_ origine il conto di partenza e con _c_ destinazione il conto di arrivo associati al trasferimento: 

   - _∃u ∈_ UTENTE : ( _u, c_ origine) _∈_ POSSIEDE _∧_ ( _u, c_ destinazione) _∈_ POSSIEDE 

2. **Disgiunzione tra Conto Sorgente e Destinazione** : In un `TRASFERIMENTO` , il conto di origine e il conto di destinazione non possono coincidere: 

_c_ origine _̸_ = _c_ destinazione 

3. **Coerenza della Categoria della Transazione** : Una transazione _t_ eseguita su un conto _c_ di un utente _u_ pu`o essere associata solo a una categoria _cat_ creata dal medesimo utente _u_ : 

( _u, c_ ) _∈_ POSSIEDE _∧_ ( _c, t_ ) _∈_ EFFETTUA _∧_ ( _t, cat_ ) _∈_ APPARTIENE = _⇒_ ( _u, cat_ ) _∈_ CREA 

4. **Coerenza della Tipologia della Transazione** : Se una transazione appartiene alla specializzazione `TRASFERIMENTO` , l’attributo `Tipologia` dell’entit`a genitore `TRANSAZIONE` deve assumere obbligatoriamente il valore `’Trasferimento’` . 

## **4 Progettazione Logica** 

L’obiettivo della progettazione logica `e la traduzione dello schema E-R rappresentato in Figura 1 in uno schema relazionale equivalente, efficiente e direttamente implementabile in un DBMS SQL. 

Il processo di ristrutturazione si articola in diverse fasi: in primo luogo, si conduce l’analisi delle ridondanze per valutare la presenza di attributi derivabili, bilanciando l’efficienza delle query frequenti con i costi di memorizzazione e aggiornamento della base di dati. Successivamente, si procede all’eliminazione delle gerarchie di specializzazione ( `Conto Corrente` , `Trasferimento` e `Ricorrente` ), convertendole in tabelle convenzionali tramite opportune strategie di accorpamento o separazione. 

5 

|**Entit`a**|**Descrizione**|**Attributi**|**Identificatore**|
|---|---|---|---|
|Utente|Soggetto<br>registrato<br>nel sistema|_ID,_<br>_Nome,_<br>_Cognome,_<br>_Email_|_ID_|
|Conto|Disponibilit`a liquida o<br>conto finanziario|_ID, Nome, Saldo_|_ID_|
|Conto Corren-<br>te|Conto corrente banca-<br>rio|_IBAN, Nome_<br>_~~B~~anca_||
|Transazione|Movimento finanziario|_ID, Nome, Data, Ora, Im-_<br>_porto, Tipologia_|_ID_|
|Trasferimento|Trasferimento di fondi<br>tra conti|_Commissione_||
|Ricorrente|Transazione periodica<br>ricorsiva|_Frequenza,_<br>_Fi-_<br>_ne_<br>_~~R~~icorrenza_||
|Categoria|Classificazione<br>delle<br>transazioni|_Nome_|_Nome_,<br>Relazione<br>“Crea”|
|Budget|Pianificazione<br>tetto<br>massimo di spesa|_Target,_<br>_Frequenza,_<br>_Da-_<br>_ta_<br>_~~F~~ine_|Relazione<br>“Imposta”,<br>Relazione “Limita”|
|Avviso|Notifica di allarme so-<br>glia budget|_Tipologia, Soglia_|Relazione “Attiva”|



(a) Entit`a 

|**Relazione**|**Descrizione**|**Componente**|**Attributi**|
|---|---|---|---|
|Possiede|Intestazione di un conto ad<br>un utente|Utente, Conto|_Livello_<br>_~~A~~ccesso_|
|Crea|Definizione di una catego-<br>ria daparte dell’utente|Utente, Categoria||
|Imposta|Configurazione di un bud-<br>get daparte dell’utente|Utente, Budget||
|Limita|Associazione del limite di<br>budget a una categoria|Categoria, Budget||
|Attiva|Generazione di un avviso<br>da un budget|Budget, Avviso||
|Effettua|Registrazione di una tran-<br>sazione su un conto|Conto, Transazione||
|Indirizzato|Destinazione del trasferi-<br>mento verso un conto|Trasferimento, Conto||
|Appartiene|Classificazione di una tran-<br>sazione in una categoria|Categoria, Transazio-<br>ne||



(b) Relazioni 

Tabella 1: Dizionario delle Entit`a e delle Relazioni individuate dalla progettazione concettuale. 

6 

### **4.1 Analisi delle Ridondanze** 

Analizziamo l’attributo ridondante `Saldo` nell’entit`a `CONTO` per decidere se `e pi`u efficiente mantenerlo o rimuoverlo rispetto ad alcune operazioni ipotetiche. Tale valore `e infatti derivabile dal calcolo dell’importo delle transazioni collegate al conto. 

Si considerano le seguenti due operazioni principali: 

- **Operazione 1 (100 al giorno)** : Inserimento di una nuova transazione relativa a un determinato conto. 

- **Operazione 2 (500 al giorno)** : Visualizzazione del saldo attuale di un conto. 

Assumendo i seguenti volumi nella base di dati: 

|**Concetto**|**Costrutto**|**Volume**|
|---|---|---|
|CONTO|E|1000|
|EFFETTUA|R|50000|
|TRANSAZIONE|E|50000|



Si ipotizza una media di 50 transazioni registrate per ciascun conto (50000 _/_ 1000 = 50). 

**CON RIDONDANZA** Analizziamo prima il costo totale con ridondanza. 

- **Operazione 1** : 

|**Concetto**|**Costrutto**|**Accessi**|**Tipo**||
|---|---|---|---|---|
|TRANSAZIONE|E|1|S||
|EFFETTUA|R|1|S|_×_100|
|CONTO|E|1|L||
|CONTO|E|1|S||



- **Operazione 2** : 

**Concetto Costrutto Accessi Tipo** _×_ 500 CONTO E 1 L 

Assumendo costo doppio per gli accessi in scrittura: 

Costo Totale = 100 _×_ (1 _×_ 1 + 3 _×_ 2) + 500 _×_ (1 _×_ 1) = 100 _×_ 7 + 500 _×_ 1 = 1200 

#### **SENZA RIDONDANZA** Analizziamo il costo totale senza ridondanza. 

- **Operazione 1** : 

|**Concetto**|**Costrutto**|**Accessi**|**Tipo**||
|---|---|---|---|---|
|TRANSAZIONE|E|1|S|_×_100|
|EFFETTUA|R|1|S||



7 

#### • **Operazione 2** : 

|**Concetto**|**Costrutto**|**Accessi**|**Tipo**||
|---|---|---|---|---|
|CONTO|E|1|L|_×_500|
|EFFETTUA|R|50|L||
|TRANSAZIONE|E|50|L||



Assumendo costo doppio per gli accessi in scrittura: 

Costo Totale = 100 _×_ (2 _×_ 2)+500 _×_ (101 _×_ 1) = 100 _×_ 4+500 _×_ 101 = 400+50500 = 50900 

Il confronto tra i costi complessivi (1200 con ridondanza contro 50900 senza ridondanza) dimostra un enorme vantaggio nel mantenere l’attributo ridondante. Pertanto, si sceglie di mantenere la ridondanza dell’attributo `Saldo` in `CONTO` . 

### **4.2 Eliminazione delle Generalizzazioni** 

Le generalizzazioni descritte nella sezione precedente vengono eliminate attraverso una ristrutturazione dello schema concettuale, con l’obiettivo di permettere la successiva implementazione del modello relazionale mantenendo limitata la presenza di valori nulli: 

**CONTO** La gerarchia parziale ed esclusiva di `CONTO` viene eliminata accorpando la sotto-entit`a `CONTO CORRENTE` direttamente nell’entit`a genitore. Questa scelta permette di evitare operazioni di _join_ durante le interrogazioni pi`u frequenti, ottimizzando l’accesso ai dettagli del conto e la lettura del saldo. Dato che si pu`o intuire che la maggior parte dei conti salvati in questa base di dati saranno conti corrente e notando che la generalizzazione estende il genitore con soli due attributi specifici ( _IBAN_ e _Nome_ _~~B~~ anca_ ), l’accorpamento comporta un impatto trascurabile in termini di campi nulli. Sarebbe stato possibile procedere con la separazione delle informazioni in due tabelle distinte, ma questa soluzione avrebbe introdotto un’inutile complessit`a nelle query, richiedendo spesso un’operazione di join, senza portare benefici impattanti. 

**TRANSAZIONE** La gerarchia sovrapposta di `TRANSAZIONE` viene eliminata mantenendo l’entit`a genitore e creando due entit`a dedicate per le specializzazioni `TRASFERIMENTO` e `RICORRENTE` , collegate tramite relazioni 1,1 IS-TRS e IS-RCR. Questa scelta riduce la presenza di valori nulli: se si accorpassero tutti gli attributi in un’unica entit`a `TRANSAZIONE` , le transazioni ordinarie (entrate ed uscite dirette), che costituiscono la quasi totalit`a dei movimenti, avrebbero campi nulli per la frequenza, la data di fine ricorsione, il conto di destinazione e la commissione applicata. Separando le informazioni con entit`a dedicate, si garantisce che l’entit`a principale rimanga efficiente per le operazioni di ricerca e storicizzazione. In questa soluzione gli identificatori delle nuove entit`a _Trasferimento_ e _Ricorrente_ coincideranno con l’identificatore dell’entit`a genitore _Transazione_ mediante identificazione esterna. 

Il diagramma ER in Figura 2 rappresenta le modifiche espresse in questa sezione applicate al precedente schema della Figura 1. 

8 



<!-- Start of picture text -->
Nome Copnome preteenLeo Nome Sado 1<br>° «O 9 ° 9<br>EmailO 0 80 (0-1-0 18aN<br>UTENTE CONTO poni-oNeme———_Commigsone<br>TN) 10.N) 10.N)<br><a> oN 11.4]<br>1) <> <em> WNOIRIZZATO >} TRASFERIMENTOGa<br>on BUDGET Orange co<br>" OFrequenca ate O<br>Data Fimea CATEGORIA on © ITRANSAZIONE| TO<br>AWISO ooon osa ) 11) )<br>Tipologia Importo<br>(1,1)<br>6 4<br>Frowience se<br>icorerza<br><!-- End of picture text -->

Figura 2: Schema E-R ristrutturato. 

### **4.3 Schema Relazionale** 

Lo schema ristrutturato contiene solamente costrutti mappabili in corrispettivi dello schema relazionale che `e rappresentato a seguire. L’asterisco dopo il nome degli attributi indica quelli che ammettono valori nulli, quelli sottolineati invece sono le chiavi primarie della tabella. 

- **Utente** <u>(ID, Nome, Cognome, Email)</u> 

- **Conto** <u>(ID, Nome, Saldo, IBAN*, Nome</u> ~~B~~ anca*) 

- **Possiede** <u>(Utente</u> ~~I~~ D, Conto ~~I~~ D, Livello ~~A~~ ccesso) 

   - Possiede.Utente ~~I~~ D _→_ Utente.ID 

   - Possiede.Conto ~~I~~ D _→_ Conto.ID 

- **Categoria** <u>(Utente</u> ~~I~~ D, Nome) 

   - Categoria.Utente ~~I~~ D _→_ Utente.ID 

- **Budget** <u>(Categoria</u> ~~U~~ tente, Categoria ~~N~~ ome, Data ~~F~~ ine, Target, Frequenza) 

   - Budget.(Categoria ~~U~~ tente, Categoria ~~N~~ ome) _→_ Categoria.(Utente ~~I~~ D, Nome) 

- **Avviso** <u>(Budget</u> ~~U~~ tente, Budget ~~C~~ ategoria, Tipologia, Soglia) 

9 

   - Avviso.(Budget ~~U~~ tente, Budget ~~C~~ ategoria) _→_ Budget.(Categoria ~~U~~ tente, Categoria ~~N~~ ome) 

- **Transazione** <u>(ID, Nome, Data, Ora, Importo, Tipologia, Conto</u> ~~I~~ D, Categoria ~~U~~ tente, Categoria ~~N~~ ome) 

   - Transazione.Conto ~~I~~ D _→_ Conto.ID 

   - Transazione.(Categoria ~~U~~ tente, Categoria ~~N~~ ome) _→_ Categoria.(Utente ~~I~~ D, Nome) 

- **Trasferimento** (Transazione ~~<u>I</u>~~ <u>D, Commissione, Conto</u> ~~D~~ estinazione ~~I~~ D) 

   - Trasferimento.Transazione ~~I~~ D _→_ Transazione.ID 

   - Trasferimento.Conto ~~D~~ estinazione ~~I~~ D _→_ Conto.ID 

- **Ricorrente** (Transazione ~~<u>I</u>~~ <u>D, Frequenza, Fine</u> ~~R~~ icorrenza) 

   - Ricorrente.Transazione ~~I~~ D _→_ Transazione.ID 

## **5 Implementazione** 

Nel file home ~~b~~ udgeting.sql `e presente il codice necessario alla creazione e popolamento delle tabelle necessarie alla base di dati. Inoltre presenta 5 query per estrarre dati specifici da esse ed un indice necessario a ottimizzare una delle query. 

### **5.1 Definizione delle Query** 

Vengono elencate qui le 5 query descritte con il relativo output. **Query 1** Trovare quanto `e stato speso in totale nel 2026 in bollette da parte dell’utente 2. 

1 <mark>`SELECT U.Nome , U.Cognome , SUM (T.Importo) AS Totale_Speso`</mark> 

2 <mark>`FROM Transazione T`</mark> 3 <mark>`JOIN Utente U ON T. Categoria_Utente = U.ID`</mark> 

- 4 <mark>`WHERE T.Tipologia = ’Uscita ’`</mark> 

- 5 <mark>`AND T. Categoria_Utente = 2`</mark> 

- 6 <mark>`AND T. Categoria_Nome = ’Bollette ’`</mark> 

7 <mark>`AND EXTRACT ( YEAR FROM T.Data) = 2026`</mark> 8 <mark>`GROUP BY U.Nome , U.Cognome;`</mark> 

Di seguito un’estratto dell’output: 



<!-- Start of picture text -->
nome a cognome a totale_speso a<br>character varying (100) @ character varying (100) ™ numeric<br>1 Marco Rossi 399.90<br><!-- End of picture text -->

10 

**Query 2** Calcolare il patrimonio totale per utente (consideriamo parte del patrimonio dell’utente i conti in cui ha un livello di accesso almeno ’Modifica). 

1 <mark>`SELECT U.ID , U.Nome , U.Cognome , SUM (C.Saldo) AS Patrimonio_Totale`</mark> 2 <mark>`FROM Utente U`</mark> 3 <mark>`JOIN Possiede P ON U.ID = P.Utente_ID`</mark> 4 <mark>`JOIN Conto C ON P.Conto_ID = C.ID`</mark> 5 <mark>`WHERE P. Livello_Accesso <> ’Lettura ’`</mark> 6 <mark>`GROUP BY U.ID , U.Nome , U.Cognome`</mark> 7 <mark>`ORDER BY Patrimonio_Totale DESC ;`</mark> 

#### Di seguito un’estratto dell’output: 



<!-- Start of picture text -->
2. Marco Rossi 19050,00<br>1 Luca Cesco Bolla 9285.50<br>5 Alessandro Neri 8400.00<br>3 Giulia Bianchi 5960.00<br>9 Davide Bruni 5120.00<br>6 Francesca Gialli 4300.00<br>4 Elena Verde 890.00<br>12. Sara Colombo 890.00<br>8 Sofia Rosa 210.00<br>7 Matteo Viola 60.00<br><!-- End of picture text -->

#### **Query 3** Elencare tutte le uscite ricorrenti, con la relativa frequenza, per ogni utente. 

1 <mark>`SELECT T. Categoria_Utente AS id_utente , U.Nome , U.Cognome ,`</mark> 2 <mark>`T.Nome AS nome_transazione , T.Importo , R.Frequenza`</mark> 3 <mark>`FROM Transazione T`</mark> 4 <mark>`JOIN Ricorrente R ON T.ID = R. Transazione_ID`</mark> 5 <mark>`JOIN Utente U ON T. Categoria_Utente = U.ID`</mark> 6 <mark>`WHERE T.Tipologia = ’Uscita ’`</mark> 7 <mark>`ORDER BY T. Categoria_Utente ASC ;`</mark> 

#### Di seguito un’estratto dell’output: 



<!-- Start of picture text -->
1 twca cesco Bolla ‘Abbonamento Netix 17.99 Mensile<br>1 twa cesco Bolla ‘Abbonamento Spoify 1099 Anuale<br>1 twa cesco Bolla Bolletta Gas Metano 8550 Settmanale<br>1 wea cesco Bolla Rcarica Telefonica liad 9.99 Mensile<br>1 tea cesco Bolla [Abbonamento Netix 17.99 Mensile<br>2 Marco Rossi Assicurazione Auto Annuale 520.00 Annuale<br>2 Marco Rossi Bolletta ntemet Fibra 29.90 Mensile<br>2 Marco Rossi Bolletta Luce Casa 120.00 Mensie<br>3 Gila ‘lane [Abbonamento Palestra Mens. 60.00 Annuale<br>3 Giulia Bianchi ‘Abbonamente Annuale Pales 1550.00 Annuale<br>5 Alessandro Net Licenza Software Adobe 6599 Annuale<br><!-- End of picture text -->

11 

#### **Query 4** Elencare i conti co-intestati e il loro bilancio. 

- 1 <mark>`SELECT C.ID AS id_conto , C.Saldo , COUNT (P.Utente_ID) AS Numero_Cointestatari`</mark> 

- 2 <mark>`FROM Conto C`</mark> 

- 3 <mark>`JOIN Possiede P ON C.ID = P.Conto_ID`</mark> 

- 4 <mark>`GROUP BY C.ID , C.Saldo`</mark> 

- 5 <mark>`HAVING COUNT (P.Utente_ID) > 1`</mark> 6 <mark>`ORDER BY C.Saldo DESC ;`</mark> 

#### Di seguito un’estratto dell’output: 



<!-- Start of picture text -->
iz 5 15000.00 2<br>2 | 8 8400.00 2<br>El 15 4500.00 A<br>4 13 4300.00 2<br>Em 1 3450.50 2<br>6 4 2200.00 3<br>EZ 6 1850.00 2<br>8 12 890.00 2<br>9 7 210.00 2<br><!-- End of picture text -->

**Query 5** Elencare le categorie per cui un utente ha superato il budget mensile fissato a settembre 2026. 

- 1 <mark>`SELECT B. Categoria_Utente AS id_utente ,`</mark> 

- 2 <mark>`B. Categoria_Nome AS Categoria ,`</mark> 

- 3 <mark>`B.Target AS Budget_Impostato ,`</mark> 

- 4 <mark>`SUM (T.Importo) AS Spesa_Totale`</mark> 

- 5 <mark>`FROM Budget B`</mark> 

- 6 <mark>`JOIN Transazione T ON B. Categoria_Utente = T. Categoria_Utente`</mark> 

- 7 <mark>`AND B. Categoria_Nome = T. Categoria_Nome`</mark> 

- 8 <mark>`WHERE T.Tipologia = ’Uscita ’`</mark> 

- 9 <mark>`AND B.Frequenza = ’Mensile ’`</mark> 

- 10 <mark>`AND EXTRACT ( YEAR FROM T.Data) = 2026`</mark> 

- 11 <mark>`AND EXTRACT ( MONTH FROM T.Data) = 9`</mark> 

- 12 <mark>`GROUP BY B.Categoria_Utente , B.Categoria_Nome , B.Target`</mark> 

- 13 <mark>`HAVING SUM (T.Importo) > B.Target;`</mark> 

#### Di seguito un’estratto dell’output: 

12 



<!-- Start of picture text -->
idutente categoria<br>integer character varying (100) f@@ Pdgetimpostatonumeric (10,2) 5, spesa.totalenumeric 5<br>1 1 Spesa Alimentare 450.00 474,30<br>2 1 Svago & Ristoranti 250.00 333,00<br><!-- End of picture text -->

### **5.2 Definizione degli Indici** 

Si suppone di voler ottimizzare la Query 3, per la quale occorre considerare: 

1. Condizione di Join tra _Transazione_ e _Ricorrente_ : `T.ID = R.Transazione` ~~`I`~~ `D` . 

2. Condizione di Join tra _Transazione_ e _Utente_ : `T.Categoria Utente = U.ID` . 

3. Condizione di filtraggio sulla tabella _Transazione_ : `T.Tipologia = ’Uscita’` . 

4. Ordinamento sull’attributo _Categoria_ _~~U~~ tente_ : `ORDER BY T.Categoria` ~~`U`~~ `tente ASC` . 

Per i punti 1 e 2, nell’ipotesi in cui il DBMS non crei indici automatici per le chiavi primarie, `e opportuno creare gli indici Hash sulle colonne dei join: 

1 <mark>`CREATE INDEX idx_transazione_id ON Transazione USING HASH (ID);`</mark> 2 <mark>`CREATE INDEX idx_ricorrente_id ON Ricorrente USING HASH ( Transazione_ID );`</mark> 3 <mark>`CREATE INDEX idx_utente_id ON Utente USING HASH (ID);`</mark> 

Questi indici permettono di effettuare i join tra le tabelle sfruttando i codici Hash, operazione estremamente efficiente per i confronti di uguaglianza. 

Per gestire invece il filtraggio (punto 3) e l’ordinamento (punto 4), si crea un indice composito di tipo B+ Tree sulla tabella _Transazione_ : 

1 <mark>`CREATE INDEX idx_transazione_tipologia_id`</mark> 2 <mark>`ON Transazione(Tipologia , Categoria_Utente );`</mark> 

L’indice B+ Tree filtra immediatamente le sole righe con `Tipologia = ’Uscita’` e le mantiene gi`a ordinate per _Categoria_ _~~U~~ tente_ . 

Come detto precedentemente, nella pratica non `e necessario creare gli indici sugli attributi `Ricorrente(Transazione ID)` e `Utente(ID)` in quanto PostgreSQL e la maggior parte dei DBMS creano automaticamente un indice B+ Tree per ogni chiave primaria. 

## **6 Applicazione Software** 

Il file `home budgeting.c` contiene il codice C necessario per connettersi al database e visualizzare direttamente i risultati delle query precedentemente descritte. 

All’avvio dell’eseguibile all’utente verr`a proposto un men`u in cui potr`a andare a selezionare la query da eseguire: 

13 

1. Spesa totale bollette 2026 dell’Utente 2. 

2. Patrimonio totale per utente. 

3. Uscite ricorrenti e frequenza per utente. 

4. Conti co-intestati e relativo bilancio. 

5. Categorie con budget mensile superato a Settembre 2026. 

L’utente potr`a selezionare la query da eseguire digitando il numero corrispondente. 

14 

