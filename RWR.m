function[thisauc]=RWR(train,test,lambda)
       deg=repmat(sum(train,2),[1,size(train,2)]);
       train=train./deg;clear deg;
       I=sparse(eye(size(train,1)));
       sim=(1-lambda)*inv(I-lambda*train')*I;
       sim=sim+sim';
       train=spones(train);
       thisauc=CalcAUC(train,test,sim,110);
end