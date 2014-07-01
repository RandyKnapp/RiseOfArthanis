// AnimatedCharBlockData.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.data 
{

// AnimatedCharBlockFrameData
///////////////////////////////////////////////////////////////////////////////////////////////////
public class AnimatedCharBlockFrameData 
{
    // Data
    public var block:CharBlockData;
    public var delay:int;
    
    //=============================================================================================
    public function AnimatedCharBlockFrameData (block:CharBlockData, delay:int)
    {
        this.block = block;
        this.delay = delay;
    }
}

}