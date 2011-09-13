bg = 100;
dvec=0:.1:5;
for ii=1:length(dvec)
    
    d=dvec(ii);
    [logl, c1, c2, p] = computeLogLikelihood(d,bg);    
    llcut=(logl(find(fliplr(eye(size(logl))))))';
    [llmax(ii), pos] = max (llcut);
    d2llcut = gradient(gradient(llcut));
    h(ii)=d2llcut(pos);
end