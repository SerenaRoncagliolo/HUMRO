function f = test_periodic(X)
%% f is P(X*)- X*

X(1)=mod(X(1),2*pi);
b=P(X)';
b(1) = mod(b(1),2*pi);

f=b-X;
end

