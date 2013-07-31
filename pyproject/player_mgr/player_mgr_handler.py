
from player_mgr_model import *

#这个修饰器的意思是注册下面函数处理验证client账号密码，
#session_key为账号密码组合体，client第一个包必为登陆包
@ffext.session_verify_callback
def my_session_verify(session_key, online_time, ip, gate_name):
    '''
    #需要返回数组，验证成功，第一个元素为分配的id，
    #第二个元素可以不设置，若设置gate会返回给client，login gate的时候
    #需要第二个元素返回分配的game gate
    '''
    return [str(ffext.alloc_id())]
						

