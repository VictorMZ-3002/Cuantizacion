%COMUNICACIONES DIGITALES
%Clase 23/03/2022 y 15/03/2022

t=0:2*pi/1000:2*pi;
x=sin(t);

%Intervalo de cuantización
q=0.0774;

for n=1:length(x)
    for k=-13:13
        if( x(n)>=k*q & x(n)<(k+1)*q )
           y(n)=(2*k+1)*q/2;
        end
    end
end

figure(1)
plot(t,x)
hold on
plot(t,y,'r')

%stairs evita pendientes que pueden ocurrir con el plot anterior
figure(2)
plot(t,x)
hold on
plot(t,y,'g')

%Error
e=x-y;
figure(3)
plot(t,e)

%Con teoría, se calculó que el intervalo de error va de -q/2 a q/2
min(e)
max(e)
stairs(t,y,'g')

SQRdb=10*log10(mean(x.^2)/mean(e.^2));

