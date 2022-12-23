import pyttsx3


# pyttsx3.speak('你好时节是领导放假了是领导看风景脸上的肌肤是领导咖啡是领导放假收到了房间是的我范围史蒂夫这次v我厄尔瓜')

engine = pyttsx3.init() #初始化
print('准备开始语音播报...')
engine.say('勇士总冠军')
engine.runAndWait()
# engine = pyttsx3.init()
#
# """ RATE"""
# rate = engine.getProperty('rate')   # getting details of current speaking rate
# print (rate)                        #printing current voice rate
# engine.setProperty('rate', 250)     # setting up new voice rate
#
#
# """VOLUME"""
# volume = engine.getProperty('volume')   #getting to know current volume level (min=0 and max=1)
# print (volume)                          #printing current volume level
# engine.setProperty('volume',1.0)    # setting up volume level  between 0 and 1
#
# """VOICE"""
# voices = engine.getProperty('voices')       #getting details of current voice
# #engine.setProperty('voice', voices[0].id)  #changing index, changes voices. o for male
# engine.setProperty('voice', voices[0].id)   #changing index, changes voices. 1 for female
# engine.say('My current speaking rate is ' + str(rate))
# engine.runAndWait()
# engine.stop()
#
#
# """Saving Voice to a file"""
# # On linux make sure that 'espeak' and 'ffmpeg' are installed
# engine.save_to_file('Hello World', 'test.mp3')
# engine.runAndWait()