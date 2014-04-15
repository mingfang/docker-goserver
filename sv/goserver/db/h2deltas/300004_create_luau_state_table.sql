CREATE TABLE luauState (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
clientKey  VARCHAR(255),
authState  VARCHAR(255),
authStateExplanation  VARCHAR(255),
lastClientDigest VARCHAR(255),
lastSyncStatus VARCHAR(255),
submittedAt  TIMESTAMP,
lastSyncAt  TIMESTAMP,
markForDeletion BOOLEAN DEFAULT FALSE,
);

--//@UNDO
DROP TABLE luauState;