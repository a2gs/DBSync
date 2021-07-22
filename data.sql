SET search_path TO DBSYNC;

INSERT INTO DBSYNC.taskStatus (status, description) VALUES (1, 'Active');
INSERT INTO DBSYNC.taskStatus (status, description) VALUES (2, 'Executed OK');
INSERT INTO DBSYNC.taskStatus (status, description) VALUES (3, 'Executed ERROR');
INSERT INTO DBSYNC.taskStatus (status, description) VALUES (4, 'Underconstruction');

INSERT INTO DBSYNC.dbType (type, description) VALUES (1, 'Postgres');
INSERT INTO DBSYNC.dbType (type, description) VALUES (2, 'MySQL');
INSERT INTO DBSYNC.dbType (type, description) VALUES (3, 'Oracle');
INSERT INTO DBSYNC.dbType (type, description) VALUES (4, 'Informix');

INSERT INTO DBSYNC.tasks (description, status, taskOrder) VALUES ('test task 1', 1, 10);
INSERT INTO DBSYNC.tasks (description, status, taskOrder) VALUES ('test task 2', 1, 11);
INSERT INTO DBSYNC.tasks (description, status, taskOrder) VALUES ('test task 10', 3, 8);
INSERT INTO DBSYNC.tasks (description, status, taskOrder) VALUES ('test task 111', 2, 2);