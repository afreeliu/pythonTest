from db import db


result = db.fetch_one("select * from Course")
print(result)

result = db.fetch_one("select * from Course where c_id = %(c_id)", c_id=3)
print(result)
