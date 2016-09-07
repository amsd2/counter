%Alice 01/02/2015. Programme to score Direct Social Interaction data on
%video
%Best to have video running on other computer / tv cos the figure window needs to be open so it can record key presses
%Behaviour can have 3 values (different key presses):
%a (default, other), l (sniff) or z (aggression)
%97=a; 108=l; 122=z
%Need to copy paste the variable Results into excel at the end of each
%animal (although it gets stored into a text file as well)


KeysPressed=[];%Matrix to store data
%First column of KeysPressed is the key pressed, and the 2nd column is the
%%time elapsed before another key was pressed and the third is the
%%cumulative duration

Name = input('Write file name (animal code)','s');
Date=input('Write date', 's');

load trees;imshow(X,map);
title(' Press "a" for nothing, "b" for body "h" for head / "u" for anogenital "z" for aggression "q" for exit');%Just need a figure to record key presses with gcf current character
set(gcf,'position',[100 100 800 800]);


k=0;
n=1;
while ~k %as long as k=0
   tic;
   k = waitforbuttonpress;
   time= toc;%stops the clock once a key has been pressed
   Currkey = get(gcf,'currentcharacter')%record which key was pressed
   
   KeysPressed(n+1, 1)=Currkey; %stores the key pressed in the first column (starting with the second row - the first row of the matrix is useless (it's the time spetn before the first key press)
   KeysPressed(n, 2)=time; %stores the time between 2 key presses
   
   n=n+1;
   
   k=0;
   
    if strcmp(Currkey,'q')% to stop the programme
        k = 1;
    end
   
end
        
close all


CountA=0;
CountZ=0;
CountB=0;
CountH=0;
CountU=0;
DurA=0;
DurZ=0;
DurB=0;
DurH=0;
DurU=0;
KeysPressed(1, 3)=0;

Longueur=size(KeysPressed, 1);
for i=1:Longueur
    if KeysPressed(i, 1)==97
        CountA=CountA+1;
        DurA=DurA+KeysPressed(i, 2);
       elseif KeysPressed(i, 1)==122
        CountZ=CountZ+1;
        DurZ=DurZ+KeysPressed(i, 2);
         elseif KeysPressed(i, 1)==98
        CountB=CountB+1;
        DurB=DurB+KeysPressed(i, 2);
    elseif KeysPressed(i, 1)==104
        CountH=CountH+1;
        DurH=DurH+KeysPressed(i, 2);
    elseif KeysPressed(i, 1)==117
        CountU=CountU+1;
        DurU=DurU+KeysPressed(i, 2);
    end
end%This created 5 variables countA,  CountZ, CountB counH and CountU that are the count of key presses for each letter
%and reciproquely for DurX the duration between the key press and the time another key was pressed.


 Results = {Name, Date, CountA, DurA, CountZ, DurZ, CountB, DurB, CountH, DurH, CountU, DurU};  % Stores all results in matrix Results,
 %which needs to be copy pasted into excel. order as above so count other
 %duration count aggression duration aggression count body sniff duration
 %body count head duration head count anogen duration anogen

 ResultsForFile =zeros(1, 10);%Cant store string into txt file so this creates another variable to go into the individual txt file

ResultsForFile(1, 1)=CountA;
ResultsForFile(1, 2)=DurA;
ResultsForFile(1, 3)=CountZ;
ResultsForFile(1, 4)=DurZ;
ResultsForFile(1, 5)=CountB;
ResultsForFile(1, 6)=DurB;
ResultsForFile(1, 7)=CountH;
ResultsForFile(1, 8)=DurH;
ResultsForFile(1, 9)=CountU;
ResultsForFile(1, 10)=DurU;
 
 save (Name, 'ResultsForFile','KeysPressed', '-ascii');
 %Saves the raw data file with the name of the animal, then the results in
 %the order:  CountL, DurL,CountA, DurA, CountZ, DurZ, Count5BinL, Dur5BinL, Count5BinA, Dur5BinA, Count5BinZ,Dur5BinZ. and then the raw data (with the
 %L column the keys pressed in acsii format, the middle column the duration
 %before another key was pressed and the third column the cumulative
 %duration.


