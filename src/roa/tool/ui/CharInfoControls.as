// CharInfoControls.as
// Randy Knapp
// 06/30/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.gskinner.geom.ColorMatrix;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.GlowFilter;
import org.osflash.signals.Signal;
import roa.display.data.CharInfoData;
	
// CharInfoControls
//////////////////////////////////////////////////////////////////////////////////////////////////
public class CharInfoControls extends Sprite 
{
    // Image
    [Embed(source="img/mouse-select.png")]
    private static const LeftMouse:Class;
    [Embed(source="img/mouse-select-right.png")]
    private static const RightMouse:Class;
    [Embed(source="img/pencil.png")]
    private static const Pencil:Class;
    [Embed(source="img/eraser.png")]
    private static const Eraser:Class;
    [Embed(source="img/pipette.png")]
    private static const Pipette:Class;
    
    // Constants
    private static const PADDING:uint = 4;
    public static const MODE_PENCIL:String = "pencil";
    public static const MODE_ERASER:String = "eraser";
    public static const MODE_PIPETTE:String = "pipette";
    
    // Data
    private static var m_desatMatrix:ColorMatrix = null;
    private var m_mode:String = MODE_PENCIL;
    private var m_modeKeys:Object = { eraser : false, pipette : false };
    
    // Controls
    private var m_leftControl:CharInfoPicker;
    private var m_rightControl:CharInfoPicker;
    private var m_modeImages:Object = {
        pencil  : new Pencil(),
        eraser  : new Eraser(),
        pipette : new Pipette()
    };
    
    // Properties
    public function get mode ():String { return m_mode; }
    public function get leftData ():CharInfoData { return m_leftControl.data; }
    public function get rightData ():CharInfoData { return m_rightControl.data; }

    //============================================================================================
    public function CharInfoControls () 
    {
        // Init matrix
        if (m_desatMatrix == null)
        {
            m_desatMatrix = new ColorMatrix();
            m_desatMatrix.adjustSaturation(-255);
        }
        
        // Create a background
        graphics.beginFill(0xDDDDDD);
        graphics.drawRoundRect(-PADDING * 2, -PADDING, 74, 176, 10, 10);
        graphics.endFill();
        
        // Create left and right mouse controls
        var left:Bitmap = new LeftMouse();
        left.x = 4;
        addChild(left);
        
        var right:Bitmap = new RightMouse();
        right.x = 38;
        addChild(right);
        
        // Create CharInfoPickers
        m_leftControl = new CharInfoPicker(65, 21, 14);
        m_leftControl.x = 0;
        m_leftControl.y = left.height + 8;
        
        m_rightControl = new CharInfoPicker(66, 31, 14);
        m_rightControl.x = 34;
        m_rightControl.y = m_leftControl.y;
        
        // Create mode indicators
        var x:uint = 2;
        var modes:Array = [ MODE_PENCIL, MODE_ERASER, MODE_PIPETTE ];
        for each (var m:String in modes)
        {
            var bitmap:Bitmap = m_modeImages[m] as Bitmap;
            bitmap.x = x;
            bitmap.y = 148;
            x += bitmap.width + 2;
            addChild(bitmap);
        }
        
        // Order matters
        addChild(m_leftControl);
        addChild(m_rightControl);

        updateMode();
        
        // Setup signals
        m_leftControl.onSelectorOpened.add(onSelectorOpened);
        m_rightControl.onSelectorOpened.add(onSelectorOpened);
        
        // Events
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }
    
    //=============================================================================================
    private function onAddedToStage (e:Event):void 
    {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownUp);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDownUp);
    }
    
    //=============================================================================================
    private function onKeyDownUp (e:KeyboardEvent):void 
    {
        m_modeKeys.eraser = e.shiftKey;
        m_modeKeys.pipette = e.altKey;
        updateMode();
    }
    
    //=============================================================================================
    public function pipetteAction (button:String, data:CharInfoData):void
    {
        if (button == "left")
            m_leftControl.data = data.clone()
        else if (button == "right")
            m_rightControl.data = data.clone()
    }
    
    //=============================================================================================
    private function onSelectorOpened (picker:*):void 
    {
        if (picker == m_leftControl)
            m_rightControl.hideSelectors();
        else if (picker == m_rightControl)
            m_leftControl.hideSelectors();
    }
    
    //============================================================================================
    public function updateMode ():void
    {
        if (m_modeKeys.eraser)
            m_mode = MODE_ERASER;
        else if (m_modeKeys.pipette)
            m_mode = MODE_PIPETTE;
        else
            m_mode = MODE_PENCIL;
            
        for (var key:String in m_modeImages)
        {
            var bitmap:Bitmap = m_modeImages[key] as Bitmap;
            if (key == m_mode)
            {
                bitmap.alpha = 1.0;
                bitmap.filters = [ ];
            }
            else
            {
                bitmap.alpha = 0.5;
                bitmap.filters = [ new ColorMatrixFilter(m_desatMatrix.toArray()) ];
            }
        }
    }

}

}