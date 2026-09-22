::: titlepage
![image](logo_universita.png){width="70%"}\
[Università degli Studi di Padova]{.smallcaps}\
Dipartimento di Matematica\
Corso di Laurea in Informatica\
Progetto di Basi di Dati\

------------------------------------------------------------------------

\
**Home Budgeting: Base di dati di un sistema per la Gestione delle
Finanze Personali**\

------------------------------------------------------------------------

\

::: flushleft
**Docente:**\
Prof. Massimiliano de Leoni
:::

::: flushright
**Studente:**\
Luca Cesco Bolla (Matr. 2138006)\
:::

Anno Accademico 2025/2026
:::

# Abstract

Negli ultimi anni, la crescente molteplicità di strumenti finanziari
(conti correnti, carte di credito, investimenti) e la necessità di un
risparmio consapevole rendono fondamentale l'adozione di strumenti
digitali per il controllo della spesa. Il presente progetto si propone
di progettare e realizzare una base di dati a supporto di
un'applicazione di Home Budgeting, studiata per offrire agli utenti un
tracciamento centralizzato, accurato e flessibile della propria
situazione finanziaria.

Il sistema è concepito per gestire una molteplicità di utenti e supporta
sia conti personali ad uso individuale, sia conti co-intestati tra più
utenti, per i conti co-intestati deve essere possibile specificare un
livello di accesso necessario a garantire la sicurezza del conto.
All'interno della base di dati vengono registrate le transazioni
finanziarie: suddivise in entrate, uscite e trasferimenti interni tra
conti distinti dello stesso utente, solitamente al costo di una
commissione, gestendo anche eventuali transazioni ricorrenti. Ogni
transazione è associata a una categoria specifica, permettendo
un'organizzazione e una classificazione dettagliata dei flussi
finanziari.

A completamento delle funzionalità operative, la piattaforma implementa
uno strumento di pianificazione: ciascun utente può impostare limiti di
spesa (budget) per singola categoria su orizzonti temporali settimanali,
mensili o personalizzati. Ad ogni budget attivo è integrato un sistema
di avviso basato su soglie configurabili, in grado di generare notifiche
o e-mail per segnalare il rischio di sforamento del tetto di spesa.

# Analisi dei Requisiti

**Utente**. Rappresenta i soggetti registrati nel sistema che gestiscono
i propri flussi finanziari. Per ciascun utente si devono memorizzare:

-   Codice univoco (ID) che distingue in modo univoco ogni utente.

-   Nome e Cognome dell'utente.

-   Indirizzo e-mail di contatto.

**Conto**. Rappresenta le disponibilità liquide e i rapporti finanziari
sui quali vengono registrati i movimenti. Per ogni conto si devono
memorizzare:

-   Codice univoco (ID) che distingue ogni conto.

-   Nome del conto (es. Contanti, Conto Principale).

-   Saldo corrente presente sul conto.

Per ogni associazione tra un utente e un conto (in particolare nei conti
co-intestati), si deve memorizzare il relativo **livello di accesso**
che può essere Lettura, Modifica oppure Amministratore.

Per i **Conti Corrente** bancari, oltre alle informazioni di base, si
rende necessario memorizzare ulteriori dettagli relativi alla banca:

-   Codice IBAN.

-   Nome della Banca di riferimento.

**Transazione**. Rappresenta ogni singolo movimento finanziario
registrato sui conti. Per ciascuna transazione si devono memorizzare:

-   Codice univoco (ID) della transazione.

-   Nome o descrizione sintetica del movimento.

-   Data e Ora di esecuzione.

-   Importo e Tipologia dell'operazione (Entrata, Uscita,
    Trasferimento).

-   Se la transazione è ricorrente oppure no.

Nel caso in cui la transazione rappresenti un **Trasferimento** di fondi
tra conti, oltre alle informazioni di base, si specifica:

-   Conto di destinazione verso cui è diretto il movimento.

-   Commissione pagata.

Qualora la transazione fosse **Ricorrente** nel tempo, oltre ai dati
generali della transazione, si registrano:

-   Frequenza di ripetizione del movimento.

-   Data di fine della ricorrenza.

**Categoria**. Rappresenta la classificazione tematica utilizzata per
catalogare le transazioni. Per ciascuna categoria si devono memorizzare:

-   Nome della categoria (es. Spesa, Stipendio, Trasporti).

**Budget**. Rappresenta la pianificazione del tetto massimo di spesa
impostato su una specifica categoria. Per ogni budget si devono
memorizzare:

