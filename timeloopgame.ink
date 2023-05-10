// Game Variables
LIST serums = red, blue, green, yellow, none
VAR currentSyrums = none
VAR loop = 1
VAR tissueState = "unstable"
VAR corruption = 0
->start

=== function Reset_Lab ===
    ~ currentSyrums = none
    ~ loop += 1
    ~ tissueState = "unstable"
    ~ corruption = 0

=== start ===
-> introduction

=== introduction ===
*You are a scientist 
Tasked with creating a cure for a deadly plague, and humanities last hope. 
    * *With the last sparks of life humankind was able to create these four vials 
    It was thought that the cure to the otherworldly plague lies within them.
    * * *They also were able to create a machine 
    Which pulls its user back to the moment the machine is set.
    * * * *You are humanities last hope.
    You must find the correct ingredients, and order to undo the wretched horror plaguing the human race.
    * * * * * [Start]
->restart
= restart
The current loop is {loop}.

-> lab

=== lab ===
You are in your lab. The tissue sample, a grotesque, undulating mass that emits an otherworldly glow, is currently in a state best described as {tissueState}. What will you do?
+ [Test current setup] -> Test_Cure
+ {currentSyrums !? red}[Approach the Red Vial] -> red_confirm
+ {currentSyrums !? blue}[Approach the Blue Vial] -> blue_confirm
+ {currentSyrums !? green}[Approach the Green Vial] -> green_confirm
+ {currentSyrums !? yellow}[Approach the Yellow Vial] -> yellow_confirm
+ [Examine the tissue sample]
    The tissue sample is currently {tissueState}. It pulses in response to your gaze, as if aware. You shudder to think of the effects the serums might provoke.
    -> lab

=== red_confirm ===
The Red Vial hums with a foreboding energy. Its contents, you've been told, should strengthen the tissue's resilience against...unseen forces. Are you sure you want to proceed?
+ [Yes, add the Red Serum]
    ~ currentSyrums += red
    -> red_effect
+ [No, step away]
    -> lab

=== red_effect ===
{
- tissueState == "unstable":
    The tissue shudders and hardens, becoming eerily still. It's now more resilient. You feel a shiver of unease, like you've strayed from the path of natural law.
    ~ tissueState = "resilient"
    ~ corruption += 1

- tissueState == "responsive":
    The tissue thrashes wildly before suddenly regenerating at a rapid pace. The sight is unnatural, disturbing. You can't help but feel you're meddling with powers you don't fully understand.
    ~ tissueState = "regenerating"
    ~ corruption += 1
- else:
    The tissue convulses, writhing as though in pain. It returns to an unstable state. The discomfort in your mind grows.
    ~ tissueState = "unstable"
    ~ corruption += 1
}
-> lab

=== blue_confirm ===
The Blue Serum, glowing with an alien luminescence, is said to make the tissue more responsive. Do you dare to add it to the tissue sample?
+ [Yes]
    ~ currentSyrums += blue
    -> blue_effect
+ [No]
    -> lab

=== blue_effect ===
{
- tissueState == "unstable":
    The tissue squirms and pulses, as if gaining a form of sentience. It's now more responsive. An unsettling feeling creeps into your mind, as if you've trespassed into forbidden realms.
    ~ tissueState = "responsive"
    ~ corruption += 1

- tissueState == "resilient":
    The tissue calms and solidifies, its chaotic movement replaced with a serene stability. It's an uncanny sight. Are you becoming the master of life and death?
    ~ tissueState = "stable"
    ~ corruption += 1

- else:
    The tissue writhes in apparent agony, its form destabilizing. The scene is grotesque, and you can't escape the feeling that you're tampering with the fundamental laws of nature.
    ~ tissueState = "unstable"
    ~ corruption += 1
}
-> lab

=== green_confirm ===
The Green Serum, a liquid of emerald nightmares, supposedly stabilizes the tissue if it's resilient. Will you add it to the tissue sample?
+ [Yes]
    ~ currentSyrums += green
    -> green_effect
+ [No]
    -> lab

=== green_effect ===
{
- tissueState == "stable":
    The tissue relaxes, its monstrous growth subsiding. It's healed. A fleeting sense of triumph washes over you, quickly replaced by dread. Have you conquered death or unleashed something worse?
    ~ tissueState = "healed"
    ~ corruption += 1

- else:
    The tissue spasms, its structure degenerating into a chaotic mess. It's unstable. The sight is grotesque, and your mind throbs with the strain of the unholy knowledge you're amassing.
    ~ tissueState = "unstable"
    ~ corruption += 1
}
-> lab

=== yellow_confirm ===
The Yellow Serum, a fluid of sunlit madness, is said to trigger a regeneration process if the tissue is responsive. Dare you add it to the tissue sample?
+ [Yes]
    ~ currentSyrums += yellow
    -> yellow_effect
+ [No]
    -> lab

=== yellow_effect ===
{
- tissueState == "regenerating":
    The tissue reforms, its monstrous growth replaced by healthy cells. It's healed. But the sight of this miraculous recovery fills you with an overwhelming sense of cosmic dread.
    ~ tissueState = "healed"
    ~ corruption += 1

- else:
    The tissue contorts in a horrific display, its cells breaking down. It's unstable. You reel from the sight, feeling a profound disturbance in the fabric of reality.
    ~ tissueState = "unstable"
    ~ corruption += 1
}
-> lab

=== Test_Cure ===
{
- tissueState == "healed":
    You've done it. The tissue sample is healed, and the time loop is broken. But at what cost? Your mind reels from the eldritch knowledge you've gained. 
    ~ corruption += 5
    {corruption >= 10: -> madness_victory}
    -> victory
- else:
    The setup did not produce the right cure. The room begins to shudder, a low rumbling growing louder. You feel a sense of déjà vu as the time loop resets, and the echoes of your failures increase your mental burden.
    ~ corruption += 2
    -> failure
}

=== victory ===
Humanity is saved...for now. But you can't shake off the creeping dread that lingers in your mind. The cost of your victory weighs heavily upon you.
-> END

=== madness_victory ===
You've succeeded, but the eldritch knowledge you've gained has driven you to the brink of madness. Reality warps around you, and you realize you've become a part of the very horror you sought to cure. Humanity is saved, but you... you are lost.
-> END

=== failure ===
The tissue sample is not healed, and the time loop resets. Each failure pushes you closer to the edge of sanity. 
{Reset_Lab()}
-> introduction.restart
