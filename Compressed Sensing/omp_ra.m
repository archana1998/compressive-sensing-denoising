function [hat_y]=omp_ra(T,N,M,m,s)
hat_y=zeros(1,N);
Aug_t=[];
r_n=s;%%%%%%residue equals to measurement
for times=1:m                        %  iterative time 
    for col=1:N                      %  coloum number 
    product(col)=abs(T(:,col)'*r_n);  %  inner product 
    end 
    [val,pos]=max(product);          %  position 
Aug_t=[Aug_t,T(:,pos)]; % collected basis from maximum positions
T(:,pos)=zeros(M,1); %delete picked basis locations(set to zero) 
aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;            %  LSE 
r_n=s-Aug_t*aug_y;                             %  residual
pos_array(times)=pos;                    %  record position 
end 
hat_y(pos_array)=aug_y; 
end