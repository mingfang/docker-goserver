ALTER TABLE modifications
DROP CONSTRAINT FK_MODIFICATIONS_PIPELINEID_PIPELINE_ID;

ALTER TABLE modifications
DROP COLUMN pipelineId;

--//@UNDO



