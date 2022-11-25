

from faker import Faker
import xlwt
import os


if __name__ == '__main__':
    fake = Faker('zh_CN')
    # for _ in range(100):
    #     print(fake.name())
    #
    # for _ in range(100):
    #     print(fake.address())

    try:

        data_book = xlwt.Workbook(encoding='utf-8')
        sheet = data_book.add_sheet('用户信息')
        sheet.write(0, 0, '姓名')
        sheet.write(0, 1, '地址')
        for f in range(1,501):
            sheet.write(f, 0, fake.name())
            sheet.write(f, 1, fake.address())
        path = os.path.dirname(os.path.relpath(__file__))
        data_book.save(path+'用户信息.xls')
    except Exception as e:
        print(e)
    input()