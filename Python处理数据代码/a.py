import itchat
import time, datetime

itchat.auto_login(hotReload=True)
#返回完整的公众号列表
mps = itchat.get_mps()
## 获取名字中含有特定字符的公众号，也就是按公众号名称查找,返回值为一个字典的列表
mps = itchat.search_mps(name='东南大学研究生')
print(mps)
#发送方法和上面一样
userName = mps[0]['UserName']

startTime = datetime.datetime(2020, 12, 8, 6, 30, 0)
print('Program not starting yet...')
while datetime.datetime.now() < startTime:
    time.sleep(1)
print('Program now starts on %s' % startTime)
print('Executing...')
itchat.send("早安",toUserName = userName)