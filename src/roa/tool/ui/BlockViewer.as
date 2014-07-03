// BlockViewer.as
// Randy Knapp
// 07/01/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.tool.ui 
{
import com.greensock.easing.Sine;
import com.greensock.TweenMax;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import org.osflash.signals.Signal;
import roa.display.char.CharInfo;
import roa.display.data.CharBlockData;
import roa.display.data.CharInfoData;
import roa.math.MathUtil;
import roa.tool.command.Command;
import roa.tool.command.CommandBuilder;
import roa.tool.command.CommandManager;
	
// BlockViewer
//////////////////////////////////////////////////////////////////////////////////////////////////
public class BlockViewer extends Sprite 
{
    // Constants
    private static const X_EXTENTS:uint = 120;
    private static const Y_EXTENTS:uint = 45;
    private static const ZOOM_STEP:Number = 0.5;
    private static const MAX_ZOOM:Number = 1 + (10 * ZOOM_STEP);
    private static const MIN_ZOOM:Number = 1 - (1 * ZOOM_STEP);
    
    // Data
    private var m_origin:Shape;
    private var m_grid:Shape;
    private var m_mask:Shape;
    private var m_viewer:Sprite;
    private var m_hoverX:int;
    private var m_hoverY:int;
    private var m_targetZoom:Number = 1.0;
    private var m_leftDown:Boolean = false;
    private var m_middleDown:Boolean = false;
    private var m_rightDown:Boolean = false;
    private var m_controls:CharInfoControls;
    private var m_data:CharBlockData = new CharBlockData();
    private var m_commandBuilder:CommandBuilder = new CommandBuilder(this);
    
    // Signals
    public var onHoverChanged:Signal = new Signal();
    
    //============================================================================================
    public function BlockViewer (w:uint, h:uint, controls:CharInfoControls) 
    {
        // Set Data
        m_controls = controls;
        
        // Create background color
        var bg:Shape = new Shape();
        bg.graphics.beginFill(0x222222);
        bg.graphics.drawRoundRect(-4, -4, w + 8, h + 8, 10, 10);
        bg.graphics.endFill();
        addChild(bg);
        
        // Generate grid
        m_grid = new Shape();
        
        // Create grid lines
        m_grid.graphics.lineStyle(0, 0x8080FF, 0.3);
        for (var x:int = 5; x <= X_EXTENTS; x += 5)
        {
            m_grid.graphics.moveTo(x * CharInfo.WIDTH, 0);
            m_grid.graphics.lineTo(x * CharInfo.WIDTH, Y_EXTENTS * CharInfo.HEIGHT);
        }
        for (var y:int = 5; y <= Y_EXTENTS; y += 5)
        {
            m_grid.graphics.moveTo(0, y * CharInfo.HEIGHT);
            m_grid.graphics.lineTo(X_EXTENTS * CharInfo.WIDTH, y * CharInfo.HEIGHT);
        }
        
        // Create origin marks
        m_origin = new Shape();
        m_origin.graphics.lineStyle(0, 0xFF8080);
        m_origin.graphics.moveTo(0, 0);
        m_origin.graphics.lineTo(X_EXTENTS * CharInfo.WIDTH, 0);
        m_origin.graphics.lineStyle(0, 0x80FF80);
        m_origin.graphics.moveTo(0, 0);
        m_origin.graphics.lineTo(0, Y_EXTENTS * CharInfo.HEIGHT);
        
        // Create and set mask
        m_mask = new Shape();
        m_mask.graphics.beginFill(0x0);
        m_mask.graphics.drawRoundRect(-4, -4, w + 8, h + 8, 10, 10);
        m_mask.graphics.endFill();
        addChild(m_mask);

        // Create the viewer control
        m_data = new CharBlockData();
        m_data.mouseEnabled = false;
        
        m_viewer = new Sprite();
        m_viewer.mouseEnabled = false;
        m_viewer.addChild(m_grid);
        m_viewer.addChild(m_origin);
        m_viewer.addChild(m_data);
        m_viewer.mask = m_mask;
        addChild(m_viewer);
        
        // Set up dragging
        addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown);
        addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp);
        addEventListener(MouseEvent.MOUSE_OUT, onMiddleMouseUp);
        addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
        
        // Set up drawing
        addEventListener(MouseEvent.MOUSE_DOWN, onLeftMouseDown);
        addEventListener(MouseEvent.MOUSE_UP, onLeftMouseUp);
        addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown);
        addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp);
        addEventListener(Event.MOUSE_LEAVE, onBothMouseUp);
        
        // Register for commands
        CommandManager.addCommandListener(Command.DRAW_CHARS, onHandleCommand);
        CommandManager.addCommandListener(Command.ERASE_CHARS, onHandleCommand);
    }
    
    //=============================================================================================
    private function onHandleCommand (action:String, command:Command):void 
    {
        if (command.target != this)
            return;
            
        var commandData:* = action == Command.ACTION_UNDO ? command.undoData : command.redoData;
        for each (var commandlet:* in commandData)
        {
            if (commandlet.type == "draw")
            {
                setDataAt(commandlet.x, commandlet.y, commandlet.data);
            }
            else if (commandlet.type == "erase")
            {
                eraseDataAt(commandlet.x, commandlet.y);
            }
        }
    }
    
    //=============================================================================================
    private function getDataAt (x:int, y:int):CharInfoData 
    {
        return m_data.getChar(x, y);
    }
        
    //=============================================================================================
    private function eraseDataAt (x:int, y:int):void 
    {
        var prevData:CharInfoData = getDataAt(x, y);
        if (prevData != null)
        {
            m_data.eraseChar(x, y);
            m_commandBuilder.addCommandlet("undo", "draw", { x : x, y : y, data : prevData } );
            m_commandBuilder.addCommandlet("redo", "erase", { x : x, y : y } );
        }
    }
    
    //=============================================================================================
    private function setDataAt (x:int, y:int, data:CharInfoData):void 
    {
        var prevData:CharInfoData = getDataAt(x, y);
        m_data.setChar(x, y, data);
        
        if (prevData != null)
            m_commandBuilder.addCommandlet("undo", "draw", { x : x, y : y, data : prevData } );
        else
            m_commandBuilder.addCommandlet("undo", "erase", { x : x, y : y } );
        m_commandBuilder.addCommandlet("redo", "draw", { x : x, y : y, data : data } );
    }
    
    //=============================================================================================
    private function onLeftMouseDown (e:MouseEvent):void 
    {
        m_leftDown = true;
        if (m_controls.mode == CharInfoControls.MODE_PENCIL || m_controls.mode == CharInfoControls.MODE_ERASER)
            m_commandBuilder.beginCommand(m_controls.mode == CharInfoControls.MODE_PENCIL ? Command.DRAW_CHARS : Command.ERASE_CHARS);
        onLeftMouseAction(e);
    }
    
    //=============================================================================================
    private function onLeftMouseUp (e:MouseEvent):void 
    {
        m_leftDown = false;
        m_commandBuilder.endCommand();
    }
    
    //=============================================================================================
    private function onRightMouseDown (e:MouseEvent):void 
    {
        m_rightDown = true;
        if (m_controls.mode == CharInfoControls.MODE_PENCIL || m_controls.mode == CharInfoControls.MODE_ERASER)
            m_commandBuilder.beginCommand(m_controls.mode == CharInfoControls.MODE_PENCIL ? Command.DRAW_CHARS : Command.ERASE_CHARS);
        onRightMouseAction(e);
    }
    
    //=============================================================================================
    private function onRightMouseUp (e:MouseEvent):void 
    {
        m_rightDown = false;
        m_commandBuilder.endCommand();
    }
    
    //=============================================================================================
    private function onBothMouseUp (e:Event):void 
    {
        m_leftDown = false;
        m_rightDown = false;
            if (m_controls.mode == CharInfoControls.MODE_PENCIL || m_controls.mode == CharInfoControls.MODE_ERASER)
        m_commandBuilder.beginCommand(m_controls.mode == CharInfoControls.MODE_PENCIL ? Command.DRAW_CHARS : Command.ERASE_CHARS);
    }
    
    //=============================================================================================
    private function onLeftMouseAction (e:MouseEvent):void 
    {
        onMouseAction(e, "left", m_controls.leftData);
    }

    //=============================================================================================
    private function onRightMouseAction (e:MouseEvent):void 
    {
        onMouseAction(e, "right", m_controls.rightData);
    }
    
    //=============================================================================================
    private function onMouseAction (e:MouseEvent, button:String, data:CharInfoData):void
    {
        if (m_controls.mode == CharInfoControls.MODE_ERASER)
            eraseDataAt(m_hoverX, m_hoverY);
        else if (m_controls.mode == CharInfoControls.MODE_PIPETTE)
            m_controls.pipetteAction(button, getDataAt(m_hoverX, m_hoverY));
        else
            setDataAt(m_hoverX, m_hoverY, data);
        
        onHoverChanged.dispatch(m_hoverX, m_hoverY, getDataAt(m_hoverX, m_hoverY));
    }
    
    //=============================================================================================
    private function onMouseWheel (e:MouseEvent):void 
    {
        var sign:Number = e.delta < 0 ? -1 : 1;
        var newZoom:Number = MathUtil.clamp(m_targetZoom + (sign * ZOOM_STEP), MIN_ZOOM, MAX_ZOOM);
        if (newZoom != m_targetZoom)
        {
            var targetX:int = mouseX + ((m_viewer.x - mouseX) * (newZoom / m_viewer.scaleX));
            var targetY:int = mouseY + ((m_viewer.y - mouseY) * (newZoom / m_viewer.scaleY));
            m_targetZoom = newZoom;
            TweenMax.killChildTweensOf(m_viewer);
            TweenMax.to(m_viewer, 0.15, {
                x : targetX,
                y : targetY,
                scaleX : m_targetZoom, 
                scaleY : m_targetZoom, 
                ease : Sine.easeInOut
            });
        }
    }
    
    //=============================================================================================
    private function onMouseMove (e:MouseEvent):void
    {
        // Update Hover
        var newX:int = int(m_viewer.mouseX / CharInfo.WIDTH);
        var newY:int = int(m_viewer.mouseY / CharInfo.HEIGHT);
        if (m_viewer.mouseX < 0)
            newX--;
        if (m_viewer.mouseY < 0)
            newY--;
        if (newX != m_hoverX || newY != m_hoverY)
        {
            m_hoverX = newX;
            m_hoverY = newY;
            onHoverChanged.dispatch(m_hoverX, m_hoverY, getDataAt(m_hoverX, m_hoverY));
            
            // Check for mouse actions
            if (m_leftDown)
                onLeftMouseAction(e);
            else if (m_rightDown)
                onRightMouseAction(e);
        }
    }
    
    //=============================================================================================
    private function onMiddleMouseDown (e:MouseEvent):void
    {
        m_middleDown = true;
        m_viewer.startDrag();
        Mouse.cursor = MouseCursor.HAND;
    }

    //=============================================================================================
    private function onMiddleMouseUp (e:MouseEvent):void
    {
        if (!m_middleDown)
            return;
        
        m_middleDown = false;
        m_viewer.stopDrag();
        Mouse.cursor = MouseCursor.ARROW;
    }
}

}