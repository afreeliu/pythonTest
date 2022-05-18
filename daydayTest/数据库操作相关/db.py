
from dbutils.pooled_db import PooledDB
import pymysql




class DBHelper(object):
    def __init__(self):
        self.pool = PooledDB(
            creator=pymysql,
            maxconnections=5,
            mincached=2,
            maxcached=3,
            blocking=True,#连接池中如果没有可用的连接后，是否阻塞True：阻塞，False：报错
            setsession=[],#开始会话时候执行的命令列表
            ping=0,#ping mysql服务器，检查是否服务可用
            host='127.0.0.1',
            port=3306,
            user='root',
            password='Liu@Fei4ever',
            database='mysql',
            charset='utf8'
        )

    def get_conn_cursor(self):
        conn = self.pool.connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        return conn, cursor

    def close_conn_cursor(self, *args):
        for item in args:
            item.close()

    def exec(self, sql, **kwargs):
        conn, cursor = self.get_conn_cursor()
        cursor.execute(sql, **kwargs)
        conn.commit()
        self.close_conn_cursor(conn, cursor)

    def fetch_one(self, sql, **kwargs):
        conn, cursor = self.get_conn_cursor()
        cursor.execute(sql, **kwargs)
        result = cursor.fetchone()
        self.close_conn_cursor(conn, cursor)
        return result

    def fetch_all(self, sql, **kwargs):
        conn, cursor = self.get_conn_cursor()
        cursor.execute(sql, **kwargs)
        result = cursor.fetchall()
        self.close_conn_cursor(conn, cursor)
        return result


db=DBHelper()