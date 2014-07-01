// CharColorPickerButton.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.sibirjak.asdpc.button.Button;
import flash.display.Shape;
import roa.display.char.CharInfoColor;
	
// CharColorPickerButton
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharColorPickerButton extends Button 
{
    // Constants
    public static const BUTTON_SIZE:uint = 24;
    public static const SWATCH_SIZE:uint = 16;
    
    // Data
    private var m_color:uint = 0;
    
    // Controls
    private var m_swatch:Shape;
    
    // Properties
    public function get color ():uint { return m_color; }
    public function set color (value:uint):void { m_color = value; updateSwatch(); }
    
    //============================================================================================
    public function CharColorPickerButton (c:uint = 0) 
    {
        super();
        setSize(BUTTON_SIZE, BUTTON_SIZE);
        m_color = c;
        updateSwatch();
    }
    
    //============================================================================================
    private function updateSwatch ():void
    {
        if (m_swatch == null)
        {
            m_swatch = new Shape();
            addChild(m_swatch);
            m_swatch.x = m_swatch.y = (BUTTON_SIZE - SWATCH_SIZE) / 2;
        }
        
        m_swatch.graphics.clear();
        
        if (m_color == CharInfoColor.TRANSPARENT)
        {
            m_swatch.graphics.beginFill(0xFFFFFF);
            m_swatch.graphics.drawRect(0, 0, SWATCH_SIZE / 2, SWATCH_SIZE / 2);
            m_swatch.graphics.drawRect(SWATCH_SIZE / 2, SWATCH_SIZE / 2, SWATCH_SIZE / 2, SWATCH_SIZE / 2);
            m_swatch.graphics.endFill();
            
            m_swatch.graphics.beginFill(0xAAAAAA);
            m_swatch.graphics.drawRect(0, SWATCH_SIZE / 2, SWATCH_SIZE / 2, SWATCH_SIZE / 2);
            m_swatch.graphics.drawRect(SWATCH_SIZE / 2, 0, SWATCH_SIZE / 2, SWATCH_SIZE / 2);
            m_swatch.graphics.endFill();
            return;
        }
        
        if (CharInfoColor.list[m_color] == undefined)
            return;
        var colorValue:uint = CharInfoColor.list[color];
        
        m_swatch.graphics.beginFill(colorValue);
        m_swatch.graphics.drawRoundRect(0, 0, SWATCH_SIZE, SWATCH_SIZE, 4, 4);
        m_swatch.graphics.endFill();
        
        toolTip = "" + m_color;
    }

}

}