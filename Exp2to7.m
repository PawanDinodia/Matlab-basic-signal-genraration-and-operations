%% Signals Processing Lab-1
% Aim: Generate and plot each of the following sequences using
% the above defined functions:

%%  Part a: x(n)= 5δ(n+3)-2δ(n-4), for -10<=n<=10
n=(-10:.05:10);
x=5*genUnitImpulse(-3,n)-2*genUnitImpulse(4,n);
figure
stem(n,x);
title("Exp 2: Part a. x(n)= 5δ(n+3)-2δ(n-4),    for -10<=n<=10");
axis([min(n)-5 max(n)+5 min(x)-5 max(x)+5]);

%%  Part b: The problem consist of two parts. First part is having a ramp fucntion with positive slop and the second part consist of decaying exponential signal.
n=(0:.05:20);

firstPart_1=genUnitStep(0,n);
firstPart_2=firstPart_1-genUnitStep(10,n);
firstPart=n.*firstPart_2;
secondPart_1=genUnitStep(10,n);
secondPart_2=secondPart_1-genUnitStep(20,n);
secondPart=10.*exp(-0.3*(n-10)).*secondPart_2;
x=firstPart+secondPart;

figure
plot(n,x);
title("Exp 2: Part b");
axis([min(n)-5 max(n)+5 min(x)-5 max(x)+5]);


%% Part C: Generating a cosine signal with given parameters and adding noise singal with zero mean and given varience
n=(0:.05:50);
cosine_fun=cos(0.04*pi*n);
noise_sig=normrnd(0,1,size(n));
part_b3=cosine_fun+noise_sig;
figure
plot(n, part_b3);
title("Exp 2: Part c");

%% Part D: Given =[1 2 3 4 5 6 7 6 5 4 3 2 1]; Plot the following sequences: 
% Subpart 1: 3*x(n+4)-6*x(n)*x(n-2);
% Subpart 2: x(5-n)+2x(-n)*x(4+n);
% Considering domain from -3 to 9 without affected from signal shift.
% From the given statement, we understood that maximum shift in -x axis is
% -9 by -n and and max shift in +x axis is x-2 by 2. Therefore, choosing
% domain from -9 to 13.
clc
clf
n=-9:1:11;

%Subpart 1
subpart_1=3*X(-4,1)-6*X(0,1).*X(2,1);

subplot(3,2,1);
stem(n,3*X(-4,1));
axis([min(n)-5 max(n)+5 min(3*X(-4,1))-5 max(3*X(-4,1))+5]);
title("3(x+4)");

subplot(3,2,2);
stem(n,6*X(0,1));
axis([min(n)-5 max(n)+5 min(6*X(0,1))-5 max(6*X(0,1))+5]);
title("6x(n)");

subplot(3,2,3);
stem(n,X(2,1));
axis([min(n)-5 max(n)+5 min(X(2,1))-5 max(X(2,1))+5]);
title("x(n-2)");

subplot(3,2,4);
stem(n,6*X(0,1).*X(2,1));
axis([min(n)-5 max(n)+5 min(6*X(0,1).*X(2,1))-5 max(6*X(0,1).*X(2,1))+5]);
title("6x(n)*x(n-2)");

subplot(3,2,5);
stem(n,-6*X(0,1).*X(2,1));
axis([min(n)-5 max(n)+5 min(-6*X(0,1).*X(2,1))-5 max(-6*X(0,1).*X(2,1))+5]);
title("-6x(n)*x(n-2)");

subplot(3,2,6);
stem(n,subpart_1);
axis([min(n)-5 max(n)+5 min(subpart_1)-5 max(subpart_1)+5]);
title("3(x+4)-6x(n)*x(n-2)");

%Subpart 1
subpart_2=X(5,-1)+2*X(0,-1).*X(-4,1);
figure;
stem(n,subpart_2);
axis([min(n)-5 max(n)+5 min(subpart_2)-5 max(subpart_2)+5]);
title("Exp 2: Part D Subpart 2");

%% Part 3: Generate a sinusoidal wave with the following parameters: frequency (f0=10 Hz) and time
% instances varying from 0 to 1000.
t=0:.01:1000; % Freq=10hz => Min. Sampling freq=20 hz => Max sampling interval =.05. Taking sampling interval as .01 for more clear signal.
y=sin(2*pi*10*t);
plot(t,y);
axis([-10 1010 -5 5]);
title("Sin(2*pi*10*t)");

