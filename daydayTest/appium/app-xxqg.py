from appium import webdriver

from appium import webdriver  # 后续操作依赖于这个库
import time
# desired_caps = {
#     'platformName': 'Android',  # 设备类型；
#     'platformVersion': '12',  # 设备的类型的版本号，如果是安卓，填写大的版本号即可，小数不用填；
#     'deviceName': 'RMX3618',  # 设备的名称，这个和后续的测试没有多大关系；
#     'appPackage': 'cn.xuexi.android',  # 需要测试的app包名；
#     'appActivity': 'cn.xuexi.android',  # 需要测试的app启动名；
#     'unicodeKeyboard': True,  # 如果指定了UI2作为驱动，不需要配置；
#     'resetKeyboard': True,  # 重置自动化时设置的键盘；
#     'chromedriverExecutableDir': '路径',  # 启动webview的webdriver驱动
#     'noReset': True,  # 防止每次启动app时候都初始化所有数据；
#     'newCommandTimeout': 6000,  # 代码向appiumserver发送命令的延迟时间，单位是秒，不设置默认一分钟；
#     'automationName': 'uiautomator2',  # 这个并不是所有应用都适配的，1.15.1以前默认是UI1，之后是默认UI2；
#     'autoGrantPermissions': "True",  # 自动跳过授权
#     'skipServerInstallation': 'True',
#     'skipDeviceInitialization': 'True',  # 跳过安装AppiumSetting
# }
peakmain = dict()
# 平台的名字，大小写无所谓，不能乱写
peakmain['platformName'] = 'Android'
# 平台的版本
peakmain['platformVersion'] = '12'
# 设备的名字 随便写，但是不能乱写(比如'')
peakmain['deviceName'] = 'kbzxssdaa685o7ws'
# 要打开的应用程序
peakmain['appPackage'] = 'com.android.settings'
# 需要启动的程序的activity
peakmain['appActivity'] = '.Settings'
driver = webdriver.Remote('http://localhost:4723/wd/hub', peakmain)  # /wd/hub 路径是固定的，desired_caps是初始化设置的字典；
time.sleep(5)
# driver.implicitly_wait(10)  # 隐式等待和selenium的用法是一样的；
driver.quit()