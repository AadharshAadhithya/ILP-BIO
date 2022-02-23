function [x,edges] = invNearClique(A,k,d)

S = size(A);
N = S(1);
A_ = tril(A,-1)+triu(ones(N,1)*ones(1,N));
[r,c]= find(A_==0);

inverse_near_clique = optimproblem('ObjectiveSense',"minimize");

C = optimvar('C',N,'Type','integer','LowerBound',0,'UpperBound',1);
V = optimvar('V',length(r),'Type','integer','LowerBound',0,'UpperBound',1);
W = optimvar('W',1,'Type','integer',"LowerBound",0);
inverse_near_clique.Constraints.maxreq = sum(C)>=k+d;
inverse_near_clique.Constraints.minedge = sum(V)<=W;
inverse_near_clique.Constraints.edgeConstraint = C(r)+C(c)-V(1:length(r))<=1 ; 

inverse_near_clique.Objective = W;

sol = solve(inverse_near_clique);
x = sol;
eds = [r,c];
edges = eds(sol.V==1,:);

end