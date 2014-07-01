// InfoPanel.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
	import flash.display.Sprite;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFormat;
	
// InfoPanel
//////////////////////////////////////////////////////////////////////////////////////////////////
public class InfoPanel extends Sprite 
{
    // Controls
    private var m_label:TextField;
    
    // Data
    private var m_pos:Point = new Point();
    
    //============================================================================================
    public function InfoPanel () 
    {
        // Draw a background
        graphics.beginFill(0xDDDDDD);
        graphics.drawRoundRect(-8, -4, 74, 42, 10, 10);
        graphics.endFill();
        
        // Draw the labels
        m_label = new TextField();
        m_label.defaultTextFormat = new TextFormat("_sans", 12, 0x0);
        addChild(m_label);
        
        setPosition(0, 0);
    }
    
    //============================================================================================
    public function setPosition (x:uint, y:uint):void
    {
        m_pos.x = x;
        m_pos.y = y;
        
        update();
    }
    
    private function update ():void
    {
        m_label.text = "X: " + m_pos.x + "\nY: " + m_pos.y;
    }

}

}