#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dependencies/include/libpq-fe.h"

#define PG_HOST "127.0.0.1"
#define PG_USER "postgres"
#define PG_DB "postgres"
#define PG_PASS "pswd_try_1"
#define PG_PORT 5432

//Funzione di controllo dei risultati
void checkResults(PGresult *res, PGconn *conn) {
    if(PQresultStatus(res) != PGRES_TUPLES_OK) {
        printf("Errore durante l'esecuzione della query: %s\n", PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
}

//Funzione di stampa dei risultati
void printResult(PGresult *res) {
    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    for(int i = 0; i < campi; i++) {
        printf("%s\t\t", PQfname(res, i));
    }
    printf("\n");

    for(int i = 0; i < tuple; i++) {
        for(int j = 0; j < campi; j++) {
            printf("%s\t\t", PQgetvalue(res, i, j));
        }
        printf("\n");
    }
    printf("\n");
}

//Funzione per eseguire una query
void esegui_query(PGconn *conn, const char *sql) {
    PGresult *res = PQexec(conn, sql);
    checkResults(res, conn);
    printResult(res);
    PQclear(res);
}

int main(int argc, char **argv) {

    char conninfo[250];

    sprintf(conninfo, "user=%s password=%s dbname=%s hostaddr=%s port=%d",
            PG_USER, PG_PASS, PG_DB, PG_HOST, PG_PORT);

    PGconn *conn = PQconnectdb(conninfo);

    //Verifico lo stato di connessione
    if (PQstatus(conn) != CONNECTION_OK) {
        printf("Errore di connessione: %s\n", PQerrorMessage(conn));
        PQfinish(conn);
        exit(1);
    } else {
        printf("Connessione avvenuta correttamente\n");
    }

    int scelta = -1;

    do {
        printf("HOME BUDGETING\n");
        printf("1. Spesa totale bollette 2026 dell'Utente 2\n");
        printf("2. Patrimonio totale per utente\n");
        printf("3. Uscite ricorrenti e frequenza per utente\n");
        printf("4. Conti co-intestati e relativo bilancio\n");
        printf("5. Categorie con budget mensile superato a Settembre 2026\n");
        printf("0. Esci\n");
        printf("Scegli un'opzione: ");

        //Lettura input
        if (scanf("%d", &scelta) != 1) {
            printf("\nInput non valido, inserisci un numero.\n");
            while (getchar() != '\n'); 
            continue;
        }

        switch (scelta) {
            case 1:
                printf("\nQUERY 1: Spesa totale bollette 2026 dell'Utente 2\n");
                esegui_query(conn,
                    "SELECT U.Nome, U.Cognome, SUM(T.Importo) AS Totale_Speso "
                    "FROM Transazione T "
                    "JOIN Utente U ON T.Categoria_Utente = U.ID "
                    "WHERE T.Tipologia='Uscita' "
                    "AND T.Categoria_Utente = 2 "
                    "AND T.Categoria_Nome='Bollette' "
                    "AND EXTRACT(YEAR FROM T.Data) = 2026 "
                    "GROUP BY U.Nome, U.Cognome;");
                break;

            case 2:
                printf("\nQUERY 2: Patrimonio totale per utente\n");
                esegui_query(conn,
                    "SELECT U.ID, U.Nome, U.Cognome, SUM(C.Saldo) AS Patrimonio_Totale "
                    "FROM Utente U "
                    "JOIN Possiede P ON U.ID = P.Utente_ID "
                    "JOIN Conto C ON P.Conto_ID = C.ID "
                    "WHERE P.Livello_Accesso<>'Lettura' "
                    "GROUP BY U.ID, U.Nome, U.Cognome "
                    "ORDER BY Patrimonio_Totale DESC;");
                break;

            case 3:
                printf("\nQUERY 3: Uscite ricorrenti per utente\n");
                esegui_query(conn,
                    "SELECT T.Categoria_Utente AS id_utente, U.Nome, U.Cognome, T.Nome AS nome_transazione, T.Importo, R.Frequenza "
                    "FROM Transazione T "
                    "JOIN Ricorrente R ON T.ID = R.Transazione_ID "
                    "JOIN Utente U on T.Categoria_Utente = U.ID "
                    "WHERE T.Tipologia = 'Uscita' "
                    "ORDER BY T.Categoria_Utente ASC;");
                break;

            case 4:
                printf("\nQUERY 4: Conti co-intestati e bilancio\n");
                esegui_query(conn,
                    "SELECT C.ID AS id_conto, C.Saldo, COUNT(P.Utente_ID) AS Numero_Cointestatari "
                    "FROM Conto C "
                    "JOIN Possiede P ON C.ID = P.Conto_ID "
                    "GROUP BY C.ID, C.Saldo "
                    "HAVING COUNT(P.Utente_ID) > 1 "
                    "ORDER BY C.Saldo DESC;");
                break;

            case 5:
                printf("\nQUERY 5: Categorie con budget mensile superato a Settembre 2026\n");
                esegui_query(conn,
                    "SELECT B.Categoria_Utente AS id_utente, "
                    "B.Categoria_Nome AS Categoria, "
                    "B.Target AS Budget_Impostato, "
                    "SUM(T.Importo) AS Spesa_Totale "
                    "FROM Budget B "
                    "JOIN Transazione T ON B.Categoria_Utente = T.Categoria_Utente AND B.Categoria_Nome = T.Categoria_Nome "
                    "WHERE T.Tipologia = 'Uscita' "
                    "AND B.Frequenza = 'Mensile' "
                    "AND EXTRACT(YEAR FROM T.Data) = 2026 AND EXTRACT(MONTH FROM T.Data) = 9 "
                    "GROUP BY B.Categoria_Utente, B.Categoria_Nome, B.Target "
                    "HAVING SUM(T.Importo) > B.Target;");
                break;

            case 0:
                break;

            default:
                printf("\nOpzione non valida, riprova.\n");
                break;
        }

    } while (scelta != 0);

    PQfinish(conn);

    return 0;
}