import requests
import re

userName = input("studentid:")
password = input("passwd:")


try:
    # req1 = requests.get("http://202.119.25.2")
    try:
        req1 = requests.get("https://w.seu.edu.cn/")
    except requests.exceptions.ConnectionError:
        r.status_code = "Connection refused"
    pattern = re.compile("v46ip='(.*?)'")  # “？”最短匹配
    comp = re.compile(r"(([01]?\d?\d|2[0-4]\d|25[0-5]\d)\.){3}([01]?\d?\d|2[0-4]\d|25[0-5]\d)")
    result = pattern.findall(req1.text)
    result2 = comp.search(result[0])
    # print(req1.text)
    ip = result2.group(0)
except Exception as e:
    print("exit")
    exit(-1)


# 提取url主干
Host = "https://w.seu.edu.cn:801" ######################################?????????????????????????????????
# Host = "https://w.seu.edu.cn"

# 先把webforms存下来
dataForm = {
    'c':'Portal',
    'a':'login',
    'callback':'dr1003',
    'login_method':'1',
    'jsVersion':'3.3.2',
    'v':'4755'
}

# 再把headers写下来
headers = {
    'Connection':'keep-alive',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.70 Safari/537.36',
    'Accept':'*/*'
    # 'Referer':'http://202.119.25.2/a79.htm?UserIP=121.248.50.43&wlanacname=jlh_me60'
}
# 构造url全链接
url = Host+"/eportal/?c="+dataForm['c']+"&a="+dataForm['a']+"&callback="+dataForm['callback']+"&login_method="+dataForm['login_method']+"&user_account=%2C0%2C"+userName+"&user_password="+password+"&wlan_user_ip="+ip+"&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=jlh_me60&jsVersion=3.3.2&v="+dataForm['v']

req2 = requests.get(url, headers=headers)

# 检测关键字段是否在返回文本中，判断响应是否成功
# dr1003({"result":"1","msg":"\u8ba4\u8bc1\u6210\u529f"})
# b"\u8ba4\u8bc1\u6210\u529f".decode('unicode-escape')
# '认证成功'
if("\\u8ba4\\u8bc1\\u6210\\u529f" in req2.text):
    print("Connection sucessful!")
else:
    print("Connection failed.")
