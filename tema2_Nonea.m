P=40;%perioada
D =14;%durata impulsului
t=0:0.001:40;%esantionare
N=50;%numar de coeficienti
x_in= sawtooth(2*pi*(1/P)*t, 14/P)+1/2;%semnalul initial
fun=@(t)sawtooth(2*pi*(1/P)*t, 14/P)+1/2;
Co=1/P*integral(fun,0,P);%componenta continua
Ck= zeros(1,N);%initializare cu 0
Ak= zeros(1,N);%initializare cu 0
semnal_nou=Co;

for k= 1:1:N
    fun1=@(t)sawtooth(2*pi*(1/P)*t, 14/P).*exp(-1i*(k-25)*2*pi/P*t);
    Ck(k)=1/P*integral(fun1,0,P);
    semnal_nou = semnal_nou+Ck(k)*exp(1i*(k-25)*2*pi/P*t);%semnal refacut
    Ak(k+1)=2*abs(Ck(k));
end
Ak(26) = 2*abs(Co);%calculul armonicii fundamentale
subplot(2,1,1);
plot(t,x_in);
hold on;
plot(t,semnal_nou);
title('Semnal initial si semnal reconstruit');
subplot(2,1,2);
stem([1:51],Ak);
title('Spectru Amplitudini');
xlabel('w0');
ylabel('Amplitudine');
hold of;
%Seriile Fourier au multe utiliz?ri practice, pentru c? manipularea ?i
%conceptualizarea coeficien?ilor armonici sunt adesea mai u?oare decât lucrul cu func?ia original?.
%Conform cursului de SS, teoria seriilor Fourier
%orice semnal periodic poate fi aproximat printr-o suma infinita de sinusuri
%si cosinusuri de diferite frecvente, fiecare ponderat cu un anumit coeficient. 
%Acesti coeficienti reprezinta spectrul (amplitudinea pentru anumite frecvente).
%In aceasta tema semnalul reconstruit foloseste un numar finit de termeni si se apropie ca
%forma de semnalul original. Daca marim numarul de coeficienti ai SF,
%eroarea va fi mai mica, iar semnalul ar fi mai apropiat de ralitate.