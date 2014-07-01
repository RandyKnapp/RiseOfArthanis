// CharInfoData.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{
import flash.display.Sprite;
import roa.display.char.CharBlock;

// AnimatedCharBlockData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class AnimatedCharBlockData implements CharBlockDataBase
{
    // Data
    private var m_id:String;
    public var frames:Array = new Array();
    public var looping:Boolean = false;
    
    // Properties
    public function get id ():String { return m_id; }
    public function set id (value:String):void { m_id = value; }
    public function get animated ():Boolean { return true; }

    //=============================================================================================
    public function render (charBlock:CharBlock, frame:int):void
    {
        // Find frame data
        var frameData:AnimatedCharBlockFrameData = null;
        while (frame >= 0 && frameData == null)
        {
            frameData = frames[frame];
            frame--;
        }
        
        if (frameData == null)
            return;
            
        return frameData.block.render(charBlock, 0);
    }
    
    //=============================================================================================
    public function onEnterFrame (frame:int):Boolean
    {
        // See if we're at the end
        var totalFrames:int = 0;
        for each (var frameData:AnimatedCharBlockFrameData in frames)
            totalFrames += frameData.delay;
            
        if (frame >= totalFrames)
            return true;
            
        // Find this frame
        if (frames[frame] == undefined)
            return false;
            
        return true;
    }
    //=============================================================================================
    public function nextFrame (frame:int):int
    {
        var totalFrames:int = 0;
        for each (var frameData:AnimatedCharBlockFrameData in frames)
            totalFrames += frameData.delay;
            
        if (looping && frame >= totalFrames)
            return 0;
        else if (!looping && frame >= totalFrames)
            return -1;
            
        return frame + 1;
    }
}

}