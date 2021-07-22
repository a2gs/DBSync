-- Andre Augusto Giannotti Scota (https://sites.google.com/view/a2gs/)

SET search_path TO DBSYNC;

INSERT INTO taskStatus (status, description) VALUES (1, 'Active');
INSERT INTO taskStatus (status, description) VALUES (2, 'Executed OK');
INSERT INTO taskStatus (status, description) VALUES (3, 'Executed ERROR');
INSERT INTO taskStatus (status, description) VALUES (4, 'Underconstruction');

INSERT INTO dbType (type, description) VALUES (1, 'Postgres');
INSERT INTO dbType (type, description) VALUES (2, 'MySQL');
INSERT INTO dbType (type, description) VALUES (3, 'Oracle');
INSERT INTO dbType (type, description) VALUES (4, 'Informix');

INSERT INTO tasks (description, status, taskOrder) VALUES ('test task 1', 1, 10);
INSERT INTO tasks (description, status, taskOrder) VALUES ('test task 2', 1, 11);
INSERT INTO tasks (description, status, taskOrder) VALUES ('test task 10', 3, 8);
INSERT INTO tasks (description, status, taskOrder) VALUES ('test task 111', 2, 2);

INSERT INTO config(id, type, config, description) VALUES (1, 1, 'user|passwd|host', 'Production');
INSERT INTO config(id, type, config, description) VALUES (2, 1, 'user|passwd|host', 'QA 1');
INSERT INTO config(id, type, config, description) VALUES (3, 3, 'user|passwd|host', 'DEV');
INSERT INTO config(id, type, config, description) VALUES (4, 4, 'user|passwd|host', 'QA 2');

INSERT INTO cmd (id, idcfg, query, rowsaffected, dtexecuted, retcode, retmsg) VALUES (1, 1, 'select * from dual', 0, NULL, NULL, NULL);
INSERT INTO cmd (id, idcfg, query, rowsaffected, dtexecuted, retcode, retmsg) VALUES (1, 2, 'select * from dual', 0, NULL, NULL, NULL);
INSERT INTO cmd (id, idcfg, query, rowsaffected, dtexecuted, retcode, retmsg) VALUES (1, 3, 'select * from dual', 0, NULL, NULL, NULL);