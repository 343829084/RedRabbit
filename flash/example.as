import ff.SharedStruct;
import org.apache.thrift.*;


mc_page0.visible = true;
mc_page1.visible = false;

Security.loadPolicyFile("xmlsocket://121.199.21.238:10242");

var socket:Socket = new Socket();
var isConn:Boolean = false;
//socket init 
socket.endian = Endian.LITTLE_ENDIAN;
//���ӡ����Ͱ�ť��Ϣ
mc_page0.btn_connect.addEventListener(MouseEvent.CLICK, onConnectClicked);
mc_page1.send_btn.addEventListener(MouseEvent.CLICK, onSendClicked);
mc_page1.addEventListener(KeyboardEvent.KEY_DOWN, queren_btn);
function queren_btn(evt:KeyboardEvent)
{
    if(evt.keyCode ==Keyboard.ENTER)
          SendMsg();
}

//functions
function onConnectClicked(evt:Event)
{//�������
	socket.addEventListener(Event.CONNECT,onConn);
	socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	
	var address:String=mc_page0.txt_address.text;
	var port:int=parseInt(mc_page0.txt_port.text,10);
	socket.connect(address, port);
}

function onConn(e:Event):void 
{//���ӳɹ�
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	
	socket.addEventListener(Event.CLOSE,onClose);
	socket.addEventListener(ProgressEvent.SOCKET_DATA,onReceiveData);
	isConn = true;
//�����л�
	mc_page0.visible = false;
	mc_page1.visible = true;
//������Ϣ
	sendMsg(0, mc_page0.txt_name.text);
}

function onError(e:IOErrorEvent):void
{//IO error
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	isConn = false;
	trace("IOError");
}

function onSecurity(e:SecurityErrorEvent):void 
{//SecurityError
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.close();
	isConn=false;
	trace("SecurityError");
}

function onClose(e:Event):void {
	socket.removeEventListener(Event.CLOSE,onClose);
	isConn=false;
}


function sendBytesData( cmd:int, byteArray:ByteArray):void 
{//������Ϣ
	var ss1:SharedStruct = new SharedStruct();
	ss1.key = 10244;
	var ba:ByteArray = FFUtil.EncodeMsg(ss1);
	trace("OhNice1:" + ba.length);
	var ss2:SharedStruct = new SharedStruct();
	ba.position = 0;
	FFUtil.DecodeMsg(ss2, ba);
	trace("OhNice:" + ss1.key);
	//MsgToByteArray(SharedStruct);
	if (isConn) 
	{
		//head
		socket.writeInt(byteArray.length);
		socket.writeShort(cmd);
		socket.writeShort(0);
		//body
		socket.writeBytes(byteArray, 0, byteArray.length); 
		socket.flush();
	}
	else 
	{
		mc_page1.incomingChat_txt.htmlText += "<font color='#ff0000' face='����' size='20'>���ѶϿ����ӣ����������ӣ�����</font>"; 
		trace("û�������ϰ�����������");
	}
}

function sendMsg( cmd:int, msg:String):void 
{//������Ϣ
	if (isConn) 
	{
		var thisStringBytsLength :ByteArray = new ByteArray();
	    thisStringBytsLength.writeMultiByte(msg,"utf-8");
		sendBytesData(cmd, thisStringBytsLength);
		trace( msg + " ���ȣ� " + GetStringLength(msg));
	}
	else 
	{
		mc_page1.incomingChat_txt.htmlText += "<font color='#ff0000' face='����' size='20'>���ѶϿ����ӣ����������ӣ�����</font>"; 
		trace("û�������ϰ�����������");
	}
}
function onReceiveData(e:ProgressEvent):void
{//�յ���Ϣ
	while (socket.bytesAvailable) 
	{
		var body_len:int = socket.readInt();
		var command:int =  socket.readShort();
		var reversed:int = socket.readShort();
		
		var msg:String = socket.readUTFBytes(body_len);
		mc_page1.incomingChat_txt.htmlText += msg; 
	}
}

function SendMsg()
{
	if (mc_page1.sendChat_txt.text.length>0) 
	{
		sendMsg(1, "[\"" + mc_page1.sendChat_txt.text + "\"]");
	}
	mc_page1.sendChat_txt.text="";
}

function onSendClicked(evt:Event) 
{
	SendMsg();
}

function GetStringLength(thisString : String) : Number
{
     var thisStringBytsLength :ByteArray = new ByteArray();
     thisStringBytsLength.writeMultiByte(thisString,"utf-8");
     return thisStringBytsLength.length;
}