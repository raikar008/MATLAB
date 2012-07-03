function [mwcn,wpixc, globmax]=localminW(w,nx,ny,psf)
% [mwcn,wpixc, globmax]=analyzeWconfPSF(w,nx,ny,psf)
% Finds local maxima in the results w (nx*ny,ncomp) convoluted with psf
% wpixc - w convolved with estimated PSF. 
% mwcn = image of local maxima (non zero pixels) with values of hte convoluted image, nornalised to the maximum of each column.  
% globmax = maximum of each column of W convolved with PSF. - PSF and W are L1 normalised - teh maximum can be used as a "quality measure."
%
% To get number of local maxima with relative strength < .5: sum(mwcn>.5)
ncomp=size(w,2);
autoconvmax=max(max(conv2(psf,psf,'same'))); % maximum of the "autoconvolution" - use to normalise the convolution with w.
wpix=reshape(w,nx, ny, ncomp); % each frame normalized to 1
wpixc=(convstack(wpix,psf,'same'));

wc=reshape(wpixc,nx*ny,ncomp);
mpix=maximastack(wpixc); % binary image of local maxima locations in each frame
m=reshape(mpix,nx*ny,ncomp);
mwc=m.*wc; % pixels indicates locations and value of hte local maxima
globmax=max(mwc)/autoconvmax; % The value of the global maximum for each column of W normalised with respect to the 'autoconvolution' of the PSF. 
mwcn=normcMax(mwc); % normalised to the maximum of each column. 