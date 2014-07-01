// PickerBase.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.sibirjak.asdpc.button.ButtonEvent;
import flash.display.Sprite;
import org.osflash.signals.events.GenericEvent;
import org.osflash.signals.Signal;
	
// PickerBase
//////////////////////////////////////////////////////////////////////////////////////////////////
internal class PickerBase extends Sprite 
{
    // Controls
    protected var m_selector:Sprite;
    
    // Signals
    public var onSelectorOpened:Signal = new Signal();
    public var onSelectorClosed:Signal = new Signal();
    
    //============================================================================================
    public function PickerBase () 
    {
    }
        
    //============================================================================================
    public function toggleSelector (e:ButtonEvent = null):void
    {
        m_selector.visible = !m_selector.visible;
        if (m_selector.visible)
            onSelectorOpened.dispatch(this);
        else
            onSelectorClosed.dispatch(this);
    }
    
    //============================================================================================
    public function showSelector (show:Boolean):void
    {
        if (m_selector.visible != show)
            toggleSelector();
    }

}

}