
from player_mgr_model import *
import ffext
import msg_def
from db import dbservice

@ffext.session_verify_callback
def real_session_verify(session_key, online_time, ip, gate_name):
    '''
    '''
    db = ffext.ffdb_create('mysql://localhost:3306/root/root/pcgame')
    #db.query('CREATE TABLE  IF NOT EXISTS dumy (A int, c float, b varchar(200), primary key (A))')
    #db.query('insert into dumy values(1, 2.3, "ttttTTccc")')
    sql = "INSERT INTO `player_register` (`NAME` , `PASSWORD`) VALUES('%s', '%s') " % ('TT', 'a')
    ret = db.sync_query(sql)#
    
    if len(session_key) < 16 or True:
        return [str(ffext.alloc_id())]#for debug
    account = msg_def.account_t()
    ffext.decode_buff(account, session_key)
    player = player_t()
    if account.register_flag == true:
        player.nick_name = acount.nick_name
        player.password  = acount.password
        if False == dbservice.register_player(player):
            return []
    #load player base info
    if False == dbservice.load_player(player):
        return []
    player.online_time = online_time
    player.ip          = ip
    player.gate_name   = gate_name
    ffext.singleton(player_mgr_t).add(player.id(), player)
    return [str(player.id())]

@ffext.session_enter_callback
def real_session_enter(session_id, from_scene, extra_data):
    pass


@ffext.session_offline_callback
def real_session_offline(session_id, online_time):
    ffext.singleton(player_mgr_t).remove(session_id)

						



