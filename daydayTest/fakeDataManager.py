

from faker import Faker
import xlwt # 写 excel 表
import xlrd # 读 excel 表
import os


if __name__ == '__main__':

    book = xlrd.open_workbook("用户信息1.xls")
    if not book:
        print('创建一个book')

    sheet_names = book.sheet_names()
    sheet = book.sheet_by_name(sheet_names[0])
    print(sheet.nrows, sheet.ncols)

    # fake = Faker('zh_CN')
    # try:
    #     data_book = xlwt.Workbook(encoding='utf-8')
    #     sheet = data_book.add_sheet('用户信息')
    #     sheet.write(0, 0, '姓名')
    #     sheet.write(0, 1, '地址')
    #
    #     for f in range(1,501):
    #         sheet.write(f, 0, fake.name())
    #         sheet.write(f, 1, fake.address())
    #     path = os.path.dirname(os.path.relpath(__file__))
    #     data_book.save(path+'用户信息.xls')
    # except Exception as e:
    #     print(e)