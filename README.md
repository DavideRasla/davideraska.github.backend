# Photo Event Backend

Questa applicazione è il backend per la gestione di eventi fotografici, dove i partecipanti possono caricare e presentare le proprie foto.

## Requisiti
- Java 17+
- Maven
- Docker (per l’esecuzione in container)
- Oracle Database (configurare l’URL di connessione in `application.properties`)

## Configurazione
1. Assicurati di configurare `application.properties` con le corrette credenziali per il tuo database Oracle.
2. Crea un file `application.properties` nella directory `src/main/resources`:
   ```properties
   spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
   spring.datasource.username=TUO_USERNAME
   spring.datasource.password=LA_TUA_PASSWORD
