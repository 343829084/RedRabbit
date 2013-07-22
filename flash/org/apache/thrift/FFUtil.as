
package org.apache.thrift {

import org.apache.thrift.Set;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.apache.thrift.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.protocol.*;
import org.apache.thrift.transport.*;

public class FFUtil  {
		
	public static function EncodeMsg(msg:TBase):ByteArray
	{
		var ba:ByteArray = new ByteArray();
		var tran:FFMemoryTransport = new FFMemoryTransport();
		var proto:TBinaryProtocol  = new TBinaryProtocol(tran);
		msg.write(proto);
		return tran.getBuffer();
	}
	public static function DecodeMsg(msg:TBase, ba:ByteArray):Boolean
	{
		var tran:FFMemoryTransport = new FFMemoryTransport(ba);
		var proto:TBinaryProtocol  = new TBinaryProtocol(tran);
		msg.read(proto);
		return true;
	}
}
}
/*example 
	var ss1:SharedStruct = new SharedStruct();
	ss1.key = 10244;
	var ba:ByteArray = FFUtil.EncodeMsg(ss1);
	trace("OhNice1:" + ba.length);
	var ss2:SharedStruct = new SharedStruct();
	ba.position = 0;
	FFUtil.DecodeMsg(ss2, ba);
	trace("OhNice:" + ss1.key);
*/
