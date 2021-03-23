function [IRL,SH,THD,RNB,F,SLc,SLp]=FarinaExtractionAbsoluArray(Mesure,Reference,f1,f2,K,fig,Fs,P,N)
% Analyse de réponse en fréquence, distorsion et rub and buzz par la méthode de Farina.
% [SH,THD,RNB,F]=FarinaExtractionAbsolu(Mesure,Reference,f1,f2,K,fig);
% Arguments:
% Mesure contient le fichier .wav du résultat de la mesure.
% Reference contient le fichier .wav du sweep de référence (utilisé dans la mesure) qui
% doit être plus long que la mesure.
% f1 contient la fréquence initiale du sweep
% f2 contient la fréquence finale du sweep
% K est le nombre d'harmonique extraites dans l'analyse
% fig affiche des figures et provoque un breakpoint pour du debug
% 
% Sorties:
% SH est un vecteur de taille 4096 * K contenant les réponses linéaires de la fondamentale et des (K-1) harmoniques
% THD est un vecteur de taille 4096 contenant la racine de la somme des energies dans les bandes 2 à 6
% RNB est un vecteur de taille 4096 contenant la racine de la somme des energies dans les bandes 10 à K
% F est un vecteur de taille contenant les 4096 fréquences pour lesquelles les grandeurs précedentes ont été calculées.
% SLc : spectre complexe de la partie lineaire en sortie
% SLp : spectre reel
% 
% Le programme utilise la méthode de Farina pour extraire la réponses impulsionnelle principale et celle de toutes les harmoniques.
% On déconvolue d'abord les signaux pour extraire une réponse impulsionnelle étendue qui séparent toutes les réponses impulsionnelles
% (Propriétés log sweep)
% L'attaque de la réponse impulsionnelle est analysée par son max. On recale le début de la réponse impulsionnelle au début du fichiers.
% L'analyse est effectuée par fft sur 1024 points zéro paddé sur 4096 points
% Les fréquences de début et de fin sont utilisées pour déterminer quel sont les temps auquels aller chercher les réponses impulsionnelles des harmoniques


L=length(Reference);

if(L<length(Mesure))
    disp('Error Length');
    return;
end

if (size(Mesure,2)~=1 || size(Reference,2)~=1)
    disp('Error, this routine is designed for Mono signals')
    return;
end

Xm=fft(Mesure,L);
Xr=fft(Reference);

% Fonction de transfert
Q=Xm./Xr;

% Pondération pour toutes fréquences hors de l'intervalle [f1, f2], calcul
% pour fft sur les L points du signal de Référence
N1Q=floor(f1/Fs*L);
N2Q=floor(f2/Fs*L);
WQ=ones(L,1);
WQ([1:N1Q])=10^(-50);
WQ([N2Q:L-N2Q])=10^(-50);
WQ([L-N1Q+1:L])=10^(-50);

% Calcul de l'Impulse Response (pondérée)
IR=real(ifft(Q.*WQ));
IRLP=real(ifft(Q.*WQ));
IR=IRLP;

%Pondération pour toutes fréquences hors de l'intervalle [f1, f2], calcul
%pour fft sur N points pour ne garder que la partie linéaire
N1=floor(f1/Fs*N);
N2=floor(f2/Fs*N);
W=ones(N,1);
W([1:N1])=10^(-50);
W([N2:N-N2])=10^(-50);
W([N-N1+1:N])=10^(-50);

% Recalage sur le maximum - 1/10 de la fenêtre d'étude, pour avoir
% l'attaque
[Max,delayIndex]=max(abs(real(IR([1:L/2]))));
% delayIndex = max(delayIndex - floor(P/10),0);         % DESACTIVE PAR VU!
delayIndex = 0;

% Recalcul de l'Impulse Response Delayée
IRD=[IR([delayIndex+1:length(IR)]);IR([1:delayIndex])];
IRDLP=[IRLP([delayIndex+1:length(IR)]);IRLP([1:delayIndex])];

