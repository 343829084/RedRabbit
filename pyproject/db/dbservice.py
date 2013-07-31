
table_num = 1

def init():
    pass

def get_db():
    return None#TODO

def register_player(player):
    sql = "INSERT INTO `player_register` (`NAME` , `PASSWORD`) VALUES('%s', '%s') " % (player.nick_name, player.password)
    ret = get_db().sync_query(sql)
    if ret.flag == False:
        return False
    sql = "select `ID` FROM `player_register` WHERE `NAME` = %s AND `PASSWORD` = '%s'" % (player.nick_name, player.password)
    ret = get_db().sync_query(sql)
    player.set_id(int(ret.result[0][0]))
    return True
