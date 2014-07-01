// CharInfo.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{
import roa.display.char.CharBlock;
import roa.display.char.CharInfo;

// CharBlockData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharBlockData implements CharBlockDataBase
{
    private var m_id:String;
    public var width:uint = 0;
    public var height:uint = 0;
    public var chars:Vector.<CharInfoData> = new Vector.<CharInfoData>();
    
    // Properties
    public function get id ():String { return m_id; }
    public function set id (value:String):void { m_id = value; }
    public function get animated ():Boolean { return false; }
    
    //=============================================================================================
    public function render (charBlock:CharBlock, frame:int):void
    {
        // Create all CharInfos
        var w:uint = width;
        var h:uint = height;
        for (var i:int = 0; i < chars.length; ++i)
        {
            var charInfoData:CharInfoData = chars[i];
            var dx:int = i % w;
            var dy:int = i / w;
            
            var charInfo:CharInfo = new CharInfo(charInfoData);
            charInfo.x = dx * CharInfo.WIDTH;
            charInfo.y = dy * CharInfo.HEIGHT;
            charBlock.addChild(charInfo);
        }
    }
    
    //=============================================================================================
    public function onEnterFrame (frame:int):Boolean { return false; }
    public function nextFrame (frame:int):int { return 0; }
}

}