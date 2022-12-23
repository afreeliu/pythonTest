# import ttskit
import os

# ttskit.tts('这是个示例', audio='14')
#
# 参数介绍
'''语音合成函数式SDK接口，函数参数全部为字符串格式。
text为待合成的文本。
speaker为发音人名称，可选名称为_reference_audio_dict；默认的发音人名称列表见resource/reference_audio/__init__.py。
audio为发音人参考音频，如果是数字，则调用内置的语音作为发音人参考音频；如果是语音路径，则调用audio路径的语音作为发音人参考音频。
注意：如果用speaker来选择发音人，请把audio设置为下划线【_】。
output为输出，如果以.wav结尾，则为保存语音文件的路径；如果以play开头，则合成语音后自动播放语音。
'''

if __name__ == '__main__':
    print(os.path.abspath(__file__))
    path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    print(path)