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
You are a futuristic scientist tasked with creating a cure for a deadly plague. You must experiment with different combinations of colored serums to create the cure. Each loop begins with a limited set of serums.

The current loop is {loop}.

-> lab

=== lab ===
You are in your lab. What will you do?
* [Test current setup] -> Test_Cure
* [Add Red Serum]
    ~ currentSyrums += red
    -> red_effect
* [Add Blue Serum]
    ~ currentSyrums += blue
    -> blue_effect
* [Add Green Serum]
    ~ currentSyrums += green
    -> green_effect
* [Add Yellow Serum]
    ~ currentSyrums += yellow
    -> yellow_effect

=== red_effect ===
{tissueState == "unstable":
    ~ tissueState = "resilient"
}
{tissueState == "responsive":
    ~ tissueState = "regenerating"
}
- else:
    ~ tissueState = "unstable"
-> lab

=== blue_effect ===
{tissueState == "unstable":
    ~ tissueState = "responsive"
}
{tissueState == "resilient":
    ~ tissueState = "stable"
}
- else:
    ~ tissueState = "unstable"
-> lab

=== green_effect ===
{tissueState == "stable":
    ~ tissueState = "healed"
}
- else:
    ~ tissueState = "unstable"
-> lab

=== yellow_effect ===
{tissueState == "regenerating":
    ~ tissueState = "healed"
}
- else:
    ~ tissueState = "unstable"
-> lab

=== Test_Cure ===
    {tissueState == "healed": -> victory}
    -> failure

=== victory ===
Congratulations! You have successfully created the perfect cure and broken the time loop. Humanity is saved!
-> END

=== failure ===
The setup did not produce the right cure. You feel a sense of déjà vu as the time loop resets.
{Reset_Lab()}
-> start
