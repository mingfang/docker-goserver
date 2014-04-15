CREATE TABLE artifactPropertiesGenerator (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
jobId BIGINT,
name VARCHAR(255),
src VARCHAR(512),
xpath VARCHAR(512),
regex VARCHAR(512),
generatorType VARCHAR(255),
UNIQUE (jobId, name)
);

ALTER TABLE artifactPropertiesGenerator ADD CONSTRAINT fk_artifactPropertiesGenerator_jobs FOREIGN KEY (jobId) REFERENCES builds(id) ON DELETE CASCADE;