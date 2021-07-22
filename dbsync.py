#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Andre Augusto Giannotti Scota (https://sites.google.com/view/a2gs/)

from sys import exit
import postgresIface

dbHandle = postgresIface.postgresIface()

dbHandle.cfg('postgres', 'postgres', 'abcd1234', 'localhost', 5432)

ret, retMsg = dbHandle.connect(False)
if ret == False:
	print(f'DB Error: [{retMsg}]')
	exit(0)

ret, retMsg, getActiveTasks, totalActiveTasks = dbHandle.selectFetchAll('select tk.id, tk.taskorder, ts.description '
                                                                        'from dbsync.tasks tk, dbsync.taskstatus ts '
                                                                        'where tk.status = 1 AND '
                                                                        'tk.status = ts.status '
                                                                        'order by (tk.taskorder)')
if ret == False:
	print(f'DB Error: [{retMsg}]')
	exit(0)

print(f'Total tasks: [{totalActiveTasks}]')
print(f'Tasks: [{getActiveTasks}]')