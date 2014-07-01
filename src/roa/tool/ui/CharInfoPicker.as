// CharInfoPicker.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
	import flash.display.Sprite;
    import org.osflash.signals.events.GenericEvent;
    import org.osflash.signals.Signal;
    import roa.display.char.CharInfo;
	
// CharInfoPicker
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharInfoPicker extends Sprite 
{
    // Constants
    private static const PADDING:uint = 4;
    
    // Controls
    private var m_data:CharInfo;
    private var m_charPicker:CharPicker;
    private var m_fgColorPicker:CharColorPicker;
    private var m_bgColorPicker:CharColorPicker;
    
    // Signals
    public var onCharInfoChanged:Signal = new Signal();
    public var onSelectorOpened:Signal = new Signal();
    
    //============================================================================================
    public function CharInfoPicker (char:uint = 0, fg:uint = 0, bg:uint = 0) 
    {
        var w:uint = CharColorPickerButton.BUTTON_SIZE;
        
        // Draw a background
        graphics.beginFill(0xEEEEEE);
        graphics.drawRoundRect(-PADDING, -PADDING, w + PADDING * 2, (CharInfo.HEIGHT * 2) + CharPickerButton.BUTTON_HEIGHT + CharColorPickerButton.BUTTON_SIZE * 2 + PADDING * 7, 10, 10);
        graphics.endFill();
        
        // Draw a little black square behind the example
        graphics.beginFill(0x0);
        graphics.drawRect(((w - CharInfo.WIDTH * 2) / 2) - (PADDING / 2), (PADDING / 2), CharInfo.WIDTH * 2 + PADDING, CharInfo.HEIGHT * 2 + PADDING);
        graphics.endFill();
        
        // Example/Data
        m_data = new CharInfo(char, fg, bg);
        m_data.scaleX = m_data.scaleY = 2;
        m_data.x = ((w - CharInfo.WIDTH * 2) / 2);
        m_data.y = (PADDING / 2) + 2;
        
        // Char Button
        m_charPicker = new CharPicker(char);
        m_charPicker.x = ((w - CharPickerButton.BUTTON_WIDTH) / 2);
        m_charPicker.y = m_data.y + CharInfo.HEIGHT * 2 + PADDING + PADDING;
        
        // Color Buttons
        m_fgColorPicker = new CharColorPicker(fg);
        m_fgColorPicker.x = ((w - CharColorPickerButton.BUTTON_SIZE) / 2);
        m_fgColorPicker.y = m_charPicker.y + CharPickerButton.BUTTON_HEIGHT + PADDING;
        
        m_bgColorPicker = new CharColorPicker(bg);
        m_bgColorPicker.x = ((w - CharColorPickerButton.BUTTON_SIZE) / 2);
        m_bgColorPicker.y = m_fgColorPicker.y + CharColorPickerButton.BUTTON_SIZE + PADDING;
        
        // Child order matters
        addChild(m_bgColorPicker);
        addChild(m_fgColorPicker);
        addChild(m_charPicker);
        addChild(m_data);
        
        // Setup events
        m_charPicker.onSelectorOpened.add(onChildSelectorOpened);
        m_fgColorPicker.onSelectorOpened.add(onChildSelectorOpened);
        m_bgColorPicker.onSelectorOpened.add(onChildSelectorOpened);
        
        m_charPicker.onCharChanged.add(onCharChanged);
        m_fgColorPicker.onColorChanged.add(onFgColorChanged);
        m_bgColorPicker.onColorChanged.add(onBgColorChanged);
    }
    
    //=============================================================================================
    public function hideSelectors ():void
    {
        m_charPicker.showSelector(false);
        m_fgColorPicker.showSelector(false)
        m_bgColorPicker.showSelector(false);
    }
        
    //=============================================================================================
    private function onCharChanged (picker:*, newChar:uint):void 
    {
        if (m_data.char != newChar)
        {
            m_data.char = newChar;
            onCharInfoChanged.dispatch(this, m_data);
        }
    }
    
    //=============================================================================================
    private function onFgColorChanged (picker:*, newColor:uint):void 
    {
        if (m_data.fg != newColor)
        {
            m_data.fg = newColor;
            onCharInfoChanged.dispatch(this, m_data);
        }
    }
    
    //=============================================================================================
    private function onBgColorChanged (picker:*, newColor:uint):void 
    {
        if (m_data.bg != newColor)
        {
            m_data.bg = newColor;
            onCharInfoChanged.dispatch(this, m_data);
        }
    }
    
    //=============================================================================================
    private function onChildSelectorOpened (picker:*):void 
    {
        // Hide the others
        if (picker != m_charPicker)
            m_charPicker.showSelector(false);
        if (picker != m_fgColorPicker)
            m_fgColorPicker.showSelector(false);
        if (picker != m_bgColorPicker)
            m_bgColorPicker.showSelector(false);
            
        onSelectorOpened.dispatch(this);
    }

}

}