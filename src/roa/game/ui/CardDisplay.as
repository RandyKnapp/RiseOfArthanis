// CardDisplay.as
// Randy Knapp
// 07/03/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.game.ui 
{
import flash.display.Sprite;
import flash.events.MouseEvent;
	
// CardDisplay
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CardDisplay extends Sprite 
{
    // Constants
    public static const WIDTH:Number  = 150;
    public static const HEIGHT:Number = 200;
    
    // Data
    private var m_hand:HandDisplay;
    
    // Properties
    public function get hand ():HandDisplay { return m_hand; }
    public function set hand (value:HandDisplay):void { m_hand = value; }
    
    //============================================================================================
    public function CardDisplay () 
    {
        // Graphics
        graphics.lineStyle(5);
        graphics.beginFill(0x80FF80);
        graphics.drawRoundRect( -WIDTH / 2, -HEIGHT / 2, WIDTH, HEIGHT, 30);
        graphics.endFill();
        
        // Events
        addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        addEventListener(MouseEvent.CLICK, onClick);
    }
    //================================================================================================
    private function onClick (e:MouseEvent):void 
    {
        hand.removeCard(this);
    }
    
    //================================================================================================
    private function onMouseOver (e:MouseEvent):void 
    {
        hand.preview(this);
    }
    
    //================================================================================================
    private function onMouseOut (e:MouseEvent):void 
    {
        hand.preview(null);
    }

}

}