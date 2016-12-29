# unity3d-roll-a-ball_AI code

This is the project sourcecode to run Unity-3Ds Roll-a-ball with Deep-Learning-algorithms from https://github.com/Kaixhin/Atari.


To run this code (ONLY TESTED ON UBUNTU LINUX): 

1. download and install Unity-3D 5.5.0p1 at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/ (scroll down to the bottom of the forum)
2. Install Torch + dependencies following the steps on this github-repository:
   https://github.com/Kaixhin/Atari
3. Import 'unity3d-roll-a-ball-master' as Unity project.
4. Set the resolution in Unity. Go to: File -> Build settings -> Player settings -> Default Screen Width/Height
5. Set the same resolution in the Lua script:

   5.1 open with a text editor `~/unity3d-roll-a-ball-master/Atari2/rollaball.lua`
   
   5.2 edit line 12 `self.size = opts.size or  <resolution>` change `<resolution>` to your set display resolution in Unity      example: `self.size = opts.size or 20`
   
6. Start the project in Unity (click play)
7. cd to `~/unity3d-roll-a-ball-master/Atari2`
8. `qlua main.lua -env rollaball -gpu 1 -hiddenSize 32 -optimiser adam  -steps 15000000 -learnStart 80000 -memSize 1000000 -epsilonSteps 50000 -valFreq 100000 -valSteps 50000 -bootstraps 0 -memPriority rank -PALpha 0 -duel true -verbose true -alpha 0.7 -betaZero 0.8 -eta 0.0000225`
9. change `-gpu 1` to `-gpu 0` if you don`t want to use your gpu
