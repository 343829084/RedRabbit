
class player_mgr_t:
    def __init__(self):
        self.all_players = {}
    def get(self, session_id_):
        return self.all_players.get(session_id_)
    def remove(self, session_id_):
        if None != self.all_players.get(session_id_):
            del  self.all_players[session_id_]
    def add(self, session_id_, player):
        self.all_players[session_id_] = player
    def size(self):
        return len(self.all_players)
    def idlist(self):
        return self.all_players.keys()

class player_t:
    def __init__(self, session_id_ = 0):
        self.session_id = session_id_;
        self.chat_times = 0
        self.nick_name  = ''
        self.password   = ''
        self.extra_data = ''
        self.online_time = 0
        self.ip         = ''
        self.gate_name  = ''
    def id():
        return self.session_id
    def set_id(id_):
        self.session_id = id_
    def inc_chat_times(self):
        self.chat_times += 1
    def get_chat_times(self):
        return self.chat_times

