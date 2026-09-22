CREATE TABLE Utente (
	ID INT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Cognome VARCHAR(100) NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Conto (
	ID INT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Saldo DECIMAL(10, 2) NOT NULL,
	IBAN VARCHAR(27),
	Nome_Banca VARCHAR(100)
);

CREATE TABLE Possiede (
	Utente_ID INT NOT NULL,
	Conto_ID INT NOT NULL,
	Livello_Accesso VARCHAR(20) NOT NULL CHECK (Livello_Accesso IN ('Lettura', 'Modifica', 'Amministratore')),
	PRIMARY KEY (Utente_ID, Conto_ID),
	FOREIGN KEY (Utente_ID) REFERENCES Utente(ID),
	FOREIGN KEY (Conto_ID) REFERENCES Conto(ID)
);

CREATE TABLE Categoria (
	Utente_ID INT NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	PRIMARY KEY (Utente_ID, Nome),
	FOREIGN KEY (Utente_ID) REFERENCES Utente(ID)
);

CREATE TABLE Budget (
	Categoria_Utente INT NOT NULL,
	Categoria_Nome VARCHAR(100) NOT NULL,
	Data_Fine DATE NOT NULL,
	Target DECIMAL(10, 2) NOT NULL,
	Frequenza VARCHAR(20) NOT NULL CHECK (Frequenza IN ('Settimanale', 'Mensile', 'Annuale')),
	PRIMARY KEY (Categoria_Utente, Categoria_Nome),
	FOREIGN KEY (Categoria_Utente, Categoria_Nome) REFERENCES Categoria(Utente_ID, Nome)
);

CREATE TABLE Avviso (
	Budget_Utente INT NOT NULL,
	Budget_Categoria VARCHAR(100) NOT NULL,
	Tipologia VARCHAR(20) NOT NULL CHECK (Tipologia IN ('Notifica', 'Email')),
	Soglia DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (Budget_Utente, Budget_Categoria),
	FOREIGN KEY (Budget_Utente, Budget_Categoria) REFERENCES Budget(Categoria_Utente, Categoria_Nome)
);

CREATE TABLE Transazione (
	ID INT PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	Data DATE NOT NULL,
	Ora TIME NOT NULL,
	Importo DECIMAL(10, 2) NOT NULL,
	Tipologia VARCHAR(20) NOT NULL CHECK (Tipologia IN ('Entrata', 'Uscita', 'Trasferimento')),
	Conto_ID INT NOT NULL,
	Categoria_Utente INT NOT NULL,
	Categoria_Nome VARCHAR(100) NOT NULL,
	FOREIGN KEY (Conto_ID) REFERENCES Conto(ID),
	FOREIGN KEY (Categoria_Utente, Categoria_Nome) REFERENCES Categoria(Utente_ID, Nome)
);

CREATE TABLE Trasferimento (
	Transazione_ID INT PRIMARY KEY,
	Commissione DECIMAL(10, 2) NOT NULL,
	Conto_Destinazione_ID INT NOT NULL,
	FOREIGN KEY (Transazione_ID) REFERENCES Transazione(ID),
	FOREIGN KEY (Conto_Destinazione_ID) REFERENCES Conto(ID)
);

CREATE TABLE Ricorrente (
	Transazione_ID INT PRIMARY KEY,
	Frequenza VARCHAR(20) NOT NULL CHECK (Frequenza IN ('Settimanale', 'Mensile', 'Annuale')),
	Fine_Ricorrenza DATE NOT NULL,
	FOREIGN KEY (Transazione_ID) REFERENCES Transazione(ID)
);

INSERT INTO Utente (ID, Nome, Cognome, Email) VALUES
(1, 'Luca', 'Cesco Bolla', 'luca.cescobolla@studenti.unipd.it'),
(2, 'Marco', 'Rossi', 'marco.rossi@email.com'),
(3, 'Giulia', 'Bianchi', 'giulia.bianchi@email.com'),
(4, 'Elena', 'Verde', 'elena.verde@email.com'),
(5, 'Alessandro', 'Neri', 'alessandro.neri@email.com'),
(6, 'Francesca', 'Gialli', 'francesca.gialli@email.com'),
(7, 'Matteo', 'Viola', 'matteo.viola@email.com'),
(8, 'Sofia', 'Rosa', 'sofia.rosa@email.com'),
(9, 'Davide', 'Bruni', 'davide.bruni@email.com'),
(10, 'Chiara', 'Esposito', 'chiara.esposito@email.com'),
(11, 'Andrea', 'Romano', 'andrea.romano@email.com'),
(12, 'Sara', 'Colombo', 'sara.colombo@email.com'),
(13, 'Federico', 'Ricci', 'federico.ricci@email.com'),
(14, 'Martina', 'Marini', 'martina.marini@email.com'),
(15, 'Gabriele', 'Conti', 'gabriele.conti@email.com');

INSERT INTO Conto (ID, Nome, Saldo, IBAN, Nome_Banca) VALUES
(1, 'Conto Principale Intesa', 3450.50, 'IT60X0542811101000000123456', 'Intesa Sanpaolo'),
(2, 'Carta Ricaricabile Revolut', 420.00, 'LT12345678901234567890', 'Revolut'),
(3, 'Portafoglio Contanti Luca', 115.00, NULL, NULL),
(4, 'Conto Co-intestato Casa', 2200.00, 'IT02L0306909606100000011111', 'Unicredit'),
(5, 'Conto Deposito Fineco', 15000.00, 'IT99C0123456789012345678901', 'Fineco'),
(6, 'Conto Webank Marco', 1850.00, 'IT45W0503411101000000987654', 'Webank'),
(7, 'Carta Prepagata Postepay', 210.00, 'IT88P0760103200000012345678', 'Poste Italiane'),
(8, 'Conto Business Alessandro', 8400.00, 'IT11A0306909606100000099999', 'Banca Sella'),
(9, 'Conto Risparmio Vacanze', 3100.00, 'IT33B0542811101000000555555', 'Mediolanum'),
(10, 'Cassa Contanti Matteo', 60.00, NULL, NULL),
(11, 'Conto Corrente BBVA Giulia', 1250.00, 'IT55Q0306909606100000022222', 'BBVA'),
(12, 'Conto Corrente N26 Elena', 890.00, 'DE12100110012345678901', 'N26'),
(13, 'Conto Credem Francesca', 4300.00, 'IT77K0306909606100000033333', 'Credem'),
(14, 'Carta Wise Davide', 620.00, 'BE99123456789012', 'Wise'),
(15, 'Conto Co-intestato Vacanze', 4500.00, 'IT12M0306909606100000044444', 'BNL');

INSERT INTO Possiede (Utente_ID, Conto_ID, Livello_Accesso) VALUES
(1, 1, 'Amministratore'),
(1, 2, 'Amministratore'),
(1, 3, 'Amministratore'),
(1, 4, 'Amministratore'),
(1, 9, 'Modifica'),
(2, 4, 'Modifica'),
(2, 5, 'Amministratore'),
(2, 6, 'Amministratore'),
(3, 7, 'Amministratore'),
(3, 11, 'Amministratore'),
(3, 15, 'Amministratore'),
(4, 12, 'Amministratore'),
(5, 8, 'Amministratore'),
(6, 13, 'Amministratore'),
(7, 10, 'Amministratore'),
(9, 14, 'Amministratore'),
(9, 15, 'Modifica'),
(10, 1, 'Lettura'),
(11, 6, 'Lettura'),
(12, 12, 'Modifica'),
(13, 8, 'Lettura'),
(14, 13, 'Lettura'),
(15, 5, 'Lettura'),
(4, 4, 'Lettura'),
(8, 7, 'Modifica');

INSERT INTO Categoria (Utente_ID, Nome) VALUES
(1, 'Stipendio'),
(1, 'Spesa Alimentare'),
(1, 'Trasporti'),
(1, 'Svago & Ristoranti'),
(1, 'Giroconto'),
(1, 'Bollette'),
(1, 'Salute'),
(1, 'Abbonamenti'),
(1, 'Tecnologia'),
(2, 'Stipendio'),
(2, 'Bollette'),
(2, 'Spesa Alimentare'),
(2, 'Auto e Carburante'),
(2, 'Giroconto'),
(2, 'Casa e Manutenzione'),
(3, 'Stipendio'),
(3, 'Shopping'),
(3, 'Spesa Alimentare'),
(3, 'Viaggi'),
(3, 'Palestra & Sport'),
(3, 'Giroconto'),
(4, 'Stipendio'),
(4, 'Cura Personale'),
(4, 'Istruzione'),
(4, 'Spesa Alimentare'),
(5, 'Fatturato Clienti'),
(5, 'Tasse e Imposte'),
(5, 'Software & Strumenti'),
(5, 'Spese d Ufficio'),
(6, 'Stipendio'),
(6, 'Tempo Libero'),
(6, 'Spesa Alimentare'),
(9, 'Stipendio'),
(9, 'Viaggi'),
(9, 'Ristoranti');

INSERT INTO Budget (Categoria_Utente, Categoria_Nome, Data_Fine, Target, Frequenza) VALUES
(1, 'Spesa Alimentare', '2026-12-31', 450.00, 'Mensile'),
(1, 'Svago & Ristoranti', '2026-12-31', 250.00, 'Mensile'),
(1, 'Bollette', '2026-12-31', 300.00, 'Mensile'),
(1, 'Abbonamenti', '2026-12-31', 60.00, 'Mensile'),
(1, 'Tecnologia', '2026-12-31', 1000.00, 'Annuale'),
(2, 'Bollette', '2026-12-31', 350.00, 'Mensile'),
(2, 'Auto e Carburante', '2026-12-31', 200.00, 'Mensile'),
(2, 'Spesa Alimentare', '2026-12-31', 400.00, 'Mensile'),
(3, 'Shopping', '2026-12-31', 300.00, 'Mensile'),
(3, 'Viaggi', '2026-12-31', 2000.00, 'Annuale'),
(3, 'Palestra & Sport', '2026-12-31', 80.00, 'Mensile'),
(4, 'Cura Personale', '2026-12-31', 150.00, 'Mensile'),
(4, 'Istruzione', '2026-12-31', 500.00, 'Annuale'),
(5, 'Software & Strumenti', '2026-12-31', 300.00, 'Mensile'),
(6, 'Tempo Libero', '2026-12-31', 200.00, 'Mensile');

INSERT INTO Avviso (Budget_Utente, Budget_Categoria, Tipologia, Soglia) VALUES
(1, 'Spesa Alimentare', 'Email', 80.00),
(1, 'Svago & Ristoranti', 'Notifica', 90.00),
(1, 'Bollette', 'Email', 100.00),
(1, 'Tecnologia', 'Email', 85.00),
(2, 'Bollette', 'Email', 75.00),
(2, 'Auto e Carburante', 'Notifica', 85.00),
(2, 'Spesa Alimentare', 'Notifica', 90.00),
(3, 'Shopping', 'Notifica', 70.00),
(3, 'Viaggi', 'Email', 80.00),
(3, 'Palestra & Sport', 'Notifica', 95.00),
(4, 'Cura Personale', 'Email', 80.00),
(4, 'Istruzione', 'Email', 90.00),
(5, 'Software & Strumenti', 'Email', 90.00),
(6, 'Tempo Libero', 'Notifica', 85.00),
(1, 'Abbonamenti', 'Notifica', 100.00);

INSERT INTO Transazione (ID, Nome, Data, Ora, Importo, Tipologia, Conto_ID, Categoria_Utente, Categoria_Nome) VALUES
(1, 'Stipendio Settembre Luca', '2026-09-01', '08:30:00', 1850.00, 'Entrata', 1, 1, 'Stipendio'),
(2, 'Stipendio Settembre Marco', '2026-09-01', '09:00:00', 2100.00, 'Entrata', 6, 2, 'Stipendio'),
(3, 'Stipendio Settembre Giulia', '2026-09-01', '09:15:00', 1650.00, 'Entrata', 11, 3, 'Stipendio'),
(4, 'Abbonamento Netflix', '2026-09-01', '00:01:00', 17.99, 'Uscita', 2, 1, 'Abbonamenti'),
(5, 'Abbonamento Spotify', '2026-09-01', '02:00:00', 10.99, 'Uscita', 2, 1, 'Abbonamenti'),
(6, 'Spesa Esselunga', '2026-09-02', '18:45:00', 65.40, 'Uscita', 1, 1, 'Spesa Alimentare'),
(7, 'Abbonamento Treno Trenitalia', '2026-09-02', '09:00:00', 45.00, 'Uscita', 2, 1, 'Trasporti'),
(8, 'Bolletta Luce Casa', '2026-09-02', '11:20:00', 120.00, 'Uscita', 4, 2, 'Bollette'),
(9, 'Cena Pizzeria da Totò', '2026-09-03', '21:15:00', 32.50, 'Uscita', 3, 1, 'Svago & Ristoranti'),
(10, 'Ricarica Revolut da Intesa', '2026-09-03', '10:00:00', 150.00, 'Trasferimento', 1, 1, 'Giroconto'),
(11, 'Farmacia e Medicine', '2026-09-04', '16:30:00', 42.10, 'Uscita', 1, 1, 'Salute'),
(12, 'Rifornimento Benzina Eni', '2026-09-04', '08:15:00', 60.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(13, 'Spesa Conad', '2026-09-05', '12:10:00', 88.30, 'Uscita', 1, 1, 'Spesa Alimentare'),
(14, 'Acquisto Maglione Zara', '2026-09-05', '16:00:00', 49.95, 'Uscita', 7, 3, 'Shopping'),
(15, 'Fattura Cliente Alfa Consulting', '2026-09-05', '15:00:00', 1500.00, 'Entrata', 8, 5, 'Fatturato Clienti'),
(16, 'Accantonamento Fondo Risparmio', '2026-09-06', '14:00:00', 300.00, 'Trasferimento', 6, 2, 'Giroconto'),
(17, 'Cena Sushi Fusion', '2026-09-06', '20:30:00', 55.00, 'Uscita', 2, 1, 'Svago & Ristoranti'),
(18, 'Licenza Software Adobe', '2026-09-07', '09:12:00', 65.99, 'Uscita', 8, 5, 'Software & Strumenti'),
(19, 'Prenotazione Volo Ryanair', '2026-09-07', '10:30:00', 140.00, 'Uscita', 15, 3, 'Viaggi'),
(20, 'Pranzo di Lavoro', '2026-09-08', '13:20:00', 22.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(21, 'Bolletta Gas Metano', '2026-09-08', '10:00:00', 85.50, 'Uscita', 1, 1, 'Bollette'),
(22, 'Ricarica Telefonica Iliad', '2026-09-09', '18:00:00', 9.99, 'Uscita', 2, 1, 'Abbonamenti'),
(23, 'Spesa Supermercato Lidl', '2026-09-09', '19:30:00', 54.20, 'Uscita', 4, 2, 'Spesa Alimentare'),
(24, 'Bolletta Internet Fibra', '2026-09-10', '08:00:00', 29.90, 'Uscita', 4, 2, 'Bollette'),
(25, 'Abbonamento Palestra Mensile', '2026-09-10', '16:00:00', 60.00, 'Uscita', 11, 3, 'Palestra & Sport'),
(26, 'Trasferimento su Fondo Vacanze', '2026-09-11', '11:00:00', 200.00, 'Trasferimento', 1, 1, 'Giroconto'),
(27, 'Fattura Cliente Beta Srl', '2026-09-11', '11:45:00', 2200.00, 'Entrata', 8, 5, 'Fatturato Clienti'),
(28, 'Cena Ristorante Gourmet', '2026-09-12', '21:00:00', 110.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(29, 'Spesa Coop', '2026-09-12', '11:15:00', 73.80, 'Uscita', 11, 3, 'Spesa Alimentare'),
(30, 'Manutenzione Caldaia Casa', '2026-09-13', '15:30:00', 110.00, 'Uscita', 4, 2, 'Casa e Manutenzione'),
(31, 'Acquisto Smartphone Amazon', '2026-09-13', '22:10:00', 699.00, 'Uscita', 1, 1, 'Tecnologia'),
(32, 'Detersivi e Pulizia Casa', '2026-09-14', '17:00:00', 24.50, 'Uscita', 1, 1, 'Spesa Alimentare'),
(33, 'Rifornimento Q8', '2026-09-14', '07:45:00', 50.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(34, 'Parrucchiere Salon', '2026-09-15', '14:30:00', 45.00, 'Uscita', 12, 4, 'Cura Personale'),
(35, 'Tasse e Inps Terzo Trimestre', '2026-09-16', '09:00:00', 850.00, 'Uscita', 8, 5, 'Tasse e Imposte'),
(36, 'Spesa Biologica Naturasì', '2026-09-16', '18:10:00', 41.20, 'Uscita', 1, 1, 'Spesa Alimentare'),
(37, 'Aperitivo Colleghi Work', '2026-09-17', '19:00:00', 18.00, 'Uscita', 2, 1, 'Svago & Ristoranti'),
(38, 'Biglietto Cinema 3D', '2026-09-17', '21:30:00', 12.50, 'Uscita', 13, 6, 'Tempo Libero'),
(39, 'Spesa Pam', '2026-09-18', '12:45:00', 62.10, 'Uscita', 13, 6, 'Spesa Alimentare'),
(40, 'Ricarica Postepay da BBVA', '2026-09-18', '16:20:00', 100.00, 'Trasferimento', 11, 3, 'Giroconto'),
(41, 'Acquisto Scarpe Nike', '2026-09-19', '15:15:00', 119.90, 'Uscita', 7, 3, 'Shopping'),
(42, 'Rifornimento IP', '2026-09-19', '18:30:00', 40.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(43, 'Cena Messicana', '2026-09-20', '20:45:00', 48.00, 'Uscita', 14, 9, 'Ristoranti'),
(44, 'Spesa Esselunga', '2026-09-21', '19:10:00', 92.40, 'Uscita', 1, 1, 'Spesa Alimentare'),
(45, 'Taxi Stazione-Casa', '2026-09-21', '22:00:00', 21.50, 'Uscita', 2, 1, 'Trasporti'),
(46, 'Acquisto Libri Università', '2026-09-22', '10:00:00', 135.00, 'Uscita', 12, 4, 'Istruzione'),
(47, 'Servizio Cloud Server AWS', '2026-09-22', '03:00:00', 45.20, 'Uscita', 8, 5, 'Software & Strumenti'),
(48, 'Fattura Cliente Gamma', '2026-09-23', '14:15:00', 980.00, 'Entrata', 8, 5, 'Fatturato Clienti'),
(49, 'Visita Dentistica Controllo', '2026-09-23', '16:00:00', 100.00, 'Uscita', 1, 1, 'Salute'),
(50, 'Ricarica Revolut da Intesa', '2026-09-24', '11:30:00', 100.00, 'Trasferimento', 1, 1, 'Giroconto'),
(51, 'Spesa Eurospin', '2026-09-24', '18:00:00', 48.90, 'Uscita', 4, 2, 'Spesa Alimentare'),
(52, 'Caffè e Pasticceria', '2026-09-25', '08:00:00', 6.50, 'Uscita', 3, 1, 'Svago & Ristoranti'),
(53, 'Cena Trattoria Tipica', '2026-09-25', '21:00:00', 65.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(54, 'Spesa Carrefour', '2026-09-26', '11:30:00', 79.30, 'Uscita', 1, 1, 'Spesa Alimentare'),
(55, 'Hotel Soggiorno Weekend', '2026-09-26', '14:00:00', 220.00, 'Uscita', 15, 3, 'Viaggi'),
(56, 'Consumazione Bar Spiaggia', '2026-09-27', '17:00:00', 15.00, 'Uscita', 14, 9, 'Ristoranti'),
(57, 'Pedaggio Autostrade', '2026-09-27', '19:30:00', 18.40, 'Uscita', 6, 2, 'Auto e Carburante'),
(58, 'Spesa Conad', '2026-09-28', '18:50:00', 51.00, 'Uscita', 11, 3, 'Spesa Alimentare'),
(59, 'Materiale Cancelleria Ufficio', '2026-09-28', '10:30:00', 34.00, 'Uscita', 8, 5, 'Spese d Ufficio'),
(60, 'Giroconto Risparmio Mensile', '2026-09-29', '09:00:00', 400.00, 'Trasferimento', 1, 1, 'Giroconto'),
(61, 'Spesa Esselunga', '2026-09-29', '19:00:00', 83.20, 'Uscita', 1, 1, 'Spesa Alimentare'),
(62, 'Pizzeria d Asporto', '2026-09-30', '20:15:00', 24.00, 'Uscita', 2, 1, 'Svago & Ristoranti'),
(63, 'Stipendio Agosto Luca', '2026-08-01', '08:30:00', 1850.00, 'Entrata', 1, 1, 'Stipendio'),
(64, 'Stipendio Agosto Marco', '2026-08-01', '09:00:00', 2100.00, 'Entrata', 6, 2, 'Stipendio'),
(65, 'Abbonamento Netflix', '2026-08-01', '00:01:00', 17.99, 'Uscita', 2, 1, 'Abbonamenti'),
(66, 'Spesa Esselunga', '2026-08-03', '18:00:00', 95.10, 'Uscita', 1, 1, 'Spesa Alimentare'),
(67, 'Rifornimento Eni', '2026-08-04', '08:00:00', 55.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(68, 'Cena Ristorante Mare', '2026-08-06', '21:30:00', 85.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(69, 'Bolletta Luce Casa', '2026-08-07', '11:00:00', 135.00, 'Uscita', 4, 2, 'Bollette'),
(70, 'Spesa Coop', '2026-08-10', '10:30:00', 64.00, 'Uscita', 1, 1, 'Spesa Alimentare'),
(71, 'Ricarica Revolut da Intesa', '2026-08-11', '12:00:00', 200.00, 'Trasferimento', 1, 1, 'Giroconto'),
(72, 'Acquisto Costume da Bagno', '2026-08-12', '16:00:00', 35.00, 'Uscita', 7, 3, 'Shopping'),
(73, 'Spesa Supermercato Conad', '2026-08-14', '17:30:00', 110.00, 'Uscita', 4, 2, 'Spesa Alimentare'),
(74, 'Pranzo Ferragosto', '2026-08-15', '13:30:00', 140.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(75, 'Rifornimento Q8', '2026-08-18', '09:15:00', 50.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(76, 'Spesa Esselunga', '2026-08-20', '19:00:00', 78.40, 'Uscita', 1, 1, 'Spesa Alimentare'),
(77, 'Bolletta Gas Metano', '2026-08-22', '09:00:00', 45.00, 'Uscita', 1, 1, 'Bollette'),
(78, 'Cena Pizzeria', '2026-08-25', '20:30:00', 30.00, 'Uscita', 3, 1, 'Svago & Ristoranti'),
(79, 'Spesa Lidl', '2026-08-28', '18:15:00', 58.90, 'Uscita', 1, 1, 'Spesa Alimentare'),
(80, 'Giroconto Risparmio Mensile', '2026-08-29', '10:00:00', 400.00, 'Trasferimento', 1, 1, 'Giroconto'),
(81, 'Stipendio Luglio Luca', '2026-07-01', '08:30:00', 1850.00, 'Entrata', 1, 1, 'Stipendio'),
(82, 'Stipendio Luglio Marco', '2026-07-01', '09:00:00', 2100.00, 'Entrata', 6, 2, 'Stipendio'),
(83, 'Abbonamento Netflix', '2026-07-01', '00:01:00', 17.99, 'Uscita', 2, 1, 'Abbonamenti'),
(84, 'Spesa Esselunga', '2026-07-04', '18:30:00', 82.30, 'Uscita', 1, 1, 'Spesa Alimentare'),
(85, 'Rifornimento IP', '2026-07-05', '08:30:00', 60.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(86, 'Cena Messicana', '2026-07-08', '21:00:00', 42.00, 'Uscita', 2, 1, 'Svago & Ristoranti'),
(87, 'Bolletta Luce Casa', '2026-07-10', '10:00:00', 115.00, 'Uscita', 4, 2, 'Bollette'),
(88, 'Acquisto Valigia Samsonite', '2026-07-12', '15:00:00', 129.00, 'Uscita', 7, 3, 'Shopping'),
(89, 'Spesa Conad', '2026-07-15', '19:00:00', 71.50, 'Uscita', 1, 1, 'Spesa Alimentare'),
(90, 'Ricarica Revolut da Intesa', '2026-07-16', '11:00:00', 150.00, 'Trasferimento', 1, 1, 'Giroconto'),
(91, 'Tagliando Auto Officina', '2026-07-18', '09:30:00', 240.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(92, 'Cena Ristorante Indiano', '2026-07-20', '20:45:00', 38.00, 'Uscita', 1, 1, 'Svago & Ristoranti'),
(93, 'Spesa Coop', '2026-07-22', '18:00:00', 66.80, 'Uscita', 11, 3, 'Spesa Alimentare'),
(94, 'Fattura Cliente Delta', '2026-07-24', '16:00:00', 1800.00, 'Entrata', 8, 5, 'Fatturato Clienti'),
(95, 'Rifornimento Eni', '2026-07-25', '08:00:00', 50.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(96, 'Spesa Esselunga', '2026-07-27', '19:15:00', 91.00, 'Uscita', 1, 1, 'Spesa Alimentare'),
(97, 'Bolletta Gas Metano', '2026-07-28', '09:00:00', 40.00, 'Uscita', 1, 1, 'Bollette'),
(98, 'Cena Pub Birreria', '2026-07-29', '22:00:00', 28.00, 'Uscita', 2, 1, 'Svago & Ristoranti'),
(99, 'Giroconto Risparmio Mensile', '2026-07-30', '10:00:00', 400.00, 'Trasferimento', 1, 1, 'Giroconto'),
(100, 'Acquisto Console Videogiochi', '2026-07-31', '17:40:00', 499.00, 'Uscita', 1, 1, 'Tecnologia'),
(101, 'Stipendio Dicembre 2024 Luca', '2024-12-23', '08:30:00', 1800.00, 'Entrata', 1, 1, 'Stipendio'),
(102, 'Regalo di Natale Laptop', '2024-12-24', '15:45:00', 1199.00, 'Uscita', 1, 1, 'Tecnologia'),
(103, 'Spesa di Natale Esselunga', '2024-12-24', '11:20:00', 145.50, 'Uscita', 1, 1, 'Spesa Alimentare'),
(104, 'Assicurazione Auto Annuale', '2025-01-15', '10:00:00', 520.00, 'Uscita', 6, 2, 'Auto e Carburante'),
(105, 'Vacanze Estive Barcellona', '2025-08-10', '14:30:00', 850.00, 'Uscita', 15, 3, 'Viaggi'),
(106, 'Tagliando Caldaia 2025', '2025-02-18', '09:15:00', 120.00, 'Uscita', 4, 2, 'Casa e Manutenzione'),
(107, 'Fatturato Progetto Speciale', '2025-05-10', '16:00:00', 3500.00, 'Entrata', 8, 5, 'Fatturato Clienti'),
(108, 'Abbonamento Annuale Palestra', '2025-09-01', '17:00:00', 550.00, 'Uscita', 11, 3, 'Palestra & Sport'),
(109, 'Giroconto Risparmi 2025', '2025-06-30', '12:00:00', 1000.00, 'Trasferimento', 1, 1, 'Giroconto'),
(110, 'Bolletta Straordinaria Conguaglio', '2025-11-12', '11:00:00', 280.00, 'Uscita', 4, 2, 'Bollette');

INSERT INTO Trasferimento (Transazione_ID, Commissione, Conto_Destinazione_ID) VALUES
(10, 1.00, 2),
(16, 0.00, 5),
(26, 0.00, 9),
(40, 0.50, 7),
(50, 1.00, 2),
(60, 0.00, 5),
(71, 1.00, 2),
(80, 0.00, 5),
(90, 1.00, 2),
(99, 0.00, 5),
(109, 0.00, 5);

INSERT INTO Ricorrente (Transazione_ID, Frequenza, Fine_Ricorrenza) VALUES
(1, 'Mensile', '2027-12-31'),
(2, 'Mensile', '2027-12-31'),
(3, 'Settimanale', '2027-12-31'),
(4, 'Mensile', '2026-12-31'),
(5, 'Annuale', '2026-12-31'),
(8, 'Mensile', '2027-12-31'),
(18, 'Annuale', '2026-12-31'),
(21, 'Settimanale', '2027-12-31'),
(22, 'Mensile', '2026-12-31'),
(24, 'Mensile', '2027-12-31'),
(25, 'Annuale', '2026-12-31'),
(63, 'Annuale', '2027-12-31'),
(64, 'Mensile', '2027-12-31'),
(65, 'Mensile', '2026-12-31'),
(81, 'Mensile', '2027-12-31'),
(104, 'Annuale', '2028-12-31'),
(108, 'Annuale', '2027-12-31');

-- QUERY 1: Trovare quanto è stato speso in totale nel 2026 in bollette da parte dell'utente 2
SELECT U.Nome, U.Cognome, SUM(T.Importo) AS Totale_Speso
FROM Transazione T
JOIN Utente U ON T.Categoria_Utente = U.ID
WHERE T.Tipologia='Uscita'
AND T.Categoria_Utente = 2
AND T.Categoria_Nome='Bollette'
AND EXTRACT(YEAR FROM T.Data) = 2026
GROUP BY U.Nome, U.Cognome;

-- QUERY 2: Calcolare il patrimonio totale per utente (consideriamo proprietà dell'utente i conti in cui ha livello di accesso almeno modifica)
SELECT U.ID, U.Nome, U.Cognome, SUM(C.Saldo) AS Patrimonio_Totale
FROM Utente U
JOIN Possiede P ON U.ID = P.Utente_ID
JOIN Conto C ON P.Conto_ID = C.ID
WHERE P.Livello_Accesso<>'Lettura'
GROUP BY U.ID, U.Nome, U.Cognome
ORDER BY Patrimonio_Totale DESC;

-- QUERY 3: Elencare tutte le uscite ricorrenti, con la relativa frequenza, per ogni utente
SELECT T.Categoria_Utente AS id_utente, U.Nome, U.Cognome, T.Nome AS nome_transazione, T.Importo, R.Frequenza
FROM Transazione T
JOIN Ricorrente R ON T.ID = R.Transazione_ID
JOIN Utente U on T.Categoria_Utente = U.ID
WHERE T.Tipologia = 'Uscita'
ORDER BY T.Categoria_Utente ASC;

-- QUERY 4: Elencare i conti co-intestati e il loro bilancio
SELECT C.ID AS id_conto, C.Saldo, COUNT(P.Utente_ID) AS Numero_Cointestatari
FROM Conto C
JOIN Possiede P ON C.ID = P.Conto_ID
GROUP BY C.ID, C.Saldo
HAVING COUNT(P.Utente_ID) > 1
ORDER BY C.Saldo DESC;

-- QUERY 5: Elencare le categorie per cui un utente ha superato il budget mensile fissato a settembre 2026
SELECT B.Categoria_Utente AS id_utente,
B.Categoria_Nome AS Categoria,
B.Target AS Budget_Impostato,
SUM(T.Importo) AS Spesa_Totale
FROM Budget B
JOIN Transazione T ON B.Categoria_Utente = T.Categoria_Utente AND B.Categoria_Nome = T.Categoria_Nome
WHERE T.Tipologia = 'Uscita'
AND B.Frequenza = 'Mensile' 
AND EXTRACT(YEAR FROM T.Data) = 2026 AND EXTRACT(MONTH FROM T.Data) = 9
GROUP BY B.Categoria_Utente, B.Categoria_Nome, B.Target
HAVING SUM(T.Importo) > B.Target;

-- INDICE PER QUERY 3
CREATE INDEX idx_transazione_tipologia_id ON Transazione(Tipologia, Categoria_Utente);