-   Importo target massimo di spesa.

-   Frequenza temporale (settimanale, mensile o personalizzata).

-   Data Fine del periodo del budget.

**Avviso**. Rappresenta il meccanismo di notifica collegato al
superamento della soglia di avviso impostata nel budget. Per ogni avviso
si devono memorizzare:

-   Tipologia di invio della segnalazione (es. Notifica, Email).

-   Soglia percentuale o monetaria di allarme.

# Progettazione Concettuale

![Schema E-R corrispondente ai requisiti.](Schema_ER.png){#fig:schema_er
width="100%"}

Il diagramma Entity-Relationship (E-R) rappresentato in Figura
[1](#fig:schema_er){reference-type="ref" reference="fig:schema_er"}
descrive l'organizzazione concettuale delle informazioni relative al
sistema di *Home Budgeting*.

Nel modello individuiamo due gerarchie di specializzazione ed entità a
identificazione esterna:

-   **Gerarchia dei Conti**: L'entità `CONTO` rappresenta la
    generalizzazione di qualsiasi rapporto finanziario. Essa viene
    specializzata nella sotto-entità `CONTO CORRENTE`, la quale
    ereditando gli attributi generali (`ID`, `Nome`, `Saldo`), estende
    l'informazione con i dati specifici relativi all'istituto bancario
    (`IBAN` e `Nome Banca`). Si tratta di una gerarchia parziale ed
    esclusiva, in quanto un conto può non essere un conto corrente (es.
    contanti) e non può appartenere a più specializzazioni.

-   **Gerarchia delle Transazioni**: L'entità `TRANSAZIONE` ammette due
    specializzazioni non esclusive (sovrapponibili): `TRASFERIMENTO` e
    `RICORRENTE`. La specializzazione `TRASFERIMENTO` modella i
    movimenti di fondi collegandosi, tramite la relazione `INDIRIZZATO`,
    al conto di destinazione e memorizzando la commissione applicata. La
    specializzazione `RICORRENTE` memorizza i dettagli sulla
    temporizzazione dei movimenti periodici (`Frequenza` e
    `Fine Ricorrenza`).

-   **Identificazione Esterna e Dipendenze**: L'entità `CATEGORIA` è
    identificata esternamente dall'entità `UTENTE` mediante la relazione
    `CREA`, garantendo che ogni categoria appartenga univocamente a un
    determinato utente. L'entità `BUDGET` possiede un'identificazione
    esterna mediante la relazione `LIMITA` (con `CATEGORIA`) indicante
    la categoria dell'utente a cui il budget fa riferimento. Infine,
    l'entità `AVVISO` è modellata come entità debole identificata
    totalmente dall'entità `BUDGET` tramite la relazione `ATTIVA`.

La Tabella [2](#tab:dizionario_er){reference-type="ref"
reference="tab:dizionario_er"} riassume tutte le entità e le relazioni
individuate dall'analisi dei requisiti e rappresentate nel diagramma
E-R, con i relativi attributi e i rispettivi identificatori primari
(comprensivi delle identificazioni esterne).

## Vincoli non esprimibili nel Diagramma E-R

Il diagramma E-R non permette di rappresentare direttamente alcuni
vincoli di integrità semantica propri del dominio applicativo, che
dovranno pertanto essere garantiti a livello di logica applicativa:

1.  **Coerenza del Trasferimento tra Conti dello stesso Utente**: Una
    transazione di tipo `TRASFERIMENTO` deve avvenire esclusivamente tra
    due conti appartenenti al medesimo utente. In termini formali,
    indicando con $c_{\text{origine}}$ il conto di partenza e con
    $c_{\text{destinazione}}$ il conto di arrivo associati al
    trasferimento:
    $$\exists u \in \text{UTENTE} : (u, c_{\text{origine}}) \in \text{POSSIEDE} \land (u, c_{\text{destinazione}}) \in \text{POSSIEDE}$$

2.  **Disgiunzione tra Conto Sorgente e Destinazione**: In un
    `TRASFERIMENTO`, il conto di origine e il conto di destinazione non
    possono coincidere:
    $$c_{\text{origine}} \neq c_{\text{destinazione}}$$

3.  **Coerenza della Categoria della Transazione**: Una transazione $t$
    eseguita su un conto $c$ di un utente $u$ può essere associata solo
    a una categoria $cat$ creata dal medesimo utente $u$:
    $$(u, c) \in \text{POSSIEDE} \land (c, t) \in \text{EFFETTUA} \land (t, cat) \in \text{APPARTIENE} \implies (u, cat) \in \text{CREA}$$

4.  **Coerenza della Tipologia della Transazione**: Se una transazione
    appartiene alla specializzazione `TRASFERIMENTO`, l'attributo
    `Tipologia` dell'entità genitore `TRANSAZIONE` deve assumere
    obbligatoriamente il valore `’Trasferimento’`.

::: {#tab:dizionario_er}
  **Entità**       **Descrizione**                             **Attributi**                               **Identificatore**
  ---------------- ------------------------------------------- ------------------------------------------- -----------------------------------------
  Utente           Soggetto registrato nel sistema             *ID, Nome, Cognome, Email*                  *ID*
  Conto            Disponibilità liquida o conto finanziario   *ID, Nome, Saldo*                           *ID*
  Conto Corrente   Conto corrente bancario                     *IBAN, Nome_Banca*                          
  Transazione      Movimento finanziario                       *ID, Nome, Data, Ora, Importo, Tipologia*   *ID*
  Trasferimento    Trasferimento di fondi tra conti            *Commissione*                               
  Ricorrente       Transazione periodica ricorsiva             *Frequenza, Fine_Ricorrenza*                
  Categoria        Classificazione delle transazioni           *Nome*                                      *Nome*, Relazione "Crea"
  Budget           Pianificazione tetto massimo di spesa       *Target, Frequenza, Data_Fine*              Relazione "Imposta", Relazione "Limita"
  Avviso           Notifica di allarme soglia budget           *Tipologia, Soglia*                         Relazione "Attiva"

  : Dizionario delle Entità e delle Relazioni individuate dalla
  progettazione concettuale.
:::

\(a\) Entità

::: {#tab:dizionario_er}
  **Relazione**   **Descrizione**                                       **Componente**           **Attributi**
  --------------- ----------------------------------------------------- ------------------------ -------------------
  Possiede        Intestazione di un conto ad un utente                 Utente, Conto            *Livello_Accesso*
  Crea            Definizione di una categoria da parte dell'utente     Utente, Categoria        
  Imposta         Configurazione di un budget da parte dell'utente      Utente, Budget           
  Limita          Associazione del limite di budget a una categoria     Categoria, Budget        
  Attiva          Generazione di un avviso da un budget                 Budget, Avviso           
  Effettua        Registrazione di una transazione su un conto          Conto, Transazione       
  Indirizzato     Destinazione del trasferimento verso un conto         Trasferimento, Conto     
  Appartiene      Classificazione di una transazione in una categoria   Categoria, Transazione   

  : Dizionario delle Entità e delle Relazioni individuate dalla
  progettazione concettuale.
:::

\(b\) Relazioni

# Progettazione Logica

L'obiettivo della progettazione logica è la traduzione dello schema E-R
rappresentato in Figura [1](#fig:schema_er){reference-type="ref"
reference="fig:schema_er"} in uno schema relazionale equivalente,
efficiente e direttamente implementabile in un DBMS SQL.

Il processo di ristrutturazione si articola in diverse fasi: in primo
luogo, si conduce l'analisi delle ridondanze per valutare la presenza di
attributi derivabili, bilanciando l'efficienza delle query frequenti con
i costi di memorizzazione e aggiornamento della base di dati.
Successivamente, si procede all'eliminazione delle gerarchie di
specializzazione (`Conto Corrente`, `Trasferimento` e `Ricorrente`),
convertendole in tabelle convenzionali tramite opportune strategie di
accorpamento o separazione.

## Analisi delle Ridondanze

Analizziamo l'attributo ridondante `Saldo` nell'entità `CONTO` per
decidere se è più efficiente mantenerlo o rimuoverlo rispetto ad alcune
operazioni ipotetiche. Tale valore è infatti derivabile dal calcolo
dell'importo delle transazioni collegate al conto.

Si considerano le seguenti due operazioni principali:

-   **Operazione 1 (100 al giorno)**: Inserimento di una nuova
    transazione relativa a un determinato conto.

-   **Operazione 2 (500 al giorno)**: Visualizzazione del saldo attuale
    di un conto.

Assumendo i seguenti volumi nella base di dati:

::: center
   **Concetto**   **Costrutto**   **Volume**
  -------------- --------------- ------------
      CONTO             E            1000
     EFFETTUA           R           50000
   TRANSAZIONE          E           50000
:::

Si ipotizza una media di 50 transazioni registrate per ciascun conto
($50000 / 1000 = 50$).

**CON RIDONDANZA** Analizziamo prima il costo totale con ridondanza.

-   **Operazione 1**:

    ::: center
       **Concetto**   **Costrutto**   **Accessi**   **Tipo**
      -------------- --------------- ------------- ----------
       TRANSAZIONE          E              1           S
         EFFETTUA           R              1           S
          CONTO             E              1           L
          CONTO             E              1           S

    $\times 100$
    :::

-   **Operazione 2**:

    ::: center
       **Concetto**   **Costrutto**   **Accessi**   **Tipo**
      -------------- --------------- ------------- ----------
          CONTO             E              1           L

    $\times 500$
    :::

Assumendo costo doppio per gli accessi in scrittura:
$$\text{Costo Totale} = 100 \times (1 \times 1 + 3 \times 2) + 500 \times (1 \times 1) = 100 \times 7 + 500 \times 1 = 1200$$

**SENZA RIDONDANZA** Analizziamo il costo totale senza ridondanza.

-   **Operazione 1**:

    ::: center
       **Concetto**   **Costrutto**   **Accessi**   **Tipo**
      -------------- --------------- ------------- ----------
       TRANSAZIONE          E              1           S
         EFFETTUA           R              1           S

    $\times 100$
    :::

-   **Operazione 2**:

    ::: center
       **Concetto**   **Costrutto**   **Accessi**   **Tipo**
      -------------- --------------- ------------- ----------
          CONTO             E              1           L
         EFFETTUA           R             50           L
       TRANSAZIONE          E             50           L

    $\times 500$
    :::

Assumendo costo doppio per gli accessi in scrittura:
$$\text{Costo Totale} = 100 \times (2 \times 2) + 500 \times (101 \times 1) = 100 \times 4 + 500 \times 101 = 400 + 50500 = 50900$$

Il confronto tra i costi complessivi ($1200$ con ridondanza contro
$50900$ senza ridondanza) dimostra un enorme vantaggio nel mantenere
l'attributo ridondante. Pertanto, si sceglie di mantenere la ridondanza
dell'attributo `Saldo` in `CONTO`.

## Eliminazione delle Generalizzazioni

Le generalizzazioni descritte nella sezione precedente vengono eliminate
attraverso una ristrutturazione dello schema concettuale, con
l'obiettivo di permettere la successiva implementazione del modello
relazionale mantenendo limitata la presenza di valori nulli:

**CONTO** La gerarchia parziale ed esclusiva di `CONTO` viene eliminata
accorpando la sotto-entità `CONTO CORRENTE` direttamente nell'entità
genitore. Questa scelta permette di evitare operazioni di *join* durante
le interrogazioni più frequenti, ottimizzando l'accesso ai dettagli del
conto e la lettura del saldo. Dato che si può intuire che la maggior
parte dei conti salvati in questa base di dati saranno conti corrente e
notando che la generalizzazione estende il genitore con soli due
attributi specifici (*IBAN* e *Nome_Banca*), l'accorpamento comporta un
impatto trascurabile in termini di campi nulli. Sarebbe stato possibile
procedere con la separazione delle informazioni in due tabelle distinte,
ma questa soluzione avrebbe introdotto un'inutile complessità nelle
query, richiedendo spesso un'operazione di join, senza portare benefici
impattanti.

**TRANSAZIONE** La gerarchia sovrapposta di `TRANSAZIONE` viene
eliminata mantenendo l'entità genitore e creando due entità dedicate per
le specializzazioni `TRASFERIMENTO` e `RICORRENTE`, collegate tramite
relazioni 1,1 IS-TRS e IS-RCR. Questa scelta riduce la presenza di
valori nulli: se si accorpassero tutti gli attributi in un'unica entità
`TRANSAZIONE`, le transazioni ordinarie (entrate ed uscite dirette), che
costituiscono la quasi totalità dei movimenti, avrebbero campi nulli per
la frequenza, la data di fine ricorsione, il conto di destinazione e la
commissione applicata. Separando le informazioni con entità dedicate, si
garantisce che l'entità principale rimanga efficiente per le operazioni
di ricerca e storicizzazione. In questa soluzione gli identificatori
delle nuove entità *Trasferimento* e *Ricorrente* coincideranno con
l'identificatore dell'entità genitore *Transazione* mediante
identificazione esterna.

Il diagramma ER in Figura [2](#fig:schema_er_r){reference-type="ref"
reference="fig:schema_er_r"} rappresenta le modifiche espresse in questa
sezione applicate al precedente schema della Figura
[1](#fig:schema_er){reference-type="ref" reference="fig:schema_er"}.

![Schema E-R
ristrutturato.](Schema_ER_ristrutturato.png){#fig:schema_er_r
width="100%"}

## Schema Relazionale

Lo schema ristrutturato contiene solamente costrutti mappabili in
corrispettivi dello schema relazionale che è rappresentato a seguire.
L'asterisco dopo il nome degli attributi indica quelli che ammettono
valori nulli, quelli sottolineati invece sono le chiavi primarie della
tabella.

-   **Utente**([ID]{.underline}, Nome, Cognome, Email)

-   **Conto**([ID]{.underline}, Nome, Saldo, IBAN\*, Nome_Banca\*)

-   **Possiede**([Utente_ID, Conto_ID]{.underline}, Livello_Accesso)

    -   Possiede.Utente_ID $\rightarrow$ Utente.ID

    -   Possiede.Conto_ID $\rightarrow$ Conto.ID

-   **Categoria**([Utente_ID, Nome]{.underline})

    -   Categoria.Utente_ID $\rightarrow$ Utente.ID

-   **Budget**([Categoria_Utente, Categoria_Nome]{.underline},
    Data_Fine, Target, Frequenza)

    -   Budget.(Categoria_Utente, Categoria_Nome) $\rightarrow$
        Categoria.(Utente_ID, Nome)

-   **Avviso**([Budget_Utente, Budget_Categoria]{.underline}, Tipologia,
    Soglia)

    -   Avviso.(Budget_Utente, Budget_Categoria) $\rightarrow$
        Budget.(Categoria_Utente, Categoria_Nome)

-   **Transazione**([ID]{.underline}, Nome, Data, Ora, Importo,
    Tipologia, Conto_ID, Categoria_Utente, Categoria_Nome)

    -   Transazione.Conto_ID $\rightarrow$ Conto.ID

    -   Transazione.(Categoria_Utente, Categoria_Nome) $\rightarrow$
        Categoria.(Utente_ID, Nome)

-   **Trasferimento**([Transazione_ID]{.underline}, Commissione,
    Conto_Destinazione_ID)

    -   Trasferimento.Transazione_ID $\rightarrow$ Transazione.ID

    -   Trasferimento.Conto_Destinazione_ID $\rightarrow$ Conto.ID

-   **Ricorrente**([Transazione_ID]{.underline}, Frequenza,
    Fine_Ricorrenza)

    -   Ricorrente.Transazione_ID $\rightarrow$ Transazione.ID

# Implementazione

Nel file home_budgeting.sql è presente il codice necessario alla
creazione e popolamento delle tabelle necessarie alla base di dati.
Inoltre presenta 5 query per estrarre dati specifici da esse ed un
indice necessario a ottimizzare una delle query.

## Definizione delle Query

Vengono elencate qui le 5 query descritte con il relativo output.

**Query 1** Trovare quanto è stato speso in totale nel 2026 in bollette
da parte dell'utente 2.

``` {style="querybox"}
SELECT U.Nome, U.Cognome, SUM(T.Importo) AS Totale_Speso
FROM Transazione T 
JOIN Utente U ON T.Categoria_Utente = U.ID
WHERE T.Tipologia = 'Uscita' 
AND T.Categoria_Utente = 2 
AND T.Categoria_Nome = 'Bollette' 
AND EXTRACT(YEAR FROM T.Data) = 2026
GROUP BY U.Nome, U.Cognome;
```

Di seguito un'estratto dell'output:

![image](output_query1.png){width="65%"}

**Query 2** Calcolare il patrimonio totale per utente (consideriamo
parte del patrimonio dell'utente i conti in cui ha un livello di accesso
almeno 'Modifica).

``` {style="querybox"}
SELECT U.ID, U.Nome, U.Cognome, SUM(C.Saldo) AS Patrimonio_Totale
FROM Utente U 
JOIN Possiede P ON U.ID = P.Utente_ID 
JOIN Conto C ON P.Conto_ID = C.ID
WHERE P.Livello_Accesso <> 'Lettura'
GROUP BY U.ID, U.Nome, U.Cognome
ORDER BY Patrimonio_Totale DESC;
```

Di seguito un'estratto dell'output:

![image](output_query2.png){width="65%"}

**Query 3** Elencare tutte le uscite ricorrenti, con la relativa
frequenza, per ogni utente.

``` {style="querybox"}
SELECT T.Categoria_Utente AS id_utente, U.Nome, U.Cognome, 
       T.Nome AS nome_transazione, T.Importo, R.Frequenza
FROM Transazione T 
JOIN Ricorrente R ON T.ID = R.Transazione_ID 
JOIN Utente U ON T.Categoria_Utente = U.ID
WHERE T.Tipologia = 'Uscita'
ORDER BY T.Categoria_Utente ASC;
```

Di seguito un'estratto dell'output:

![image](output_query3.png){width="75%"}

**Query 4** Elencare i conti co-intestati e il loro bilancio.

``` {style="querybox"}
SELECT C.ID AS id_conto, C.Saldo, COUNT(P.Utente_ID) AS Numero_Cointestatari
FROM Conto C 
JOIN Possiede P ON C.ID = P.Conto_ID
GROUP BY C.ID, C.Saldo
HAVING COUNT(P.Utente_ID) > 1
ORDER BY C.Saldo DESC;
```

Di seguito un'estratto dell'output:

![image](output_query4.png){width="65%"}

**Query 5** Elencare le categorie per cui un utente ha superato il
budget mensile fissato a settembre 2026.

``` {style="querybox"}
SELECT B.Categoria_Utente AS id_utente,
B.Categoria_Nome AS Categoria,
B.Target AS Budget_Impostato,
SUM(T.Importo) AS Spesa_Totale
FROM Budget B 
JOIN Transazione T ON B.Categoria_Utente = T.Categoria_Utente 
AND B.Categoria_Nome = T.Categoria_Nome
WHERE T.Tipologia = 'Uscita' 
AND B.Frequenza = 'Mensile' 
AND EXTRACT(YEAR FROM T.Data) = 2026 
AND EXTRACT(MONTH FROM T.Data) = 9
GROUP BY B.Categoria_Utente, B.Categoria_Nome, B.Target
HAVING SUM(T.Importo) > B.Target;
```

Di seguito un'estratto dell'output:

![image](output_query5.png){width="65%"}

## Definizione degli Indici

Si suppone di voler ottimizzare la Query 3, per la quale occorre
considerare:

1.  Condizione di Join tra *Transazione* e *Ricorrente*:
    `T.ID = R.Transazione_ID`.

2.  Condizione di Join tra *Transazione* e *Utente*:
    `T.Categoria_Utente = U.ID`.

3.  Condizione di filtraggio sulla tabella *Transazione*:
    `T.Tipologia = ’Uscita’`.

4.  Ordinamento sull'attributo *Categoria_Utente*:
    `ORDER BY T.Categoria_Utente ASC`.

Per i punti 1 e 2, nell'ipotesi in cui il DBMS non crei indici
automatici per le chiavi primarie, è opportuno creare gli indici Hash
sulle colonne dei join:

``` {style="querybox"}
CREATE INDEX idx_transazione_id ON Transazione USING HASH (ID);
CREATE INDEX idx_ricorrente_id ON Ricorrente USING HASH (Transazione_ID);
CREATE INDEX idx_utente_id ON Utente USING HASH (ID);
```

Questi indici permettono di effettuare i join tra le tabelle sfruttando
i codici Hash, operazione estremamente efficiente per i confronti di
uguaglianza.

Per gestire invece il filtraggio (punto 3) e l'ordinamento (punto 4), si
crea un indice composito di tipo B+ Tree sulla tabella *Transazione*:

``` {style="querybox"}
CREATE INDEX idx_transazione_tipologia_id 
ON Transazione(Tipologia, Categoria_Utente);
```

L'indice B+ Tree filtra immediatamente le sole righe con
`Tipologia = ’Uscita’` e le mantiene già ordinate per
*Categoria_Utente*.

Come detto precedentemente, nella pratica non è necessario creare gli
indici sugli attributi `Ricorrente(Transazione_ID)` e `Utente(ID)` in
quanto PostgreSQL e la maggior parte dei DBMS creano automaticamente un
indice B+ Tree per ogni chiave primaria.

# Applicazione Software

Il file `home_budgeting.c` contiene il codice C necessario per
connettersi al database e visualizzare direttamente i risultati delle
query precedentemente descritte.

All'avvio dell'eseguibile all'utente verrà proposto un menù in cui potrà
andare a selezionare la query da eseguire:

1.  Spesa totale bollette 2026 dell'Utente 2.

2.  Patrimonio totale per utente.

3.  Uscite ricorrenti e frequenza per utente.

4.  Conti co-intestati e relativo bilancio.

5.  Categorie con budget mensile superato a Settembre 2026.

L'utente potrà selezionare la query da eseguire digitando il numero
corrispondente.
