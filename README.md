# Enigma

## Project Description / Requirements

http://backend.turing.io/module1/projects/enigma/


## Self Assessment

Below is how I would rate myself against the [evaluation rubric](http://backend.turing.io/module1/projects/enigma/rubric).

#### Functionality: 4

I think I'm a solid 4 on functionality. I have working encrypt/decrypt/crack methods and the corresponding command line interfaces. I went a step above by implementing a smart (not brute force) crack method, and by allowing for optional arguments in the CLI's.

#### Object Oriented Programming: 4

I think I deserve a 4 on OOP because...
 - [x] Project includes a module and/or superclass that could be used outside of the Enigma project.
   - ShiftGenerator is a superclass I created to accomplish the common functionality between the keys and dates (offsets). I built in the flexibility to handle keys of different lengths, and different amount of shifts (the project is based on A/B/C/D shifts per the requirements, but I made it easy to change to just A/B/C or A/B/C/D by changing one number in ShiftGenerator)
 - [x] All methods are less than 8 lines of code.
  - Self explanatory...
 - [ ] All classes are less than 100 lines.
   - I have one class (SmartCrack) which is 116 lines, but I feel it is adequate as-is. It accomplishes a single purpose (the guts of the Enigma#crack method in an efficient & effective way).
   - All other classes (which accomplish the heart of the project) are well below 100 lines.
 - [x] All lines of code are less than 80 characters.
   - Except for messages to the user, all lines are <80 characters.
 - [x] At least one class demonstrates a good use of class methods.
    - Shifter accomplishes a clear single responsibility (shifting letters to other letters based on the contained character set) but doesn't need any info to initialize. That made it a clear candidate for class methods.
 - [x] Variable and method names always clearly communicate purpose.
    - I think my variable & method names are clear throughout.

#### Test Driven Development: 4

I think I deserve a 4 on TDD because...
 - [x] All test names clearly communicate the purpose of the test.
   - I believe all of my test names are clear and specific.
 - [ ] At least one test implements mocks and stubs.
   - I did not implement mocks & stubs, because none of my methods took in an object of a different class as an argument, so there was no reason to!
 - [x] Test coverage metrics show 100% coverage.
   - I covered all lines of code in my tests, including the fact that errors were thrown when appropriate (e.g. when key input is too long or non-numerical).
 - [x] Every method is tested at both the unit and integration level.
   - Methods are tested in their own class' corresponding test file (unit tested), as well as in the classes that use them. The Enigma class integrates functionality from all of the other classes, so most of its tests are integration tests.
 - [x] Git history demonstrates students are writing tests before implementing code.
   - I always wrote tests before writing the corresponding code.

#### Version Control: 4

I think I deserve a 4 on VC because...
- [x] At least 40 commits.
   - I had 133 total commits.
- [x] At least 15 pull requests that are named and documented to clearly communicate the purpose of the pull request.
   - I had 15 pull requests, and each one had a message listing off what was changed in that branch.
- [x] No commits include multiple pieces of functionality.
   - I actually deleted my first version of the Enigma project that I'd started because I realized I'd been lazy about committing when setting things up in the beginning.
   - After that, I was careful to always do a commit whenever I added a file/class/method, refactored something, fixed a failing/skipped test, etc.
- [x] No commit message is ambiguous.
   - My commit messages always communicate what was changed.
