from sys import exit
import psycopg2
from psycopg2 import Error, Warning
from psycopg2 import OperationalError


class postgresIface():
	database = 'logging'
	user = 'postgres'
	password = 'abcd1234'
	host = 'localhost'
	port = 5432

	def __init__(self):
		self.database = ''
		self.user = ''
		self.password = ''
		self.host = ''
		self.port = 0

	def cfg(self, pdatabase : str, puser : str, ppassword : str, phost : str, pport : int):
		self.database = pdatabase
		self.user = puser
		self.password = ppassword
		self.host = phost
		self.port = pport

	def selectFetchAll(self, query: str) -> [bool, str, [], int]:
		cursor = self.connection.cursor()
		result = []

		try:
			cursor.execute(query)
			result = cursor.fetchall()
		except Warning as e:
			cursor.close()
			return [False, f"Warning '{e}' occurred. SelectFetchAll.", [], 0]
		except Error as e:
			cursor.close()
			return [False, f"POSTGRES ERROR SelectFetchAll: {e}\nMore error info:{e.pgerror}\nPostgres erro code: [{e.pgcode}]\n", [], 0]

		rowcount = cursor.rowcount

		cursor.close()

		return [True, 'Ok', result, rowcount]

	def disconnect(self) -> [bool, str]:
		try:
			self.connection.close()
		except Warning as e:
			return [False, f"The error '{e}' occurred. Close connection."]
		except Error as e:
			return [False, f"POSTGRES ERROR close connection: {e}\nMore error info:{e.pgerror}\nPostgres erro code: [{e.pgcode}]"]

		return [True, 'Ok']

	def connect(self, autoCommit : bool) -> [bool, str]:
		try:
			self.connection = psycopg2.connect(database = self.database, user = self.user,
			                                   password = self.password, host = self.host,
			                                   port = self.port)
		except Warning as e:
			return [False, f"The error '{e}' occurred. Connect."]
		except Error as e:
			return [False, f"POSTGRES ERROR connect: {e}\nMore error info:{e.pgerror}\nPostgres erro code: [{e.pgcode}]"]

		self.connection.autocommit = autoCommit;

		return [True, 'Ok']

	def commit(self) -> None:
		self.connection.commit()

	def rollback(self) -> None:
		self.connection.rollback()

	def execInsertDeleteUpdate(conn : psycopg2.connect, query: str) -> bool:
		 try:
			  cursor = conn.cursor()
			  cursor.execute(query)
		 except Warning as e:
			 cursor.close()
			 return [False, f"Warning '{e}' occurred. SelectFetchAll.", [], 0]
		 except Error as e:
			 cursor.close()
			 return [False, f"POSTGRES ERROR SelectFetchAll: {e}\nMore error info:{e.pgerror}\nPostgres erro code: [{e.pgcode}]\n", [], 0]

		 cursor.close()
		 return True