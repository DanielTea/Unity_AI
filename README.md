# unity3d-roll-a-ball_AI code

This is the project sourcecode to run Unity-3Ds Roll-a-ball with Deep-Learning-algorithms from https://github.com/Kaixhin/Atari.


To run this code (ONLY TESTED ON UBUNTU LINUX): 

1. download and install Unity-3D 5.5.0p1 at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/ (scroll down to the bottom of the forum)
2. Install Torch + dependencies following the steps on this github-repository:
   https://github.com/Kaixhin/Atari
3. Import 'unity3d-roll-a-ball-master' as Unity project.
4. Start the project in Unity (click play)
5. cd to ~/unity3d-roll-a-ball-master/Atari2
6. `qlua main.lua -env rollaball -gpu 1 -hiddenSize 32 -optimiser adam  -steps 15000000 -learnStart 80000 -memSize 1000000 -epsilonSteps 50000 -valFreq 100000 -valSteps 50000 -bootstraps 0 -memPriority rank -PALpha 0 -duel true -verbose true -alpha 0.7 -betaZero 0.8 -eta 0.0000225`
7. change `-gpu 1` to `-gpu 0` if you don`t want to use your gpu
