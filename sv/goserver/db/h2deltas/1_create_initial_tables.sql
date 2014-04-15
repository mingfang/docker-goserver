CREATE TABLE pipelines (
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
    name            VARCHAR(255),
    buildCauseType  VARCHAR(255),
    buildCauseBy    VARCHAR(255)
);

CREATE TABLE stages (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
name VARCHAR(255),
approvedBy VARCHAR(255),
pipelineId BIGINT
);

ALTER TABLE stages ADD CONSTRAINT fk_stages_pipelines FOREIGN KEY (pipelineId) REFERENCES pipelines(id) ON DELETE CASCADE;

CREATE TABLE materials (
id INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
type VARCHAR(255),
pipelineId BIGINT,
url  VARCHAR(255),
username VARCHAR(255),
password VARCHAR(255)
);

ALTER TABLE materials ADD CONSTRAINT fk_materials_pipelines FOREIGN KEY (pipelineId) REFERENCES pipelines(id) ON DELETE CASCADE;

CREATE TABLE builds (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
name VARCHAR(255),
state VARCHAR(50),
result VARCHAR(50),
agentUuid VARCHAR(50),
scheduledDate TIMESTAMP,
stageId BIGINT,
matcher VARCHAR(4000),
buildEvent LONGVARCHAR
);

ALTER TABLE builds ADD CONSTRAINT fk_builds_stages FOREIGN KEY (stageId) REFERENCES stages(id) ON DELETE CASCADE;

CREATE TABLE properties (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
buildId BIGINT,
key VARCHAR(255),
value VARCHAR(255),
UNIQUE (buildId, key)
);

ALTER TABLE properties ADD CONSTRAINT fk_properties_builds FOREIGN KEY (buildId) REFERENCES builds(id) ON DELETE CASCADE;

CREATE TABLE artifactPlans (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
buildId BIGINT,
src VARCHAR(255),
dest VARCHAR(255),
artifactType VARCHAR(255)
);

ALTER TABLE artifactplans ADD CONSTRAINT fk_artifactplans_builds FOREIGN KEY (buildId) REFERENCES builds(id) ON DELETE CASCADE;

CREATE TABLE resources (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
name VARCHAR(255),
buildId BIGINT Not NULL
);

ALTER TABLE resources ADD CONSTRAINT fk_resources_builds FOREIGN KEY (buildId) REFERENCES builds(id) ON DELETE CASCADE;

CREATE TABLE modifications (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
type VARCHAR(255),
username  VARCHAR(255),
comment LONGVARCHAR,
emailaddress  VARCHAR(255),
revision VARCHAR(50),
modifiedTime TIMESTAMP,
pipelineId BIGINT Not NULL
);

ALTER TABLE modifications ADD CONSTRAINT fk_modifications_pipelineId_pipeline_id FOREIGN KEY (pipelineId) REFERENCES pipelines(id) ON DELETE CASCADE;

CREATE TABLE modifiedFiles (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
fileName VARCHAR(255),
revision VARCHAR(50),
folderName  VARCHAR(512),
action VARCHAR(50),
modificationId BIGINT Not NULL
);

ALTER TABLE modifiedFiles ADD CONSTRAINT fk_modifiedFiles_modifications FOREIGN KEY (modificationId) REFERENCES modifications(id) ON DELETE CASCADE;

CREATE TABLE buildStateTransitions (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
currentState VARCHAR(255) NOT NULL,
stateChangeTime TIMESTAMP NOT NULL,
buildId BIGINT Not NULL
);

ALTER TABLE buildstatetransitions ADD CONSTRAINT fk_buildstatetransitions_builds FOREIGN KEY (buildId) REFERENCES builds(id) ON DELETE CASCADE;



--//@UNDO

DROP TABLE buildStateTransitions IF EXISTS CASCADE;
DROP TABLE modifiedFiles IF EXISTS CASCADE;
DROP TABLE modifications IF EXISTS CASCADE;
DROP TABLE resources IF EXISTS CASCADE;
DROP TABLE artifactPlans IF EXISTS CASCADE;
DROP TABLE properties IF EXISTS CASCADE;
DROP TABLE builds IF EXISTS CASCADE;
DROP TABLE materials IF EXISTS CASCADE;
DROP TABLE stages IF EXISTS CASCADE;
DROP TABLE pipelines IF EXISTS CASCADE;