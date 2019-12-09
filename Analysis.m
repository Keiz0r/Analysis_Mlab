[file,path] = uigetfile('*.txt');
Negative_up_to = input('Negative_up_to ');
Positive_up_to = input('Positive_up_to ');
Cycle_points = (Negative_up_to *-20)+1+(Positive_up_to*20);
x1 = 0:-0.1:Negative_up_to;
x2 = Negative_up_to+0.1:0.1:0;
x = [x1,x2];
x1 = 0.1:0.1:Positive_up_to;
x2 = Positive_up_to-0.1:-0.1:0;
x = [x,x1,x2]';
data = importdata(strcat(path,file));
Cycles=size(data)/Cycle_points;
Cycles = Cycles(1);
Ron_point = (Negative_up_to *-20)+4;
Roff_point = Cycle_points - 3;
for i = 1:(Cycles)
	Ron(i) = 0.3/data(Ron_point + (Cycle_points * (i-1)));
	Roff(i) = 0.3/data(Roff_point + (Cycle_points * (i-1)));
%	x = [x;x];
	end
Ron = Ron';	%not R but I
Roff = Roff';
dy = diff(data)*10;	%/0.1 make true derivative
dy2 = diff(dy)*10;

for j = 1:Cycles
	dy_test = 0;
	Vset(j) = 0;
	
	for i = 3 + (Cycle_points * (j-1)) : ((Negative_up_to *-10)+1) + (Cycle_points * (j-1))
		if dy2(i) <= -0.008
			Vset(j) = x(i+1 - (Cycle_points * (j-1)));
			break
		end
	end
end
Vset = Vset';

for j = 1:Cycles
	dy_test = 0;
	Vreset(j) = 0;
	for i = 3 + ((Negative_up_to *-20)+1) + (Cycle_points * (j-1)) : ((Negative_up_to *-20)+1) + (Positive_up_to*10) + (Cycle_points * (j-1)) -1
		temp = dy(i);
		if temp < dy_test
			dy_test = temp;
			Vreset(j) = x(i-0 - (Cycle_points * (j-1)));
		end
	end
end
Vreset = Vreset';

%histogram(Vreset(1:50),25)