%% Part 4: Write a function for decomposing a signal into its even and odd components.

n=1:1:100;
% Generating random of length equal to 'n'  and signal vlaues between 10
% and 500;
some_random_signal=500*rand(1,length(n))+10;
flipped_signal=fliplr(some_random_signal);
even_fun=(some_random_signal+flipped_signal)/2;
odd_fun=(some_random_signal-flipped_signal)/2;


subplot(2,2,1);
plot(n,some_random_signal);
title("Some random signal");
axis([min(n)-5 max(n)+5 min(some_random_signal)-5 max(some_random_signal)+5]);

subplot(2,2,2);
plot(n,flipped_signal);
title("Folded signal");
axis([min(n)-5 max(n)+5 min(flipped_signal)-5 max(flipped_signal)+5]);

subplot(2,2,3);
plot(n,even_fun);
title("Even component");
axis([min(n)-5 max(n)+5 min(even_fun)-5 max(even_fun)+5]);

subplot(2,2,4);
plot(n,odd_fun);
title("Odd component");
axis([min(n)-5 max(n)+5 min(odd_fun)-5 max(odd_fun)+5]);

%% Part 5: Implement Sinc function with
clc
clf
t=-10:.01:10;
a1=2.5;
a2=1;
a3=0.5;
sinc_1=sin(a1.*t)./t;
sinc_2=sin(a2.*t)./t;
sinc_3=sin(a3.*t)./t;

subplot(3,1,1);
plot(t,sinc_1);
title("Sinc 1: With a=2.5");
axis([min(t)-5 max(t)+5 min(sinc_1)-5 max(sinc_1)+5]);

subplot(3,1,2);
plot(t,sinc_2);
title("Sinc 2: With a=1");
axis([min(t)-5 max(t)+5 min(sinc_2)-5 max(sinc_2)+5]);

subplot(3,1,3);
plot(t,sinc_3);
title("Sinc 3: With a=0.5");
axis([min(t)-5 max(t)+5 min(sinc_3)-5 max(sinc_3)+5]);

%% Part 6: Plot e^j2t for t=0 to t=π (pi) to in the complex plane and define the shape of the curve.
clc
clf
t=linspace(0,pi,5000);
given_function=exp(2j*t);
plot(given_function);
title("The shape of curve is Circle");

%% Part 7: 
n=0:1:10;
hold on;
f_1=exp(-0.5*n).*genUnitStep(0,n);
f_2=exp(-0.5*n/2).*genUnitStep(0,0.5*n);
plot(n,f_1);
plot(n/2,f_2);
legend("exp(-0.5*n).*u(n)","exp(-0.5*n/2).*u(0.5*n)");

%% Shifted fucntion generator for activity 2
function y=X(shift,scale)
n=-9:1:11;
% Creating empty amplitudes corresponding to domain for mapping.
y = zeros(1,length(n));
x_n=[1 2 3 4 5 6 7 6 5 4 3 2 1];
if sign(scale)==-1
    x_n=fliplr(x_n);
    shift=shift-6;
end

for i=1:1:length(x_n)
    y(i+6+shift)=x_n(i);
end
end

%% This function will generate the unit impulse signal with given shift
function impls=genUnitImpulse(shift,n)
%the value of unit impulse is 1 at t=0
%fprintf("generating impulse with %2f shift\n",shift);
impls=zeros(1,length(n));
try
    impls(1,getPosition(shift,n))=1;
catch exception
    fprintf("The supplied shift value do not exist in sampled n matrix\n Kindly supply any nearby values. Following error occured: %s",exception);
end

end

%% The function will produce unit step function by summing the shifted unit 
function untStp=genUnitStep(shift,time)
%global matAna;
untStp=zeros(1,length(time));
for t=1:1:length(time)
    if(time(t)>shift)
        untStp=untStp+genUnitImpulse(time(t),time);
    end
end
end


%% Basic signal properties opperation
function pos=getPosition(ele,mat)
pos=find(mat==ele);
if isempty(pos)
    pos=0;
end
end