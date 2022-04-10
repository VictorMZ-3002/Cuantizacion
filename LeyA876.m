ts=(2*pi)/10000;
t=0:ts:2*pi;
A=4096/sqrt(2);
muestrasX=A*sin(t);
y=[];

for i=1:length(muestrasX)
xTemp=muestrasX(i);
    if(xTemp <= -4096 || xTemp >= 4096)
        %disp('Fuera de intervalo')
    else
        signo=sign(xTemp);
        if signo == 1
            bitSigno=0;
        else
            bitSigno=1;
        end
        x=abs(xTemp);
    end


    for s1=0:7
        if(x < 32*(2^s1))
            s=s1;
            break
        else
            continue
        end
    end

    if s == 0
        r=x;
        for Q1=0:15
            if r < 2*(Q1+1)
                Q=Q1;
                break
            else
                continue
            end
        end
        y(i)=signo*(2*Q)+1;
    else
        r=x-16*(2^s);
        for Q1=0:15
            if r < (2^s)*(Q1+1)
                Q=Q1;
                break
            else
                continue
            end
        end
        y(i)=(2^s)*(Q+16.5)*signo;
    end
s=dec2bin(s,3);
q=dec2bin(Q,4);
bitSigno=dec2bin(bitSigno);

%salida=['Signo: ', bitSigno, ' Segmento: ', s, ' Cuantizador: ', q];
%disp(salida)    

%S=bin2dec(s);
%Q=bin2dec(q);
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

SQRdB=10*log10(mean(muestrasX.^2)/mean(e.^2))
