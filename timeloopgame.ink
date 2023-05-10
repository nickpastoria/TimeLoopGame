// Game Variables
LIST serums = red, blue, green, yellow, none
VAR currentSyrums = none
VAR loop = 1
VAR tissueState = "unstable"
->start
=== function Reset_Lab ===
    ~ currentSyrums = none
    ~ loop += 1
    ~ tissueState = "unstable"

=== start ===
-> introduction

=== introduction ===
You are a futuristic scientist tasked with creating a cure for a deadly plague. You must experiment with different combinations of colored serums to create the cure. Each loop begins with a limited set of serums.

The current loop is {loop}.

-> lab

=== lab ===
You are in your lab. The tissue sample in front of you is currently in a {tissueState} state. What will you do?
* [Test current setup] -> Test_Cure
* {currentSyrums !? red}[Add Red Serum] -> red_confirm
* {currentSyrums !? blue}[Add Blue Serum] -> blue_confirm
* {currentSyrums !? green}[Add Green Serum] -> green_confirm
* {currentSyrums !? yellow}[Add Yellow Serum] -> yellow_confirm
* [Examine the tissue sample]
    The tissue sample is currently {tissueState}. You think about the possible effects the serums could have.
    -> lab

=== red_confirm ===
Are you sure you want to add the Red Serum to the tissue sample?
* [Yes]
    ~ currentSyrums += red
    -> red_effect
* [No]
    -> lab

=== blue_confirm ===
Are you sure you want to add the Blue Serum to the tissue sample?
* [Yes]
    ~ currentSyrums += blue
    -> blue_effect
* [No]
    -> lab

=== green_confirm ===
Are you sure you want to add the Green Serum to the tissue sample?
* [Yes]
    ~ currentSyrums += green
    -> green_effect
* [No]
    -> lab

=== yellow_confirm ===
Are you sure you want to add the Yellow Serum to the tissue sample?
* [Yes]
    ~ currentSyrums += yellow
    -> yellow_effect
* [No]
    -> lab
=== red_effect ===
The Red Serum should make the tissue more resilient.
{
- tissueState == "unstable":
    ~ tissueState = "resilient"

- tissueState == "responsive":
    ~ tissueState = "regenerating"
- else:
    ~ tissueState = "unstable"
}
-> lab

=== blue_effect ===
The Blue Serum should make the tissue more responsive.
{
- tissueState == "unstable":
    ~ tissueState = "responsive"
- tissueState == "resilient":
    ~ tissueState = "stable"
- else:
    ~ tissueState = "unstable"
}
-> lab

=== green_effect ===
The Green Serum should stabilize the tissue if it's resilient.
{
- tissueState == "stable":
    ~ tissueState = "healed"
- else:
    ~ tissueState = "unstable"
}
-> lab

=== yellow_effect ===
The Yellow Serum should trigger a regeneration process if the tissue is responsive.
{
- tissueState == "regenerating":
    ~ tissueState = "healed"
- else:
    ~ tissueState = "unstable"
}
-> lab

=== Test_Cure ===
{
- tissueState == "healed": -> victory
- else: -> failure
}

=== victory ===
Congratulations! You have successfully created the perfect cure and broken the time loop. Humanity is saved!
-> END

=== failure ===
The setup did not produce the right cure. You feel a sense of déjà vu as the time loop resets.
{Reset_Lab()}
-> start
