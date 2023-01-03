%% 
% Signals Processing Lab-1
% Problem 1: Write functions for unit delta function, unit step, signal addition, signal multiplication, signal shifting, signal folding.
%
% Author: Pawan kumar, IDDP student, CSIO-CSIR
% Aim: 
%      - The script is aimed to produce basic functions including shifted unit
%       impulse, unit step function, ramp function and sine signal with a given
%       shift and amplitudes.
%      - The script is also intented to perform basic operation like signal
%       addition, multiplication and signal folding. Various combination of
%       signals can be used to produce intersting results.

% No additional file is required to run this script at all the functions
% are contained in this singal file.

%
%The best feature of this script is that result of one operation could be
%feed to the other operations and the combination can produce intersting
%results.
%
%% Defining global variable, so that could be reused thoughout the script and within functions.

clc
global time;

%Time could be changed, everything else will adjust itself.
time=round(-30:.2:30,2);
global rsltSignal;
rsltSignal=zeros(1,length(time));

%% The infinite loop will run until 'e' entered by user
while 1==1
    userInput= acquireInput();
    if(userInput=='e')
        break
    else
        processInput(userInput);
    end
end
%% acquire the input from user

function targetFunction=acquireInput()
clc
targetFunction = input("Press\n\'1\' for  impulse (direc delta) function,\n\'2\' for unit step,\n\'3\' for ramp function,\n\'4\' for for sin function or,\n\'o\' for for mathematical opperations (add, mul, fold),\n\'c\' to clear the figure or,\n\'e\' for end script:\n",'s');
end

