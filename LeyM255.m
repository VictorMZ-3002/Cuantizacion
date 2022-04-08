%[-8159:8159]

ts=(2*pi)/10000;
t=0:ts:2*pi;
muestrasX=8000*sin(t);
y=[];

for i=1:length(muestrasX)
xTemp=muestrasX(i);
if(xTemp < -8159 || xTemp > 8159)
    %disp('Fuera de intervalo')
else
    signo=sign(xTemp);
    if signo == 1
        bitSigno=0;
    else
        bitSigno=1;
    end
    x=abs(xTemp);
    flag=1;
end


for s1=0:7
    if(x < 64*(2^s1)-33)
        s=s1;
        break
    else
        continue
    end
end

if s == 0
    r=x;
    for Q1=0:15
        if r < (2*Q1)+1
            Q=Q1;
            break
        else
            continue
        end
    end
else
    r=x-((32)*(2^s)-33);
    for Q1=0:15
       if r < (2^(s+1))*(Q1+1)
           Q=Q1;
           break
       else
           continue
       end
    end
end
s=dec2bin(s,3);
q=dec2bin(Q,4);
bitSigno=dec2bin(bitSigno);

salida=['Signo: ', bitSigno, ' Segmento: ', s, ' Cuantizador: ', q];
%disp(salida)    

S=bin2dec(s);
Q=bin2dec(q);
y(i)=(((2*Q)+33)*(2^S)-33)*signo;
end

%Comparacion x - y
figure(1)
plot(t,muestrasX)
hold on
plot(t,y,'g')

%Grafica de error
e=muestrasX-y;
figure(2)
plot(t,e)

SQRdb=10*log10(mean(muestrasX.^2)/mean(e.^2));
    