// CharColorPicker.as
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
import roa.display.char.CharInfoColor;
	
// CharColorPicker
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharColorPicker extends PickerBase 
{
    // Constants
    private const WIDTH:uint = 14;
    private const PADDING:uint = 4;
    
    // Data
    private var m_color:uint;
    
    // Controls
    private var m_button:CharColorPickerButton;
    
    // Properties
    public function get color ():uint { return m_color; }
    public function set color (value:uint):void { setColor(value); }
    
    // Signals
    public var onColorChanged:Signal = new Signal();
    
    //============================================================================================
    public function CharColorPicker (color:uint = 0) 
    {
        m_color = color;
        
        // Main button
        m_button = new CharColorPickerButton(color);
        m_button.addEventListener(ButtonEvent.CLICK, toggleSelector);
        addChild(m_button);
        
        var colorCount:uint = CharInfoColor.list.length;
        
        // Selector
        m_selector = new Sprite();
        m_selector.graphics.beginFill(0xCCCCCC);
        m_selector.graphics.lineStyle(1, 0x666666);
        m_selector.graphics.drawRoundRect(-PADDING, -PADDING, WIDTH * CharColorPickerButton.BUTTON_SIZE + PADDING * 2, uint(colorCount / WIDTH) * CharColorPickerButton.BUTTON_SIZE + PADDING * 2, PADDING, PADDING);
        m_selector.graphics.endFill();
        m_selector.filters = [ new DropShadowFilter(4, 90, 0, 0.4, 5, 5, 1, BitmapFilterQuality.HIGH) ];
        
        // Add buttons for all the colors
        for (var i:int = 0; i < colorCount; ++i)
        {
            var b:CharColorPickerButton = new CharColorPickerButton(i);
            b.x = (i % WIDTH) * CharColorPickerButton.BUTTON_SIZE;
            b.y = uint(i / WIDTH) * CharColorPickerButton.BUTTON_SIZE;
            b.addEventListener(ButtonEvent.CLICK, onSelectorClicked);
            m_selector.addChild(b);
        }
        
        m_selector.x = CharColorPickerButton.BUTTON_SIZE / 2 - m_selector.width;
        m_selector.y = CharColorPickerButton.BUTTON_SIZE / 2;
        m_selector.visible = false;
        addChild(m_selector);
    }
        
    //=============================================================================================
    private function setColor (value:uint):void 
    {
        if (m_color == value)
            return;
        
        m_color = value;
        m_button.color = value;
        onColorChanged.dispatch(this, m_color);
    }
    
    //=============================================================================================
    private function onSelectorClicked (e:ButtonEvent):void 
    {
        var button:CharColorPickerButton = e.target as CharColorPickerButton;
        if (button == null)
            return;
        
        setColor(button.color);
        toggleSelector();
    }
}

}