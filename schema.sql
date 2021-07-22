CREATE SCHEMA DBSYNC;
SET search_path TO DBSYNC;

-- ------------------------------------

CREATE TABLE IF NOT EXISTS
DBSYNC.taskStatus(
    status INT NOT NULL,
    description TEXT NOT NULL,

	PRIMARY KEY (status)
);

-- ------------------------------------

CREATE TABLE IF NOT EXISTS
DBSYNC.dbType(
    type INT NOT NULL,
    description TEXT NOT NULL,

	PRIMARY KEY (type)
);

-- ------------------------------------

CREATE SEQUENCE task_id_seq;

CREATE TABLE IF NOT EXISTS
DBSYNC.tasks(
    id bigint not null DEFAULT nextval('task_id_seq'::regclass),
    dtCreated TIMESTAMP NOT NULL,
    status INT NOT NULL,
    description TEXT,
    taskOrder INT NOT NULL,

    PRIMARY KEY (id),
    CONSTRAINT fk_status FOREIGN KEY (status) REFERENCES DBSYNC.taskStatus (status)
);

CREATE OR REPLACE FUNCTION DBSYNC.tasksDtCreated()
RETURNS trigger AS
$tasksDtCreatedPLPG$
BEGIN
    NEW.dtCreated = now();
    RETURN NEW;
END;
$tasksDtCreatedPLPG$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trgTasksDtCreated
BEFORE INSERT ON DBSYNC.tasks
FOR EACH ROW EXECUTE PROCEDURE DBSYNC.tasksDtCreated();

-- ------------------------------------

CREATE TABLE IF NOT EXISTS
DBSYNC.config(
    id INT,
    type INT NOT NULL,

    PRIMARY KEY (id),
    CONSTRAINT fk_status FOREIGN KEY (type) REFERENCES DBSYNC.dbType (type)
);

-- ------------------------------------

CREATE TABLE IF NOT EXISTS
DBSYNC.cmd(
    id BIGSERIAL,
    idCfg INT,
    query TEXT,
    rowsAffected INT,
    dtExecuted TIMESTAMP NOT NULL,
    retCode INT,
    retMsg TEXT,

    CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES DBSYNC.tasks (id),
    CONSTRAINT fk_idCfg FOREIGN KEY (idCfg) REFERENCES DBSYNC.config (id)
);