%% Process the input from user
function processInput(userInput)
global time;
hold on;
switch userInput
    case '1'
        %hold off;
        fprintf("plot implulse (direc delta) function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        impls=genUnitImpulse(shift);
        stem(time,impls);
        axis([min(time)-5 max(time)+5 min(impls)-5 max(impls)+5]);
    case '2'
        fprintf("plot unit step function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        %hold off;
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        untStp=genUnitStep(shift);
        plot(time,untStp);
        axis([min(time)-5 max(time)+5 min(untStp)-5 max(untStp)+5]);
    case '3'
        fprintf("plot unit ramp function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        %hold off;
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        rmp=genRamp(shift);
        plot(time,rmp);
        axis([min(time)-5 max(time)+5 min(rmp)-5 max(rmp)+5]);
    case '4'
        fprintf("Generating sine signal\nCurrent Sampling rate is %2f \n:-> Max signal frequency=%2f\n",1/findStepDistance(time),1/(findStepDistance(time)*2));
        freq=input("Enter the Frequency (Press enter for default value=.1Hz): ");
        if isempty(freq)
            freq=.1;
        end
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        amplitude=input("Enter the amplitude (Press enter for default value=1): ");
        if isempty(amplitude)
            amplitude=1;
        end
        %hold on
        sinSig=genSinSignal(amplitude,freq,shift);
        plot(time,sinSig);
        axis([min(time)-5 max(time)+5 min(sinSig)-5 max(sinSig)+5]);
    case 'c'
        clf;
    case 'o'
        enterOperationMode();
    otherwise
        disp("invalid input");
end
end

%% This function will generate the unit impulse function
% A temprary varibale is maped thoughout the domain with zero values
% A value of one (for unit impulse) will be placed at given shift (default
% at zero).

% ---Known issue:: The function may produce exception in case a shift is given which is not
% listed in sampled time variable

function impls=genUnitImpulse(shift)
%the value of unit impulse is 1 at t=0
%fprintf("generating impulse with %2f shift\n",shift);
global time;
impls=zeros(1,length(time));
try
    impls(1,getPosition(shift,time))=1;
catch exception
    fprintf("The supplied shift value do not exist in sampled time matrix\n Kindly supply any nearby values. Following error occured: %s",exception);
end

end

%% The function will produce unit step function by summing the shifted unit 
%impulse fucntion, as per the defination of the unit impulse u(t)=Σ δ(t) 
%over all times greater then or equal to zero

function untStp=genUnitStep(shift)
global time;
%global matAna;
untStp=zeros(1,length(time));
for t=1:1:length(time)
    if(time(t)>=shift)
        untStp=untStp+genUnitImpulse(time(t));
    end
end
end

%% The function will produce ramp function by summing the shifted unit 
%step fucntion, as per the defination of the ramp function

function rmp=genRamp(shift)
global time;
%fprintf("generating impulse with %2f shift\n",shift);
rmp=zeros(1,length(time));
for t=1:1:length(time)
    if(time(t)>=shift)
        fprintf("generating step with %2f shift\n",shift);
        rmp=rmp+findStepDistance(time)*genUnitStep(time(t));
        clc
    end
end
end

%% The function will produce sine signal with given amplitude, freqency and shift

function sineSig=genSinSignal(amp,freq,shift)
global time;
sineSig=amp*sin(2*pi*freq*(time+shift));
end


%% The below code consist of another infinite loop to perform basic 
%operations on signals until the user press '4' to return previous menu

function enterOperationMode()
global time;
global rsltSignal;
hold on;
while 1==1
clc;
targetOpperation=input("Press\n\'1\' for Signal addition,\n\'2\' for  Signal multiplication,\n\'3\' for signal folding,\n\'c\' to clear the figure or,\n\'4\' to return previous menu,\n",'s');

switch targetOpperation
    case '1'
        addRslt=addit();
        rsltSignal=addRslt;
        plot(time,addRslt,'LineWidth',3);
        legend("Signal 1","Signal 2","Result");
        axis([min(time)-5 max(time)+5 min(addRslt)-5 max(addRslt)+5]);
    case '2'
        mulRslt=mul();
        rsltSignal=mulRslt;
        plot(time,mulRslt,'LineWidth',3);
        legend("Signal 1","Signal 2","Result");
        axis([min(time)-5 max(time)+5 min(mulRslt)-5 max(mulRslt)+5]);
    case '3'
        fldRslt=foldIt();
        rsltSignal=fldRslt;
        plot(time,fldRslt,'LineWidth',3);
        legend("Signal 1","Signal 2","Result");
        axis([min(time)-5 max(time)+5 min(fldRslt)-5 max(fldRslt)+5]);
    case 'c'
        clf;
    case '4'
        return;
    otherwise
        disp("invalid input");
end
end
end

%% Get two different signals and element wise multiply 

function mulRslt=mul()
clc
disp("Select signal 1 for multiplication");
sig1=acquireSignal();
disp("Select signal 2 for multiplication");
sig2=acquireSignal();
mulRslt=sig1.*sig2;
end

%% Get two different signals and element wise addition 
function addRslt=addit()
clc
disp("Select signal 1 for addition");
sig1=acquireSignal();
disp("Select signal 2 for addition");
sig2=acquireSignal();
addRslt=sig1+sig2;
end

%% Flip a given signal 
function fldRslt=foldIt()
clc
disp("Select signal 1 for folding");
sig=acquireSignal();
fldRslt=fliplr(sig);
end

%% To provide info to user and acquire the option
function sig=acquireSignal()
targetFunction = input("Press\n\'1\' for  impulse (direc delta) function,\n\'2\' for unit step,\n\'3\' for ramp function,\n\'4\' for for sin function or,\n\'a\' for preious operation result as signal*,\n",'s');
sig=drawSig(targetFunction);
end

%% Generate signal for opperation

function sig=drawSig(type)
global time;
global rsltSignal;
hold on
%1=unit impulse, 2=unit step, 3=ramp, 4=sine wave
switch type
    case '1'
        fprintf("Generating implulse (direc delta) function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        sig=genUnitImpulse(shift);
        plot(time,sig);
        axis([min(time)-5 max(time)+5 min(sig)-5 max(sig)+5]);
    case '2'
        fprintf("Generating unit step function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        sig=genUnitStep(shift);
        plot(time,sig);
        axis([min(time)-5 max(time)+5 min(sig)-5 max(sig)+5]);
    case '3'
        fprintf("Generating unit ramp function (from %2f to %2f)\n",getFirstEle(time),getLastEle(time));
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        sig=genRamp(shift);
        plot(time,sig);
        axis([min(time)-5 max(time)+5 min(sig)-5 max(sig)+5]);
    case '4'
        fprintf("Generating sine signal\nCurrent Sampling rate is %2f \n:-> Max signal frequency=%2f\n",1/findStepDistance(time),1/(findStepDistance(time)*2));
        freq=input("Enter the Frequency (Press enter for default value=.1Hz): ");
        if isempty(freq)
            freq=.1;
        end
        shift=input("Enter the shift (Press enter for default value=0): ");
        if isempty(shift)
            shift=0;
        end
        amplitude=input("Enter the amplitude (Press enter for default value=1): ");
        if isempty(amplitude)
            amplitude=1;
        end
        sig=genSinSignal(amplitude,freq,shift);
        plot(time,sig);
        axis([min(time)-5 max(time)+5 min(sig)-5 max(sig)+5]);
    case 'a'
         sig=rsltSignal;
         plot(time,sig);
    otherwise
        disp("Invalid input");
        return
end
end

%% Below signals will calculate the basic information about a given linearly distributed signal.

function stepDistance=findStepDistance(mat)
%will return the distance between two consucutive steps in uniformly
%distributed matrix
stepDistance=round(abs(getFirstEle(mat)-getLastEle(mat))/length(mat),2);
end

function pos=getPosition(ele,mat)
pos=find(mat==ele);
if isempty(pos)
    pos=0;
end
end

function firstEle=getFirstEle(mat)
%will return the first element of the given matrix
    firstEle=mat(1,1);
end

function lastEle=getLastEle(mat)
%will return the first element of the given matrix
    lastEle=mat(1,length(mat));
end
%%
% Hope you find it satisfactory.
