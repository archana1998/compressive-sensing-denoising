function t = totient(n)
[r c]=size(n);
n=reshape(n,1,r*c);
t=zeros(1,r*c);
f=zeros(1,10);
for k=1:r*c
    nk=n(k);
    f=unique(factor(nk));
    t(k)=nk*prod(1-1./f);
end
t=reshape(t,r,c);
p=find(n==1);
t(p)=1;
t=round(t);
end