% Extraction Partie Linéaire, sur P points
IRL=IRD([1:P]);

%Calcul des Spectres complexes et Réel de la partie linéaire sur N points 
%(avec N-P points de padding de 0)
SLc=fft(IRL,N);
SL=abs(SLc.*W);
SLp=SL(1:N/2);
F=[0:N/2-1]*Fs/N;
F = transpose(F);

SLc = SLc(1:N/2);

if(fig)
    figure(14);
    plot(real(IR));
    hold on;
    plot([delayIndex+1,delayIndex+1],[-1,1],'r');
    plot([delayIndex+P,delayIndex+P],[-1,1],'r');    
    axis([1,length(IR),-Max,Max]);
    
    figure(15);
    plot(IRD);
    hold on;
    plot([1,1],[-1,1],'r');
    plot([P,P],[-1,1],'r');    
    axis([1,length(IR),-Max,Max]);    
    
    figure(16);
    subplot(211);
    semilogx(F,20*log10(SLp),'b');
    ylabel('dB');
    xlabel('Frequency');        
    
    axis([20,20000,-120,120]);
    hold on;
    grid on;    
    subplot(212);    
    semilogx(F,SLp,'k');
    ylabel('Lin');
    xlabel('Frequency');    
    %    axis([20,20000,0,]);    
    hold on;
    grid on;

    
end,

% Extraction Harmonique

T=L/Fs/2;
Rate=T/log(f2/f1);

IRH=zeros(K,P);
SH=zeros(K,N/2);
THD=zeros(1,N/2);
RNB=zeros(1,N/2);
SH(1,:)=SLp';
Leg=cell(K+1,1);

StartIndexPrec=L;

for k=2:K
    StartIndex = floor(L-(Rate*log(k)*Fs)*1.0);

    if( StartIndexPrec < (StartIndex + P) )
        WindowLength = StartIndexPrec - StartIndex;
        disp('Harmonics too close');
        disp(WindowLength);
    else
        WindowLength = P;
    end,
    StartIndexPrec=StartIndex;

    IRH=IRDLP([StartIndex:StartIndex+WindowLength-1]);
    
%    SHtemp=[0:N-1]';
%    SHtemp=SHtemp.*W;
   SHtemp=abs(fft(IRH,N)).*W;

    SHtemp([floor(N/2):N])=0;
    
    % dilatation des spectres des harmoniques pour avoir la même échelle de
    % fréquences
    SH(k,1)=SHtemp(k);
    for u=1:floor(N/2/k)
        SH(k,u+1)=SHtemp(u*k+1);
    end

    if(fig)
        figure(3);
        plot([StartIndex,StartIndex],[-1,1],'r');
        plot([StartIndex+WindowLength-1,StartIndex+WindowLength-1],[-1,1],'r');    
%        keyboard,
       
    end,

end;

if(fig)
  %  figure(3);
end,

for k=2:K
    if(fig)
        figure(4);
        semilogx(F,SH(k,:)./SH(1,:)*100,'color',[0,k/K,k/K],'LineWidth',1);
        hold on;        
        Leg(k-1)=mat2cell(['Ordre ',num2str(k)]);
    end,

    if(k<=6)
        THD = THD + SH(k,:).*SH(k,:);
    end,
    if(k>=7)
        RNB = RNB + SH(k,:).*SH(k,:);
    end,
end,

THD=sqrt(THD);
RNB=sqrt(RNB);

% if(fig)
%     semilogx(F,THD,'r','LineWidth',2);
%     Leg(K)=mat2cell('Distortion 1-6');
%     grid on;
%     axis([20,10000,0,10]);
%     ylabel('THD %');
%     xlabel('Frequency');
% 
%     if(K>15)
%         semilogx(F,RNB,'g','LineWidth',2);
%         hold on;
%     end,
%     Leg(K+1)=mat2cell('Rub n Buzz Indicator');
% 
%     legend(Leg);
% end,