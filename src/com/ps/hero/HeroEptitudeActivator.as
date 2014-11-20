/**
 * Created by root on 9/11/14.
 */
package com.ps.hero {
import com.log.Logger;
import com.ps.cards.eptitude.CardEptitude;
import com.ps.cards.eptitude.EptitudeEvent;
import com.ps.cards.eptitude.IEptitudeActivator;

public class HeroEptitudeActivator implements IEptitudeActivator {

    private var callback:Function;
    private var hero:Hero;

    public function activateEptitude (hero:Hero, eptitude:CardEptitude, callback:Function) :void {
        this.callback = callback;
        this.hero = hero;
        switch (eptitude.getType()) {
            case CardEptitude.INCREASE_HEALTH:
            {
                hero.setHealth(hero.getHealth() + eptitude.getPower());
                hero.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
            }
            case CardEptitude.TREATMENT:
            {
                if (hero.getHealth() == hero.getMaxHealth()) {
                    break;
                }

                var newHealth:int = hero.getHealth() + eptitude.getPower();
                if (newHealth > hero.getMaxHealth()) {
                    newHealth = hero.getMaxHealth()
                }

                hero.setHealth(newHealth);
                hero.dispatchEvent(new EptitudeEvent(EptitudeEvent.TREATMENT, eptitude, this))
                return;
            }

            case CardEptitude.PASSIVE_ATTACK:
            {
                hero.dispatchEvent(new EptitudeEvent(EptitudeEvent.PASSIVE_ATTACK, eptitude, this));
                return;
            }


            case CardEptitude.FREEZE:
            {
                hero.dispatchEvent(new EptitudeEvent(EptitudeEvent.FREEZE, eptitude, this));
                return;
            }

            case CardEptitude.MASSIVE_ATTACK:
            {
                newHealth = hero.getHealth() - eptitude.getPower();
                if (newHealth < 0) newHealth = 0;

                hero.setHealth(newHealth);
                if (hero.getHealth() == 0) {
                    hero.dispatchEvent(new EptitudeEvent(EptitudeEvent.DEATH, eptitude, this));
                    return;
                }
                break;
            }

        }
        continueActivate()
    }

    public function continueActivate () :void
    {
        callback ();
    }
}
}
