# iOS environment
from appium import webdriver
# Options are only available since client version 2.3.0
# If you use an older client then switch to desired_capabilities
# instead: https://github.com/appium/python-client/pull/720
from appium.options.ios import XCUITestOptions
from appium.webdriver.common.appiumby import AppiumBy




options = XCUITestOptions()
options.platformVersion = '13.4'
options.udid = '123456789ABC'
options.app = PATH('../../apps/UICatalog.app.zip')
# Appium1 points to http://127.0.0.1:4723/wd/hub by default
self.driver = webdriver.Remote('http://127.0.0.1:4723', options=options)
el = self.driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value='item')
el.click()