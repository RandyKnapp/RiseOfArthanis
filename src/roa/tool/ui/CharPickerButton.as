// CharPickerButton.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.sibirjak.asdpc.button.Button;
import flash.display.Shape;
import roa.display.char.CharInfo;
import roa.display.char.CharInfoColor;
import roa.display.data.CharInfoData;
	
// CharPickerButton
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharPickerButton extends Button 
{
    // Constants
    public static const BUTTON_WIDTH:uint = CharInfo.WIDTH + 8;
    public static const BUTTON_HEIGHT:uint = CharInfo.HEIGHT + 8;
    
    // Data
    private var m_char:uint = 0;
    
    // Controls
    private var m_swatch:CharInfo;
    
    // Properties
    public function get char ():uint { return m_char; }
    public function set char (value:uint):void { m_char = value; updateSwatch(); }
    
    //============================================================================================
    public function CharPickerButton (c:uint = 0) 
    {
        super();
        setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
        m_char = c;
        updateSwatch();
    }
    
    //============================================================================================
    private function updateSwatch ():void
    {
        if (m_swatch == null)
        {
            m_swatch = new CharInfo(new CharInfoData(m_char, CharInfoColor.BLACK, CharInfoColor.TRANSPARENT));
            addChild(m_swatch);
            m_swatch.x = (BUTTON_WIDTH - CharInfo.WIDTH) / 2;
            m_swatch.y = (BUTTON_HEIGHT - CharInfo.HEIGHT) / 2;
        }
        
        m_swatch.char = m_char;
        
        toolTip = "" + m_char;
    }

}

}