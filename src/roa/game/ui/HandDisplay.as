// HandDisplay.as
// Randy Knapp
// 07/03/2014
//////////////////////////////////////////////////////////////////////////////////////////////////
package roa.game.ui 
{
import com.greensock.easing.Expo;
import com.greensock.TweenMax;
import flash.display.Sprite;
import roa.math.MathUtil;
import roa.math.Vector3;
	
// HandDisplay
//////////////////////////////////////////////////////////////////////////////////////////////////
public class HandDisplay extends Sprite 
{
    // Constants
    private static const RADIUS:Number         = 800;
    private static const PREVIEW_HEIGHT:Number = -70;
    private static const PREVIEW_SPEED:Number  = 0.3;
    private static const UPDATE_SPEED:Number   = 0.6;
    private static const PREVIEW_SCALE:Number  = 1.2;
    
    // Data
    private var m_cards:Array             = new Array();
    private var m_previewCard:CardDisplay = null;
    private var m_handLayer:Sprite        = new Sprite();
    private var m_previewLayer:Sprite     = new Sprite();
    
    // Properties
    public function get count ():uint { return m_cards.length; }
    
    //============================================================================================
    public function HandDisplay () 
    {
        addChild(m_handLayer);
        addChild(m_previewLayer);
    }
    
    //============================================================================================
    public function addCard (card:CardDisplay, atIndex:int = -1):void
    {
        card.hand = this;
        if (atIndex < 0 || atIndex >= m_cards.length)
        {
            m_cards.push(card);
            m_handLayer.addChild(card);
        }
        else
        {
            m_cards.splice(atIndex, 0, card);
            m_handLayer.addChildAt(card, atIndex);
        }
        update();
    }
    
    //============================================================================================
    public function removeCard (card:CardDisplay):void
    {
        var index:int = m_cards.indexOf(card);
        if (index < 0)
            return;
            
        // Remove from list
        m_cards.splice(index, 1);
        
        // If preview card, remove that
        if (m_previewCard == card)
            m_previewCard = null;
        
        // Remove card from display
        card.parent.removeChild(card);
        
        update();
    }
    
    //============================================================================================
    public function getCard (index:int):CardDisplay
    {
        if (index < 0 || index >= m_cards.length)
            return null;
            
        return m_cards[index];
    }
    
    //============================================================================================
    public function preview (card:CardDisplay):void
    {
        // Remove current preview card
        if (m_previewCard != null)
        {
            m_previewLayer.removeChild(m_previewCard);
            m_handLayer.addChildAt(m_previewCard, m_cards.indexOf(m_previewCard));
        }
        
        // Add new preview card
        m_previewCard = card;
        if (m_previewCard != null)
        {
            m_handLayer.removeChild(m_previewCard);
            m_previewLayer.addChild(m_previewCard);
        }
        
        // Update positions
        update();
    }
    
    //============================================================================================
    private function update ():void
    {
        var start:Number;
        var pos:Array = new Array();
        if (count == 0)
            return;
        else if (count <= 3)
        {
            start = -1 * ((count - 1) * CardDisplay.WIDTH) / 2;
            for (var i:int = 0; i < count; ++i)
                pos.push({ x : (start + (i * CardDisplay.WIDTH)), y : 0, angle : 0 });
        }
        else
        {
            var center:Vector3 = new Vector3(0, -RADIUS);
            var s:Number       = (count <= 8 ? 0.6 : (count <= 12 ? 0.4 : 0.25));
            start              = -1 * ((count - 1) * CardDisplay.WIDTH) * (s / 2);
            for (i = 0; i < count; ++i)
            {
                var x:Number  = (start + (i * CardDisplay.WIDTH * s));
                var v:Vector3 = new Vector3(x, RADIUS);
                var a:Number  = MathUtil.getAngleDeg(v) - 90;
                var y:Number  = center.add(v.normalize().scale(RADIUS)).y;
                pos.push({
                    x     : x,
                    y     : -y,
                    angle : -a
                });
            }
        }
        
        // Assign Positions
        for (var c:int = 0; c < count; ++c)
        {
            var targetX:Number   = pos[c].x as Number;
            var targetY:Number   = pos[c].y as Number;
            var angle:Number     = pos[c].angle as Number;
            var card:CardDisplay = m_cards[c] as CardDisplay;
            
            TweenMax.killChildTweensOf(card);
            if (card == m_previewCard)
            {
                TweenMax.to(card, PREVIEW_SPEED, {
                    x        : targetX,
                    y        : PREVIEW_HEIGHT,
                    rotation : 0,
                    scaleX   : PREVIEW_SCALE,
                    scaleY   : PREVIEW_SCALE,
                    ease     : Expo.easeOut
                });
            }
            else
            {
                TweenMax.to(card, UPDATE_SPEED, {
                    x        : targetX,
                    y        : targetY,
                    rotation : angle,
                    scaleX   : 1.0,
                    scaleY   : 1.0,
                    ease     : Expo.easeOut
                });
            }
        }
    }

}

}