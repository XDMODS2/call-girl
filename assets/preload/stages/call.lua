offset = 900

function onCreate()
    setProperty('skipCountdown', true);
    makeLuaSprite("picobg", "bg/map2", 900, 0)
    addLuaSprite("picobg", false)
    scaleObject("picobg", 0.6, 0.6)
    
    makeLuaSprite("girlbg", "bg/girlf", -220, -250)
    addLuaSprite("girlbg", false)
    scaleObject("girlbg", 0.6, 0.6)

    makeLuaSprite("picobg2", "bg/map1", 540, -180)
    addLuaSprite("picobg2", true)
    scaleObject("picobg2", 0.6, 0.6)
end

function onCreatePost()
    addCharacterToList("girlIntro", "boyfriend")
    addCharacterToList("girl", "boyfriend")

    triggerEvent("Camera Follow Pos", 600, 400)
    setProperty("picobg.x", getProperty("picobg.x") + offset)
    setProperty("picobg2.x", getProperty("picobg2.x") + offset)
    setProperty("dadGroup.x", getProperty("dadGroup.x") + offset)
    setProperty("iconP1.alpha", 0)
    setProperty("iconP2.alpha", 0)
    setProperty("healthBarBG.alpha", 0)
    setProperty("healthBar.alpha", 0)
    if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
        noteTweenX('middletime1', 4, 414, 0.01, 'linear')
        noteTweenX('middletime2', 5, 527, 0.01, 'linear')
        noteTweenX('middletime3', 6, 637, 0.01, 'linear')
        noteTweenX('middletime4', 7, 750, 0.01, 'linear')
        noteTweenX('middletime21', 0, 1414, 0.01, 'linear')
        noteTweenX('middletime22', 1, 1527, 0.01, 'linear')
        noteTweenX('middletime23', 2, 1637, 0.01, 'linear')
        noteTweenX('middletime24', 3, 1750, 0.01, 'linear')
    end
end

function onUpdatePost()
    p1Mult = getProperty("healthBar.x") + ((getProperty("healthBar.width") * getProperty("healthBar.percent") * 0.01) + (150 * getProperty("iconP1.scale.x", true) - 150) / 2 - 26)
    p2Mult = getProperty("healthBar.x") + ((getProperty("healthBar.width") * getProperty("healthBar.percent") * 0.01) + (150 * getProperty("iconP2.scale.x", true)) / 2 - 26 * 2)

    scaleObject("healthBar", -1, 1)
    setProperty("iconP1.x", p1Mult -110)
    setProperty("iconP2.x", p2Mult -45)
    setProperty("iconP1.origin.x", 140)
    setProperty("iconP2.origin.x", 140)
    setProperty("iconP1.flipX", true)
    setProperty("iconP2.flipX", true)
end

function onEvent(tag)
    if tag == "the pico appears" then
        doTweenAlpha("HealthTween1", "iconP1", 1, 0.5, "expoInOut")
        doTweenAlpha("HealthTween2", "iconP2", 1, 0.5, "expoInOut")
        doTweenAlpha("HealthTween3", "healthBar", 1, 0.5, "expoInOut")
        doTweenAlpha("HealthTween4", "healthBarBG", 1, 0.5, "expoInOut")
        if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
            for i = 0, 7 do
                local key = (i % 4)
                local name = i > 3 and "defaultOpponentStrum" or "defaultPlayerStrum"
                
                noteTweenX("NoteTween" .. i, i,  _G[name .. "X" .. key], 0.5, "expoInOut")
            end
        end
        doTweenX("picoTween1", "picobg", getProperty("picobg.x") - offset, 0.5, "expoInOut")
        doTweenX("picoTween2", "picobg2", getProperty("picobg2.x") - offset, 0.5, "expoInOut")
        doTweenX("picoTween3", "dadGroup", getProperty("dadGroup.x") - offset, 0.5, "expoInOut")
    end
end

function onTweenCompleted(tag)
    if tag == "picoTween1" then
        triggerEvent("Camera Follow Pos", "", "")
    end
end



