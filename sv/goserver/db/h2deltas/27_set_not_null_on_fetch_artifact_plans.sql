ALTER TABLE fetchArtifactPlans ALTER COLUMN jobId SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN pipelineLabel SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN pipeline SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN stage SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN job SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN path SET NOT NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN dest SET NOT NULL;

--//@UNDO
ALTER TABLE fetchArtifactPlans ALTER COLUMN jobId SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN pipelineLabel SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN pipeline SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN stage SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN job SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN path SET NULL;
ALTER TABLE fetchArtifactPlans ALTER COLUMN dest SET NULL;
