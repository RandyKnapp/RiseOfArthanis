// CharPicker.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.sibirjak.asdpc.button.ButtonEvent;
import flash.display.Sprite;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import org.osflash.signals.events.GenericEvent;
import org.osflash.signals.Signal;
	
// CharPicker
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharPicker extends PickerBase 
{
    // Constants
    private const WIDTH:uint = 32;
    private const CHAR_COUNT:uint = 256;
    
    // Data
    private var m_char:uint;
    
    // Controls
    private var m_button:CharPickerButton;
    
    // Properties
    public function get char ():uint { return m_char; }
    public function set char (value:uint):void { setChar(value); }
    
    // Signals
    public var onCharChanged:Signal = new Signal();
    
    //============================================================================================
    public function CharPicker (char:uint = 0) 
    {
        m_char = char;
        
        // Main button
        m_button = new CharPickerButton(m_char);
        m_button.addEventListener(ButtonEvent.CLICK, toggleSelector);
        addChild(m_button);
        
        // Selector
        m_selector = new Sprite();
        m_selector.graphics.beginFill(0xCCCCCC);
        m_selector.graphics.lineStyle(1, 0x666666);
        m_selector.graphics.drawRoundRect( -4, -4, WIDTH * CharPickerButton.BUTTON_WIDTH + 8, uint(CHAR_COUNT / WIDTH) * CharPickerButton.BUTTON_HEIGHT + 8, 4, 4);
        m_selector.graphics.endFill();
        m_selector.filters = [ new DropShadowFilter(4, 90, 0, 0.4, 5, 5, 1, BitmapFilterQuality.HIGH) ];
        
        // Add buttons for all the colors
        for (var i:int = 0; i < CHAR_COUNT; ++i)
        {
            var b:CharPickerButton = new CharPickerButton(i);
            b.x = (i % WIDTH) * CharPickerButton.BUTTON_WIDTH;
            b.y = uint(i / WIDTH) * CharPickerButton.BUTTON_HEIGHT;
            b.addEventListener(ButtonEvent.CLICK, onSelectorClicked);
            m_selector.addChild(b);
        }
        
        m_selector.x = CharPickerButton.BUTTON_WIDTH / 2 - m_selector.width;
        m_selector.y = CharPickerButton.BUTTON_WIDTH / 2;
        m_selector.visible = false;
        addChild(m_selector);
    }
        
    //=============================================================================================
    private function setChar (value:uint):void 
    {
        if (m_char == value)
            return;
        
        m_char = value;
        m_button.char = value;
        onCharChanged.dispatch(this, m_char);
    }
    
    //=============================================================================================
    private function onSelectorClicked (e:ButtonEvent):void 
    {
        var button:CharPickerButton = e.target as CharPickerButton;
        if (button == null)
            return;
        
        setChar(button.char);
        toggleSelector();
    }

}

}