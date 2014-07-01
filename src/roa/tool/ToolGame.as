// ToolGame.as
// Randy Knapp
// 06/29/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool 
{
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
	
// ToolGame
//////////////////////////////////////////////////////////////////////////////////////////////////
public class ToolGame extends Sprite 
{
    // Data
    private var m_test:Quad;

    //============================================================================================
    public function ToolGame () 
    {
        // Init
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
    
    //=============================================================================================
    private function onAddedToStage (e:Event = null):void 
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        
        // Setup stuff
        /*m_test = new Quad(100, 100, 0xFFFF0000);
        m_test.alignPivot();
        m_test.x = stage.stageWidth / 2;
        m_test.y = stage.stageHeight / 2;
        
        addChild(m_test);*/
    }
    
    //=============================================================================================
    override public function dispose ():void 
    {
        super.dispose();
        m_test = null;
    }

}

}