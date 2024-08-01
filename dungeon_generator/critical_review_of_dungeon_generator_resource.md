# Review
Context:
At this point in time I have only worked with godot for 2 months at max and the project was under strict time constraints (by design). 

## Overview 
In general this file has evovled to be complex and long. This is not by design but rather by limitation of time when implementing this feature.
I think it is save to say that it is not very transparent what the main purpose of this file is. In this review I would like to propose changes which would help to resolve this problem.

## Separation of concerns
Upon some inspection it seems to be that this is used to store information about items that are supposed to be distributed over the dungeon tiles. The code for distribution is not part of this file. That means that for this usecase, the `dungeon_generator_resource.gd` seems to only be used as a data storage. 

The second usecase of `dungeon_generator_resource.gd` is the calculation of the *wave function collapse* algorithm to generate a plausible layout of dungeon tiles upon entering the dungeon. In this case the respective `dungeon_generator_resource`-object is used to store data and also holds the code to run on said data.

For the sake of separation of concerns these two usecases should be split into separate classes / data structures.


Another point of discussion is the tight coupling between the game data / business logic and the *wave function collapse* algorithm. In general the algorithm itself (not the presented implementation) is stateless and should be implemented this way. That would allow a separation of the algorithm from the business logic and already remove most code from this file.
To decouple the algorithm from the `dungeon_generator_resource` I propose to define an interface for objects the *wave function collapse* can be executed upon, change the implementation of the algorithm to run on objects that implement this interface and have the `dungeon_generator_resource` build these *wave function collapse*-compatible objects to plug into the algorithm when needed.

This would free the *wave function collapse*-algorithm from the actual objects of the game an could make this module portable to be plugged into different scenarios / games. Also this would be an ideal scenario for unit-testing.

## Data structures
In this scenario, the data of interest is a two-dimensional array of dungeon tiles. Since godot does not feature a two-dimensional array / matrix as a data structure, a mapping onto a one-dimensional array was chosen. While this works, it takes away from the readability of the code whenever a value is set or retrieved from the array due to the necessary index-calculations. 

As an easy fix I propose to implement a class `Array2D` to handle all of the index calculations internally and expose two-dimensional adressability of the data. This would greatly improve readability in the `dungeon_generator_resource` / *wave function collapse*-algorithm and could be used in other places too. Also this would also be a great case for unit-testing.

## Rework of the *wave function collapse*-algorithm
The algorithm should be implemented with its own interface in a [separate class](#separation-of-concerns). In addition I propose to implement the algorithm in accordance to this [pseudocode description](https://github.com/mxgmn/WaveFunctionCollapse?tab=readme-ov-file#algorithm). I rephrased the definition in terms of the usecase of building a dungeon from tiles.

1. Create an array with the dimensions of the output. Each element of this array represents a state of a tile in the output. A state of a tile is a superposition of possible tiles of the input with boolean coefficients. False coefficient means that the corresponding tile is forbidden, true coefficient means that the corresponding tile is not yet forbidden.
2. Initialize the wave in the completely unobserved state, i.e. with all the boolean coefficients being true.
3. Repeat the following steps:
    1. Observation:
        1. Find a wave element with the minimal nonzero entropy. If there is no such elements (if all elements have zero or undefined entropy) then break the cycle and go to step (4).
        2. Collapse this element into a definite state according to its coefficients.
    2. Propagation: propagate information gained on the previous observation step.
4. By now all the wave elements are either in a completely observed state (all the coefficients except one being false) or in the contradictory state (all the coefficients being zero). In the first case return the output. In the second case finish the work without returning anything.

In addition to the "green field" implementation of the algorithm we are also interested in adding additional starting constraints. An explanation of this can also be found in the [source repository](https://github.com/mxgmn/WaveFunctionCollapse?tab=readme-ov-file#constrained-synthesis). The actual implementation does not use ConvChain to resolve constraints and relies solely on *wave function collapse* (I have not yet spent time to think about whether this even makes sense).

## Misc
- The constants `_UNKNOWN, _TODO, _DONE` could be implemented as an enum
- It is not really clear which variables are constants and which are modified by the script
- the `save_rules()` function is actually a tool which generates the `rules.json` working-file. This should not be executed in the game code in production since we do not expect to have new dungeon tiles created at runtime. => should be moved to a tool-script and executed on demand / on build
