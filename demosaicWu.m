function output=demosaicWu(A)

[N,M,ch]=size(A);
if ch==3
    B=zeros(N,M);
    B(1:2:N,1:2:M)=A(1:2:N,1:2:M,1);
    B(2:2:N,2:2:M)=A(2:2:N,2:2:M,3);
    B(1:2:N,2:2:M)=A(1:2:N,2:2:M,2);
    B(2:2:N,1:2:M)=A(2:2:N,1:2:M,2);
    A=B;
    clear B;
end

laplac=[-1/4 1/2 1/2 1/2 -1/4];
Ah=conv2(A,laplac);
Ah=Ah(:,3:2+M);
Av=conv2(A,laplac');
Av=Av(3:2+N,:);
dh=zeros(N,M);
dv=dh;
for i=2:2:N
   dh(i,1:2:M)=A(i,1:2:M)-Ah(i,1:2:M);
   dh(i,2:2:M)=Ah(i,2:2:M)-A(i,2:2:M);
   dv(i,1:2:M)=A(i,1:2:M)-Av(i,1:2:M);
   dv(i,2:2:M)=Av(i,2:2:M)-A(i,2:2:M);
end
for i=1:2:N
   dh(i,2:2:M)=A(i,2:2:M)-Ah(i,2:2:M);
   dh(i,1:2:M)=Ah(i,1:2:M)-A(i,1:2:M);
   dv(i,2:2:M)=A(i,2:2:M)-Av(i,2:2:M);
   dv(i,1:2:M)=Av(i,1:2:M)-A(i,1:2:M);
end
f=[4 9 15 23 26 23 15 9 4]/128;
adh=conv2(dh,f);
adh=adh(:,5:4+M);
adv=conv2(dv,f');
adv=adv(5:4+N,:);

s=4;
rAg=A;
for i=5:N-4
    for j=5:M-4
        if((mod(i,2)==0&&mod(j,2)==0)||(mod(i,2)==1&&mod(j,2)==1))
              th=dh(i,j-s:j+s);
              tv=dv(i-s:i+s,j);
              ath=adh(i,j-s:j+s);
              atv=adv(i-s:i+s,j);
              mh=ath(s+1);
              ph=cov(ath);
              Rh=mean((ath-th).^2)+0.1;
              h=mh+ph*(ph+Rh)^(-1)*(th(s+1)-mh);
              H=ph-ph*(ph+Rh)^(-1)*ph+0.1;

              mv=atv(s+1);
              pv=cov(atv);
              Rv=mean((atv-tv).^2)+0.1;
              v=mv+pv*(pv+Rv)^(-1)*(tv(s+1)-mv);
              V=pv-pv*(pv+Rv)^(-1)*pv+0.1;
              d=(V*h+H*v)/(H+V);
              rAg(i,j)=A(i,j)+d;
        end
    end
end
%R and B
rAr=A;rAb=A;
for i=6:2:N-5
   for j=5:2:M-5
      rAr(i,j+1)=rAg(i,j+1)-(rAg(i-1,j)-rAr(i-1,j)+rAg(i-1,j+2)-rAr(i-1,j+2)+rAg(i+1,j)-rAr(i+1,j)+rAg(i+1,j+2)-rAr(i+1,j+2))/4;
      rAb(i+1,j)=rAg(i+1,j)-(rAg(i,j-1)-rAb(i,j-1)+rAg(i,j+1)-rAb(i,j+1)+rAg(i+2,j-1)-rAb(i+2,j-1)+rAg(i+2,j+1)-rAb(i+2,j+1))/4;
  end
end

for i=6:2:N-5
   for j=5:2:M-5
      rAr(i,j)=rAg(i,j)-(rAg(i-1,j)-rAr(i-1,j)+rAg(i,j-1)-rAr(i,j-1)+rAg(i,j+1)-rAr(i,j+1)+rAg(i+1,j)-rAr(i+1,j))/4;
      rAb(i,j)=rAg(i,j)-(rAg(i-1,j)-rAb(i-1,j)+rAg(i,j-1)-rAb(i,j-1)+rAg(i,j+1)-rAb(i,j+1)+rAg(i+1,j)-rAb(i+1,j))/4;
      rAr(i+1,j+1)=rAg(i+1,j+1)-(rAg(i,j+1)-rAr(i,j+1)+rAg(i+1,j)-rAr(i+1,j)+rAg(i+1,j+2)-rAr(i+1,j+2)+rAg(i+2,j+1)-rAr(i+2,j+1))/4;
      rAb(i+1,j+1)=rAg(i+1,j+1)-(rAg(i,j+1)-rAb(i,j+1)+rAg(i+1,j)-rAb(i+1,j)+rAg(i+1,j+2)-rAb(i+1,j+2)+rAg(i+2,j+1)-rAb(i+2,j+1))/4;
   end
end

L=2^8-1;
rAr = round(rAr); 
ind = find(rAr>L); 
rAr(ind) = L; 
ind = find(rAr<0); 
rAr(ind) = 0; 

rAg = round(rAg); 
ind = find(rAg>L); 
rAg(ind) = L; 
ind = find(rAg<0); 
rAg(ind) = 0; 

rAb = round(rAb); 
ind = find(rAb>L); 
rAb(ind) = L; 
ind = find(rAb<0); 
rAb(ind) = 0; 

output(:,:,1) = rAr; 
output(:,:,2) = rAg; 
output(:,:,3) = rAb; 

end