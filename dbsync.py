#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Andre Augusto Giannotti Scota (https://sites.google.com/view/a2gs/)

from sys import exit
import postgresIface
import pprint

dbHandle = postgresIface.postgresIface()

dbHandle.cfg('postgres', 'postgres', 'abcd1234', 'localhost', 5432)

def getActiveTasks() -> [bool, str, [], int]:
	ret, retMsg, getActiveTasks, totalActiveTasks = dbHandle.selectFetchAll('select tk.id, tk.taskorder, ts.description, cm.query, cf.type, cf.config, cf.description ' 
	                                                                        'from dbsync.tasks tk, dbsync.taskstatus ts, dbsync.cmd cm, dbsync.config cf '
	                                                                        'where tk.status = 1 AND '
	                                                                        'tk.status = ts.status AND '
	                                                                        'cm.id = tk.id AND '
	                                                                        'cm.idCfg = cf.id '
	                                                                        'order by (tk.taskorder)')
	if ret == False:
		return[False, f'DB Error: [{retMsg}]', [], 0]

	return [True, 'Ok', getActiveTasks, totalActiveTasks]


if __name__ == '__main__':

	ret, retMsg = dbHandle.connect(False)
	if ret == False:
		print(f'DB Connect error: [{retMsg}]')
		exit(-1)

	ret, retMsg, getActiveTasks, totalActiveTasks = getActiveTasks()
	if ret == False:
		print(f'getActiveTasks Error: [{retMsg}]')
		exit(-1)

	pp = pprint.PrettyPrinter(indent=2, compact=False, depth=None)

	print(f'Total tasks: [{totalActiveTasks}]')
	pp.pprint(getActiveTasks)

	exit(0)