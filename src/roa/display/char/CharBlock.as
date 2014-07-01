// CharInfoData.as
// Randy Knapp
///////////////////////////////////////////////////////////////////////////////////////////////////
package roa.display.char 
{
import flash.display.Sprite;
import flash.events.Event;
import roa.display.data.CharBlockData;
import roa.display.data.CharBlockInstanceData;
import roa.display.data.CharInfoData;
import roa.display.DisplayManager;
	

// CharBlock
///////////////////////////////////////////////////////////////////////////////////////////////////
public class CharBlock extends Sprite 
{
    // Data
    private var m_instance:CharBlockInstanceData;
    private var m_frameCount:int = 0;
    
    // Properties
    public function get instance ():CharBlockInstanceData { return m_instance; }
    public function set instance (value:CharBlockInstanceData):void { m_instance = value; m_frameCount = 0; update();  }
    public function get animated ():Boolean { return m_instance ? m_instance.data.animated : false; }
    
    //=============================================================================================
    public function CharBlock (data:* = null)
    {
        if (data is String)
            instance = DisplayManager.getBlockInstanceData(data);
        else if (data is CharBlockInstanceData)
            instance = data;
            
        cacheAsBitmap = animated;
    }
    
    //=============================================================================================
    private function enterFrame (e:Event):void 
    {
        if (m_frameCount == -1 || instance == null || !instance.data.animated)
        {
            removeEventListener(Event.ENTER_FRAME, enterFrame);
            return;
        }
        
        var needsUpdate:Boolean = instance.data.onEnterFrame(m_frameCount);
        
        if (needsUpdate)
            update();
        
        m_frameCount = instance.data.nextFrame(m_frameCount);
    }
    
    //=============================================================================================
    public function update ():void
    {
        if (m_instance == null)
            return;
            
        if (!hasEventListener(Event.ENTER_FRAME) && animated)
            addEventListener(Event.ENTER_FRAME, enterFrame);
        
        // Remove all children
        removeChildren();
        
        // Create all CharInfos
        m_instance.data.render(this, m_frameCount);
        
        // Set position
        x = m_instance.x * CharInfo.WIDTH;
        y = m_instance.y * CharInfo.HEIGHT;
    }
    
}

}